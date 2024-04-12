#!/usr/bin/env bash
# Copyright 2023-2024 Broadcom. All rights reserved.
# SPDX-License-Identifier: BSD-2

follow_link() {
    file="$1"
    while [ -L "$file" ]; do
        file=$(readlink "$file")
    done
    echo "$file"
}

# Get the script path.
script_path=$(realpath "$(dirname "$(follow_link "$0")")")

# Set the default values for the variables.
json_path="project.json"
os_names=$(jq -r '.os[] | .name' $json_path)
os_array=($os_names)

# Get the project information from the JSON file.
get_project_info() {
    local field=$1
    jq -r ".project.${field}" $json_path
}

# Get the settings from the JSON file.
get_settings() {
    local field=$1
    jq -r ".settings.${field}" $json_path
}

# Get the settings from the JSON file.
iso_base_path=$(get_settings "iso_base_path")
rename_iso=$(get_settings "rename_iso")
cleanup_failed_iso_verification=$(get_settings "cleanup_failed_iso_verification")

# This function prompts the user to press Enter to continue.
press_enter() {
    cd "$script_path"
    printf "Press \033[32mEnter\033[0m to continue.\n"
    read -r
    exec $0
}

# This function displays the information about the script and project.
info() {
    project_name=$(get_project_info "name")
    project_description=$(get_project_info "description")
    project_version=$(get_project_info "version")
    project_license=$(get_project_info "license[0].name")
    project_github_url=$(get_project_info "urls.github")
    project_docs_url=$(get_project_info "urls.documentation")
    clear
    printf "\033[32m$project_name\033[0m: \033[34m$project_version\033[0m\n\n"
    printf "Copyright 2023-$(date +%Y) Broadcom. All Rights Reserved.\n\n"
    printf "License: $project_license\n\n"
    printf "$project_description\n\n"
    printf "GitHub Repository: $project_github_url\n"
    printf "Documentation: $project_docs_url\n\n"
    show_help "continue"
    press_enter
}

# This function checks if a command is installed.
check_command() {
    local cmd=$1
    if command -v $cmd >/dev/null 2>&1; then
        local version=$($cmd --version | head -n 1)
        print_message success "$cmd is installed."
    else
        print_message error "$cmd is not installed."
        exit 1
    fi
}

# This function checks if the required dependencies are installed.
check_dependencies() {
    check_command curl
    check_command wget
    check_command jq
    printf "\nPress \033[32mEnter\033[0m to continue."
    read -r input
    if [[ -z "$input" ]]; then
        break
    else
        printf "\nPress \033[32mEnter\033[0m to continue."
    fi
}

# This function displays the help message.
show_help() {
    local exit_after=${1:-"exit"}
    script_name=$(basename $0)
    printf "Usage: $script_name [options]\n\n"
    printf "Options:\n"
    printf "  --deps, -d, -D       Check the dependencies.\n"
    printf "  --json, -j, -J       Specify the JSON file path.\n"
    printf "  --help, -h, -H       Display this help message.\n\n"
    printf "Note: You can set an environment variable for the Red Hat Subscription Manager offline\n"
    printf "      token to simplify downloading Red Hat Enterprise Linux.\n\n"
    printf '      \033[32mexport rhsm_offline_token="your_rhsm_offline_token_value"\033[0m\n\n'
    if [[ -z "$input" ]]; then
        [ "$exit_after" = "exit" ] && exit 0
    else
        printf "Press \033[32mEnter\033[0m to continue."
    fi
}

# This function prompts the user to go back or quit.
prompt_user() {
    printf "Enter \033[32mb\033[0m to go back, or \033[31mq\033[0m to quit.\n\n"
}

# This function prints a message to the console based on the message type.
print_message() {
    local type=$1
    local message=$2

    case $type in
    error)
        printf "\033[31mError:\033[0m %b \n" "$message"
        ;;
    success)
        printf "\033[32mSuccess:\033[0m %b \n" "$message"
        ;;
    skipped)
        printf "\033[33mSkipping:\033[0m %b \n" "$message"
        ;;
    download)
        printf "\033[32mDownloading:\033[0m %b \n" "$message"
        ;;
    rename)
        printf "\033[32mRenaming:\033[0m %b \n" "$message"
        ;;
    remove)
        printf "\033[32mRemoving:\033[0m %b \n" "$message"
        ;;
    verify)
        printf "\033[32mVerifying:\033[0m %b \n" "$message"
        ;;
    invalid)
        printf "\033[33mInvalid Selection:\033[0m %b \n" "$message"
        ;;
    failed)
        printf "\033[31mFailed:\033[0m %b \n" "$message"
        ;;
    info)
        printf "$message"
        ;;
    *)
        printf "$message"
        ;;
    esac
}

# This function selects the guest operating system family.
# Only `Linux`` and `Windows`` are supported presently in the JSON file.
select_os() {
    clear
    printf "\nSelect a guest operating system:\n\n"
    for i in "${!os_array[@]}"; do
        printf "$((i + 1)): ${os_array[$i]}\n"
    done
    printf "\nEnter \033[31mq\033[0m to quit or \033[34mi\033[0m for info.\n\n"

    while true; do
        read -p "Select a guest operating system: " os_input
        if [[ $os_input == [qQ] ]]; then
            exit 0
        elif [[ $os_input == [iI] ]]; then
            info
        elif ((os_input >= 1 && os_input <= ${#os_array[@]})); then
            os=${os_array[$((os_input - 1))]}
            select_distribution
            break
        else
            printf "\n"
            print_message invalid "Enter a number between 1 and ${#os_array[@]}."
            printf "\n"
        fi
    done
}

select_distribution() {
    # Check if the selected guest operating system is Linux or Windows.
    case "$os" in
    "Linux")
        dist_descriptions=$(jq -r --arg os "$os" '.os[] | select(.name == $os) | .distributions[] | .description' $json_path)
        ;;
    "Windows")
        dist_descriptions=$(jq -r --arg os "$os" '.os[] | select(.name == $os) | .types[] | .description' $json_path)
        ;;
    *)
        print_message error "Unsupported guest operating system. Exiting..."
        ;;
    esac

    # Check if the distribution descriptions are empty.
    if [ -z "$dist_descriptions" ]; then
        printf "\nNo distributions found for $os.\n"
        select_os
        return
    fi

    # Convert the distribution descriptions to an array.
    IFS=$'\n' read -rd '' -a dist_array <<<"$dist_descriptions"

    # Sort the array.
    IFS=$'\n' dist_array=($(sort <<<"${dist_array[*]}"))
    unset IFS

    # Print the submenu.
    clear
    printf "\nSelect a $([[ "$os" == "Windows" ]] && echo "$os type" || echo "$os distribution"):\n\n"
    for i in "${!dist_array[@]}"; do
        printf "$((i + 1)): ${dist_array[$i]}\n"
    done
    printf "\n"
    prompt_user

    while true; do
        read -p "Enter a number of the $([[ "$os" == "Windows" ]] && echo "$os type" || echo "$os distribution"): " dist_input
        if [[ $dist_input == [qQ] ]]; then
            exit 0
        elif [[ $dist_input == [bB] ]]; then
            select_os
            break
        elif ((dist_input >= 1 && dist_input <= ${#dist_array[@]})); then
            dist=${dist_array[$((dist_input - 1))]}
            select_version
            break
        else
            printf "\n"
            print_message invalid "Enter a number between 1 and ${#dist_array[@]}.\n"
            prompt_user
        fi
    done
}

# This function selects the version based on the guest operating system's distribution or type.
select_version() {
    # Check if the selected distribution is SUSE Linux Enterprise Server.
    # SUSE Linux Enterprise Server is not available for download using this script.
    if [ "$dist" == "SUSE Linux Enterprise Server" ]; then
        printf "\nSUSE Linux Enterprise Server \033[31mis not\033[0m available for download using this script.\n\n"
        press_enter
    fi

    # Check if the selected guest operating system is Windows.
    if [[ "$dist" == *"Windows"* ]]; then
        # Parse the JSON file to get the versions for the selected distribution Windows
        version_descriptions=$(jq -r --arg os "$os" --arg dist "$dist" '.os[] | select(.name == $os) | .types[] | select(.description == $dist) | .versions | keys[]' $json_path)
    else
        version_descriptions=$(jq -r --arg os "$os" --arg dist "$dist" '.os[] | select(.name == $os) | .distributions[] | select(.description == $dist) | .versions | to_entries[] | .value[].version' $json_path)
    fi

    # Convert the version descriptions to an array and sort it in descending order.
    IFS=$'\n' read -rd '' -a version_array <<<"$(echo "$version_descriptions" | sort -r)"

    # Print the submenu.
    clear
    printf "\nSelect a version:\n\n"
    for i in "${!version_array[@]}"; do
        printf "$((i + 1)): $dist ${version_array[$i]}\n"
    done
    printf "\n"
    prompt_user

    # Select a version.
    while true; do
        read -p "Select a version: " version_input
        if [[ "$version_input" == [qQ] ]]; then
            exit 0
        elif [[ $version_input == [bB] ]]; then
            select_distribution
            break
        elif ((version_input >= 1 && version_input <= ${#version_array[@]})); then
            version=${version_array[$((version_input - 1))]}
            select_arch_names
            break
        elif ((version_input == ${#version_array[@]} + 1)); then
            for version in "${version_array[@]}"; do
                select_arch_names
            done
            break
        else
            printf "\n"
            print_message invalid "Enter a number between 1 and ${#version_array[@]}.\n"
            prompt_user
        fi
    done
}

# This function selects the architecture based on the guest operating system's distribution or type.
# Only `amd64` and `arm64` architectures are supported presently in the JSON file.
select_arch_names() {
    # Check if the selected guest operating system is Linux or Windows..
    if [[ "$os" == *"Linux"* ]]; then
        arch_names=$(jq -r --arg os "$os" --arg dist "$dist" --arg version "$version" '.os[] | select(.name == $os) | .distributions[] | select(.description == $dist) | .versions | to_entries[] | .value[] | select(.version == $version) | .architectures[].architecture' $json_path)
    elif [[ "$dist" == *"Windows"* ]]; then
        arch_names=$(jq -r --arg os "$os" --arg dist "$dist" --arg version "$version" '.os[] | select(.name == $os) | .types[] | select(.description == $dist) | .versions[$version][] | .architectures[] | .architecture' $json_path)
    fi

    # Convert the architecture names to an array..
    arch_array=($arch_names)

    # Print the submenu.
    if [[ ${#arch_array[@]} -eq 1 ]]; then
        arch=${arch_array[0]}
        select_download
    else
        clear
        print "\nSelect an architecture:\n\n"
        for i in "${!arch_array[@]}"; do
            print "$((i + 1)): ${arch_array[$i]}\n"
        done
        printf "\n"
        prompt_user

        while true; do
            printf "\n"
            read -p "Select an architecture: " arch_number
            if [[ "$arch_number" == [qQ] ]]; then
                exit 0
            elif [[ "$arch_number" == [bB] ]]; then
                select_version
                break
            elif ((arch_number >= 1 && arch_number <= ${#arch_array[@]})); then
                arch=${arch_array[$((arch_number - 1))]}
                select_download
                break
            else
                printf "\n"
                print_message invalid "Enter a number between 1 and ${#arch_array[@]}.\n"
                prompt_user
            fi
        done
    fi
}

# This function downloads the selected ISO image based on the guest operating system's distribution
# or type, version, and architecture.
select_download() {
    # Check if the selected guest operating system is Windows.
    if [[ "$dist" == *"Windows"* ]]; then
        download_link=$(jq -r --arg os "$os" --arg dist "$dist" --arg version "$version" --arg arch "$arch" '.os[] | select(.name == $os) | .types[] | select(.description == $dist) | .versions[$version][] | .architectures[] | select(.architecture == $arch) | .download_link' $json_path)
        download_dir="$(echo "${iso_base_path}/${os}/${dist}/${version}/${arch}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
        mkdir -p "$download_dir"

        file_name=$(basename "$download_link")
        full_path="$download_dir/$file_name"

        printf "\n"
        print_message download "\033[34m$file_name\033[0m => \033[34m$download_dir\033[0m.\n"

        # Set the download command based on the availability of curl or wget.
        if command -v curl >/dev/null 2>&1; then
            download_command="curl -o"
        elif command -v wget >/dev/null 2>&1; then
            download_command="wget -q -O "
        fi
        if [ -z "$download_command" ]; then
            print_message error "Neither curl or wget is installed."
            exit 1
        fi
        $download_command "$full_path" "$download_link"
        checksum_value=$(jq -r --arg os "$os" --arg dist "$dist" --arg version "$version" --arg arch "$arch" '.os[] | select(.name == $os) | .types[] | select(.description == $dist) | .versions[$version][] | .architectures[] | select(.architecture == $arch) | .checksum' $json_path)
        checksum_algorithm=$(jq -r --arg os "$os" --arg dist "$dist" --arg version "$version" --arg arch "$arch" '.os[] | select(.name == $os) | .types[] | select(.description == $dist) | .versions[$version][] | .architectures[] | select(.architecture == $arch)  | .checksum_algorithm' $json_path)

    # Check if the selected guest operating system idistribution is Red Hat Enterprise Linux.
    # Red Hat Enterprise Linux must be downloaded from Red Hat Subscription Manager using the API.
    elif [[ "$dist" == *"Red Hat"* ]]; then
        checksum_rhel=$(jq -r --arg os "$os" --arg dist "$dist" --arg version "$version" --arg arch "$arch" '.os[] | select(.name == $os) | .distributions[] | select(.description == $dist) | .versions | to_entries[] | .value[] | select(.version == $version) | .architectures[] | select(.architecture == $arch) | .checksum' $json_path)

        # If the 'rhsm_offline_token' is not provided as an environment variable, prompt the user to enter it.
        invalid_attempts=0
        while true; do
            if [[ -z "${rhsm_offline_token}" ]]; then
                printf "\n"
                read -sp "Enter your Red Hat Subscription Manager offline token: " rhsm_offline_token
                printf "\n"
                read -sp "Enter your Red Hat Subscription Manager offline token again: " rhsm_offline_token_verify
                printf "\n"
            else
                rhsm_offline_token_verify=$rhsm_offline_token
            fi

            if [ -z "$rhsm_offline_token" ] || [ -z "$rhsm_offline_token_verify" ]; then
                printf "\n\n"
                print_message error "The tokens are blank. Returning to version selection.\n"
                sleep 2
                select_version
            elif [ "$rhsm_offline_token" != "$rhsm_offline_token_verify" ]; then
                printf "\n\n"
                print_message error "Tokens do not match. Please try again.\n"
                invalid_attempts=$((invalid_attempts + 1))
            elif [[ ! $rhsm_offline_token =~ ^[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+$ ]]; then
                printf "\n\n"
                print_message error "Invalid token format. Please try again.\n"
                invalid_attempts=$((invalid_attempts + 1))
		rhsm_offline_token=""
            else
                break
            fi

            if [[ $invalid_attempts -ge 3 ]]; then
                printf "\n"
                print_message error "Too many invalid attempts. Returning to version selection.\n"
                sleep 2
                select_version
	        return
	
            fi
        done

        # Get the access token from the Red Hat API.
        access_token=$(curl -s https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token -d grant_type=refresh_token -d client_id=rhsm-api -d refresh_token=$rhsm_offline_token 2>/dev/null | jq -r '.access_token')

        # Clear the token variables to force the user to enter them again.
        rhsm_offline_token=""
        rhsm_offline_token_verify=""

        # Get the filename and download url from the Red Hat API.
        image=$(curl -s -H "Authorization: Bearer $access_token" "https://api.access.redhat.com/management/v1/images/$checksum_rhel/download")
        file_name=$(echo $image | jq -r .body.filename)
        download_link=$(echo $image | jq -r .body.href)
        download_dir="$(echo "${iso_base_path}/${os}/${dist}/${version}/${arch}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
        mkdir -p "$download_dir"

        # Set the full path of the downloaded file.
        full_path="$download_dir/$file_name"

        printf "\n"
        print_message download "\033[34m$file_name\033[0m => \033[34m$download_dir\033[0m.\n"

        # Set the download command based on the availability of curl or wget.
        if command -v curl >/dev/null 2>&1; then
            download_command="curl -o"
        elif command -v wget >/dev/null 2>&1; then
            download_command="wget -q -O"
        fi

        # Check if curl or wget is installed.
        if [ -z "$download_command" ]; then
            echo
            print_message error "Neither curl or wget is installed."
            exit 1
        fi

        # Download the file.
        $download_command "$full_path" "$download_link"

    # Check if the selected guest operating system is Linux.
    elif [[ "$os" == *"Linux"* ]]; then
        dist_name=$(jq -r --arg os "$os" --arg desc "$description" '.os[] | select(.name == $os) | .distributions[] | select(.description == $desc) | .name' $json_path)
        download_link=$(jq -r --arg os "$os" --arg dist "$dist" --arg version "$version" --arg arch "$arch" '.os[] | select(.name == $os) | .distributions[] | select(.description == $dist) | .versions | to_entries[] | .value[] | select(.version == $version) | .architectures[] | select(.architecture == $arch) | .download_link' $json_path)
        download_dir="$(echo "${iso_base_path}/${os}/${dist}/${version}/${arch}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
        mkdir -p "$download_dir"

        # Set the full path of the downloaded file.
        file_name=$(basename "$download_link")
        full_path="$download_dir/$file_name"

        printf "\n"
        print_message download "\033[34m$file_name\033[0m => \033[34m$download_dir\033[0m.\n"

        # Set the download command based on the availability of curl or wget.
        if command -v curl >/dev/null 2>&1; then
            download_command="curl -o"
        elif command -v wget >/dev/null 2>&1; then
            download_command="wget -q -O"
        fi

        # Check if curl or wget is installed.
        if [ -z "$download_command" ]; then
            print_message error "Neither curl or wget is installed."
            exit 1
        fi

        # Download the file.
        $download_command "$full_path" "$download_link"
        checksum_value=$(jq -r --arg os "$os" --arg dist "$dist" --arg version "$version" --arg arch "$arch" '.os[] | select(.name == $os) | .distributions[] | select(.description == $dist) | .versions | to_entries[] | .value[] | select(.version == $version) | .architectures[] | select(.architecture == $arch) | .checksum' $json_path)
        checksum_algorithm=$(jq -r --arg os "$os" --arg dist "$dist" --arg version "$version" --arg arch "$arch" '.os[] | select(.name == $os) | .distributions[] | select(.description == $dist) | .versions | to_entries[] | .value[] | select(.version == $version) | .architectures[] | select(.architecture == $arch)  | .checksum_algorithm' $json_path)
    fi

    case "$os" in
    "Linux")
        # Download the checksum file.
        download_checksum_file
        # Extract the checksum from the checksum file.
        extract_checksum
        # Calculate the checksum of the downloaded file.
        calculate_checksum
        # Compare the actual checksum with the expected checksum.
        compare_checksums
        ;;
    "Windows")
        printf "\n"
        ;;
    *)
        print_message error "Unsupported guest operating system: \033[34m$os\033[0m"
        exit 1
        ;;
    esac

    # Rename the downloaded file.
    if $rename_iso; then
        rename_file
    fi
}

# This function downloads the checksum file from the link.
download_checksum_file() {
    # Check if the operating system is Windows. If so, skip the verification of the checksum.
    # The Microsoft Windows Evaluation Center does not provide checksums.
    if [[ "$os" == *"Windows"* ]]; then
        return
    fi

    # Set the checksum file path.
    checksum_file="$download_dir/checksum"

    # Check if the selected guest operating system is Red Hat Enterprise Linux.
    # If so, set the checksum value to the checksum for Red Hat Enterprise Linux.
    if [[ "$dist" == *"Red Hat"* ]]; then
        checksum_value=$checksum_rhel
    fi

    # Check if the checksum value is empty.
    if [ -z "$checksum_value" ]; then
        print_message skipped "The checksum value is empty."
        return
    fi

    # If checksum_value is a URL, download the file. Otherwise, write the value to the file.
    if [[ "$checksum_value" =~ ^http[s]?:// ]]; then
        # Set the download command based on the availability of curl or wget.
        download_command=""
        if command -v curl >/dev/null 2>&1; then
            download_command="curl -o"
        elif command -v wget >/dev/null 2>&1; then
            download_command="wget -q -O "
        fi

        # Check if curl or wget is installed.
        if [ -z "$download_command" ]; then
            print_message error "Neither curl or wget is installed."
            exit 1
        fi

        # Download the file based on the checksum using the Red Hat API.
        $download_command "$checksum_file" "$checksum_value"
    else
        echo "$checksum_value" >"$checksum_file"
        checksum_value_manual=true
    fi
}
# This function extracts the checksum from the checksum file.
extract_checksum() {
    # Check if the operating system is Windows. If so, skip the verification of the checksum.
    # The Microsoft Windows Evaluation Center does not provide checksums.
    if [[ "$os" == *"Windows"* ]]; then
        return
    fi

    # Extract the checksum based on the guest operating system.
   case "${dist}" in
    "Ubuntu Server")
        # Checksum extraction for Ubuntu Server
        expected_checksum=$(grep "$file_name" "$checksum_file" | awk '{print $1}')
    ;;
    "Oracle Linux")
        # Checksum extraction for Oracle Linux
        expected_checksum=$(grep "$file_name" "$checksum_file" | awk '{print $1}')
    ;;
    "Debian")
        # Checksum extraction for Debian
        expected_checksum=$(grep "$file_name" "$checksum_file" | awk '{print $1}')
    ;;
*)  
  case "${dist}${version}" in
  "CentOS7")
        expected_checksum=$(grep "$file_name" "$checksum_file" | awk '{print $1}')
    ;;
*)
    if [ ! -f "$checksum_file" ]; then
            print_message skipped "The checksum file is empty."
            checksum_value_empty=true
        elif [ "$checksum_value_manual" = true ]; then
            expected_checksum=$(cat "$checksum_file")
        else
            expected_checksum=$(grep "$file_name" "$checksum_file" | awk -F'=' '{print $2}' | tr -d ' \n')
        fi
        ;;
    esac
    ;;
  esac
}

# This function calculates the checksum of the downloaded file.
calculate_checksum() {
    # Check if the operating system is Windows. If so, skip the verification of the checksum.
    # The Microsoft Windows Evaluation Center does not provide checksums.
    if [[ "$os" == *"Windows"* ]]; then
        return
    fi

    # Get the checksum algorithm based on the guest operating system.
    case "$os" in
    "Linux")
        checksum_algorithm=$(jq -r --arg os "$os" --arg dist "$dist" --arg version "$version" --arg arch "$arch" '.os[] | select(.name == $os) | .distributions[] | select(.description == $dist) | .versions | to_entries[] | .value[] | select(.version == $version) | .architectures[] | select(.architecture == $arch) | .checksum_algorithm' $json_path)
        ;;
    "Windows")
        checksum_algorithm=$(jq -r --arg os "$os" --arg dist "$dist" --arg version "$version" --arg arch "$arch" '.os[] | select(.name == $os) | .types[] | select(.description == $dist) | .versions | to_entries[] | .value[] | select(.version == $version) | .architectures[] | select(.architecture == $arch) | .checksum_algorithm' $json_path)
        ;;
    *)
        print_message error "Unsupported guest operating system: \033[34m$$os\033[0m"
        exit 1
        ;;
    esac

    # Convert the checksum algorithm to lowercase.
    checksum_algorithm=$(echo "$checksum_algorithm" | tr '[:upper:]' '[:lower:]')

    # Calculate the checksum based on the checksum algorithm.
    case "$checksum_algorithm" in
    "sha256")
        actual_checksum=$(sha256sum "$full_path" | awk '{print $1}')
        ;;
    "sha512")
        actual_checksum=$(sha512sum "$full_path" | awk '{print $1}')
        ;;
    "sha1")
        actual_checksum=$(sha1sum "$full_path" | awk '{print $1}')
        ;;
    "md5")
        actual_checksum=$(md5sum "$full_path" | awk '{print $1}')
        ;;
    *)
        print_message error "Unsupported checksum algorithm: \033[34m$checksum_algorithm\033[0m"
        exit 1
        ;;
    esac
}

# This function compares the actual checksum with the expected checksum.
compare_checksums() {
    # Check if the operating system is Windows. If so, skip the verification of the checksum.
    # The Microsoft Windows Evaluation Center does not provide checksums.
    if [[ "$os" == *"Windows"* ]]; then
        return
    fi

    printf "\n"
    # Check if the checksum value is empty.
    if [ "$checksum_value_empty" != true ]; then
        print_message verify "\033[34m$checksum_algorithm\033[0m checksum for \033[34m$file_name\033[0m.\n"
        # Compare the actual checksum with the expected checksum.
        if [ "$actual_checksum" = "$expected_checksum" ]; then
            print_message success "Verification of checksum \033[32msuccessful\033[0m for \033[34m$file_name\033[0m.\n"
            print_message info "        - \033[32mExpected:\033[0m \033[34m$expected_checksum\033[0m\n"
            print_message info "        - \033[32mActual:\033[0m   \033[34m$actual_checksum\033[0m\n\n"
        else
            print_message failed "Verification of checksum \033[31mfailed\033[0m for \033[34m$file_name\033[0m.\n"
            print_message info "        - \033[32mExpected:\033[0m \033[34m$expected_checksum\033[0m\n"
            print_message info "        - \033[31mActual:\033[0m   \033[34m$actual_checksum\033[0m\n\n"
            print_message error "Download \033[1m\033[31mfailed\033[0m\n for \033[34m$dist $version $arch\033[0m.\n"

            if $get_setting_cleanup_failed_iso; then
                # Attempt to remove the downloaded ISO file.
                rm -f "$full_path"
                # Check if the file still exists.
                if [ -f "$full_path" ]; then
                    print_message info "        - \033[31mFailed to remove: \033[0m \033[34m"$download_dir/$file_name"\033[0m.\n"
                    return
                else
                    print_message info "        - \033[32mRemoved:\033[0m \033[34m"$download_dir/$file_name"\033[0m.\n"
                fi

                # If the selected guest operating system is Red Hat Enterprise Linux, skip the
                # removal of the checksum file as it will not exist.
                if [[ "$dist" == *"Red Hat"* ]]; then
                    return
                fi

                # Attempt to remove the checksum file.
                rm -f "$checksum_file"

                # Check if the file still exists.
                if [ -f "$checksum_file" ]; then
                    print_message info "        - \033[31mFailed to remove:\033[0m \033[34m$checksum_file\033[0m.\n"
                    return
                else
                    print_message info "        - \033[32mRemoved:\033[0m \033[34m$checksum_file\033[0m."
                fi
            fi
            printf "\n\n"
            press_enter
        fi
    fi
}

# This function renames a downloaded file based on the distribution/type, version, and architecture.
rename_file() {
    # Check if the operating system is Linux or Windows.
    if [[ "$os" == *"Linux"* ]] || [[ "$os" == *"Windows"* ]]; then
        # Switch to the download directory.
        cd "$download_dir"

        # Check if the file exists.
        if [[ ! -f "$file_name" ]]; then
            print_message error "File does not exist: \033[34m$file_name\033[0m"
        fi

        # Rename the file based on the distribution or type, version, and architecture.
        case "$arch" in
        "amd64") iso_name="$(echo "$dist-$version-x86-64.iso" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')" ;;
        "arm64") iso_name="$(echo "$dist-$version-aarch64.iso" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')" ;;
        *) print_message error "Unsupported architecture: \033[34m$arch\033[0m" ;;
        esac

        # Rename the file.
        mv "$file_name" "$iso_name"
        print_message rename "\033[34m$file_name\033[0m => \033[34m$iso_name\033[0m.\n"
    else
        print_message error "Unsupported guest operating system: \033[34m$os\033[0m"
    fi
}

# Check if the script is run with the --deps option.
while (("$#")); do
    case "$1" in
    --json | -j | -J)
        json_path="$2"
        shift 2
        ;;
    --deps | -d | -D)
        check_dependencies
        shift
        ;;
    --help | -h | -H)
        show_help
        shift
        ;;
    *)
        print_message error "Unknown option: \033[34m$1\033[0m"
        exit 1
        ;;
    esac
done

# Start the script with the selecting the guest operating system.
select_os

# Prompt the user to continue or quit.
while true; do
    print_message success "Download completed successfully for $dist $version $arch.\n"
    read -p $'Would you like to (\e[32mc\e[0m)ontinue or (\e[31mq\e[0m)uit? ' action
    case $action in
    [cC]*)
        cd "$script_path" || {
            print_message error "Failed to change to directory: \033[34m$script_path\033[0m"
            exit 1
        }
        exec $0
        ;;
    [qQ]*) exit ;;
    esac
done

# TODO:
# - Add support for headless logging with timestamps.
# - Add support to check if the ISO file exists and if the checksum file is valid before downloading the file.
# - Add support for SUSE Enterprise Linux Server download. Headless Chrome?
# - Add support for checking the download links for availability, but do not download the files.
