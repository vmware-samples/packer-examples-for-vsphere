#!/usr/bin/env bash
# © Broadcom. All Rights Reserved.
# The term “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-2-Clause

follow_link() {
    file="$1"
    while [ -L "$file" ]; do
        file=$(readlink "$file")
    done
    echo "$file"
}

# Get the script path.
script_path=$(realpath "$(dirname "$(follow_link "$0")")")

run_check_dependencies=false
run_check_jq=false
run_show_help=false

# This function prompts the user to press Enter to continue.
press_enter_continue() {
    printf "Press \033[32mEnter\033[0m to continue.\n"
    read -r
    exec "$0"
}

# This function prompts the user to press Enter to exit.
press_enter_exit() {
    printf "Press \033[31mEnter\033[0m to exit.\n"
    read -r
    exit 0
}

if [ $# -eq 0 ]; then
    run_check_jq=true
fi

while (("$#")); do
    case "$1" in
    --json | -j | -J)
        json_path="$2"
        run_check_jq=true
        shift 2
        ;;
    --deps | -d | -D)
        run_check_dependencies=true
        shift
        ;;
    --help | -h | -H)
        run_show_help=true
        shift
        ;;
    *)
        printf "\033[33mInvalid Option:\033[0m $1\n\n"
        press_enter_exit
        ;;
    esac
done

# This function checks if the required dependencies are installed.
check_dependencies() {
    local cmd
    local RED='\033[0;31m'
    local GREEN='\033[0;32m'
    local NC='\033[0m' # No Color
    local CHECKMARK="${GREEN}[✔]${NC}"
    local CROSSMARK="${RED}[✘]${NC}"
    local missing_deps=false
    local http_client_installed=false

    for cmd in jq wget curl; do
        if command -v $cmd &>/dev/null; then
            if [ "$cmd" = "wget" ] || [ "$cmd" = "curl" ]; then
                http_client_installed=true
            fi
            echo -e "$CHECKMARK $cmd is installed."
        else
            if [ "$cmd" = "jq" ]; then
                missing_deps=true
                echo -e "$CROSSMARK $cmd is not installed."
            fi
        fi
    done

    if ! $http_client_installed; then
        printf "\033[0;31m[✘]\033[0m Neither \033[0;31mwget\033[0m nor \033[0;31mcurl\033[0m is installed.\n"
        missing_deps=true
    fi

    if $missing_deps; then
        printf "\n"
        press_enter_exit
    else
        printf "\n"
        press_enter_continue
    fi
}

# After the loop, check if check_dependencies needs to be run
if $run_check_dependencies; then
    check_dependencies
fi

# Check for jq
check_jq() {
    if ! command -v jq &>/dev/null; then
        echo -e "\033[0;31m[✘]\033[0m jq is not installed."
        exit 1
    fi
}

# After the loop, check if check_jq needs to be run
if $run_check_jq; then
    check_jq
fi

# This function displays the help message.
show_help() {
    script_name=$(basename $0)
    printf "\nOptions:\n"
    printf "  --deps, -d, -D       Check the dependencies.\n"
    printf "  --json, -j, -J       Specify the JSON file path.\n"
    printf "  --help, -h, -H       Display this help message.\n\n"
    printf "Note: You can set an environment variable for the Red Hat Subscription Manager offline\n"
    printf "      token to simplify downloading Red Hat Enterprise Linux.\n\n"
    printf '      \033[32mexport rhsm_offline_token="your_rhsm_offline_token_value"\033[0m\n\n'
    press_enter_continue
}

# After the loop, check if show_help needs to be run
if $run_show_help; then
    show_help
fi

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
logging_enabled=$(get_settings download_logging_enabled)
logging_path=$(get_settings download_logging_path)
logfile_filename=$(get_settings download_logging_filename)

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
    press_enter_continue
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
        printf "\033[31m%s\033[0m$message"
        ;;
    info)
        printf "\033[37m%s\033[0m$message"
        ;;
    warn)
        printf "\033[33m%s\033[0m$message"
        ;;
    debug)
        printf "\033[34m%s\033[0m$message"
        ;;
    *)
        printf "%s" "$message"
        ;;
    esac

    if [[ "$logging_enabled" == "true" ]]; then
        # Remove color formatting from the log message
        local no_color_message=$(echo -e $message | sed -r "s/\x1b\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")]
        log_message "$type" "$no_color_message"
    fi
}

log_message() {
    local type=$1
    local message=$2
    if [ "$logging_enabled" = true ]; then
        printf "$(date '+%Y-%m-%d %H:%M:%S') [%s]: %s\n" "$(echo $type | tr '[:lower:]' '[:upper:]')" "$message" >>"$log_file"
    fi
}

print_title() {
    project_name=$(jq -r '.project.name' $json_path)
    project_version=$(jq -r '.project.version' $json_path)
    line_width=80
    title="${project_name} ${project_version}"
    subtitle="D O W N L O A D"
    padding_title=$((($line_width - ${#title}) / 2))
    padding_subtitle=$((($line_width - ${#subtitle}) / 2))

    printf "\033[34m%*s%s\033[0m\n" $padding_title '' "$title"
    printf "\033[32m%*s%s\033[0m\n" $padding_subtitle '' "$subtitle"
}

# This function selects the guest operating system family.
# Only `Linux`` and `Windows`` are supported presently in the JSON file.
select_os() {
    clear
    print_title
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
            print_message warn "\033[33mInvalid Selection:\033[0m Enter a number between 1 and ${#os_array[@]}."
            printf "\n\n"
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
    print_title
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
            print_message warn "\033[33mInvalid Selection:\033[0m Enter a number between 1 and ${#dist_array[@]}."
            printf "\n\n"
        fi
    done
}

# This function selects the version based on the guest operating system's distribution or type.
select_version() {
    # Check if the selected distribution is SUSE Linux Enterprise Server.
    # SUSE Linux Enterprise Server is not available for download using this script.
    if [ "$dist" == "SUSE Linux Enterprise Server" ]; then
        printf "\nSUSE Linux Enterprise Server \033[31mis not\033[0m available for download using this script.\n\n"
        press_enter_continue
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
    print_title
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
        elif [[ $version_input =~ ^[0-9]+$ ]] && ((version_input >= 1 && version_input <= ${#version_array[@]})); then
            version=${version_array[$((version_input - 1))]}
            select_architecture
            break
        else
            printf "\n"
            print_message warn "\033[33mInvalid Selection:\033[0m Enter a number between 1 and ${#version_array[@]}.\n"
            printf "\n"
        fi
    done
}

# This function selects the architecture based on the guest operating system's distribution or type.
# Only `amd64` and `arm64` architectures are supported presently in the JSON file.
select_architecture() {
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
        print_title
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
                print_message warn "\033[33mInvalid Selection:\033[0m Enter a number between 1 and ${#arch_array[@]}.\n"
                printf "\n"
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
        # Validate the download link
        if curl -L --output /dev/null --silent --head --fail "$download_link"; then
            download_dir="$(echo "${iso_base_path}/${os}/${dist}/${version}/${arch}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
        else
            printf "\n\n"
            print_message warn "\033[33mInvalid Data:\033[0m Inaccessbile URL in JSON configuration: \033[34m$download_link\033[0m"
            printf "\n\n"
            return
        fi
        mkdir -p "$download_dir"

        file_name=$(basename "$download_link")
        full_path="$download_dir/$file_name"

        # Check if iso file exists in the download directory.
        iso_check=$(find "$download_dir" -type f -name "*.iso")
        if [ -n "$iso_check" ]; then
            printf "\n"
            print_message warn "\033[33mExisting ISO file found: \033[34m$iso_check\033[0m"
            printf "\n"
            while true; do
                read -p $'\nWould you like to (\e[32mc\e[0m)ontinue, go (\e[33mb\e[0m)ack, or (\e[31mq\e[0m)uit? ' action
                log_message "info" "User selected: $action"
                case $action in
                [c]*)
                    # Continue the download.
                    break
                    ;;
                [q]*)
                    # Quit the script.
                    exit 0
                    ;;
                [b]*)
                    # Go back to the menu.
                    select_distribution
                    break
                    ;;
                esac
            done
        fi
        printf "\n"
        print_message info "\033[32mDownloading:\033[0m \033[34m$file_name\033[0m => \033[34m$download_dir\033[0m."
        printf "\n\n"

        # Set the download command based on the availability of curl or wget.
        if command -v curl >/dev/null 2>&1; then
            download_command="curl -L -o"
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
                print_message error "Incorrect token format. Please try again.\n"
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

        # Check if iso file exists in the download directory.
        iso_check=$(find "$download_dir" -type f -name "*.iso")
        if [ -n "$iso_check" ]; then
            printf "\n"
            print_message warn "\033[33mExisting ISO file found: \033[34m$iso_check\033[0m"
            printf "\n"

            # Calculate the checksum of the existing file
            existing_checksum=$(sha256sum "$iso_check" | cut -d ' ' -f1)

            # Compare it with the expected checksum
            if [ "$existing_checksum" != "$expected_checksum" ]; then
                print_message warn "\033[33mChecksum does not match. The file may be corrupted.\033[0m"
                while true; do
                    read -p $'\nWould you like to (\e[32md\e[0m)ownload a new file or (\e[31mq\e[0m)uit? ' action
                    log_message "info" "User selected: $action"
                    case $action in
                    [dD]*)
                        # Download the file again
                        break
                        ;;
                    [qQ]*)
                        # Quit the script
                        exit 0
                        ;;
                    esac
                done
            fi
        fi

        printf "\n"
        print_message info "\033[32mDownloading:\033[0m \033[34m$file_name\033[0m => \033[34m$download_dir\033[0m."
        printf "\n\n"

        # Set the download command based on the availability of curl or wget.
        if command -v curl >/dev/null 2>&1; then
            download_command="curl -L -o"
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
        # Validate the download link
        if curl -L --output /dev/null --silent --head --fail "$download_link"; then
            download_dir="$(echo "${iso_base_path}/${os}/${dist}/${version}/${arch}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
        else
            printf "\n"
            print_message warn "\033[33mInvalid Data:\033[0m Inaccessbile URL in JSON configuration: \033[34m$download_link\033[0m"
            printf "\n"
            return
        fi
        mkdir -p "$download_dir"

        # Set the full path of the downloaded file.
        file_name=$(basename "$download_link")
        full_path="$download_dir/$file_name"

        # Check if iso file exists in the download directory.
        iso_check=$(find "$download_dir" -type f -name "*.iso")
        if [ -n "$iso_check" ]; then
            printf "\n"
            print_message warn "\033[33mExisting ISO file found: \033[34m$iso_check\033[0m"
            printf "\n"
            while true; do
                read -p $'\nWould you like to (\e[32mc\e[0m)ontinue, go (\e[33mb\e[0m)ack, or (\e[31mq\e[0m)uit? ' action
                log_message "info" "User selected: $action"
                case $action in
                [c]*)
                    # Continue the download.
                    break
                    ;;
                [q]*)
                    # Quit the script.
                    exit 0
                    ;;
                [b]*)
                    # Go back to the menu.
                    select_distribution
                    break
                    ;;
                esac
            done
        fi
        printf "\n"
        print_message info "\033[32mDownloading:\033[0m \033[34m$file_name\033[0m => \033[34m$download_dir\033[0m."
        printf "\n\n"

        # Set the download command based on the availability of curl or wget.
        if command -v curl >/dev/null 2>&1; then
            download_command="curl -L -o"
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
        print_message warn "The checksum value is empty."
        return
    fi

    # If checksum_value is a URL, download the file. Otherwise, write the value to the file.
    if [[ "$checksum_value" =~ ^http[s]?:// ]]; then
        # Set the download command based on the availability of curl or wget.
        download_command=""
        if command -v curl >/dev/null 2>&1; then
            download_command="curl -L -o"
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
    "Fedora Server")
        # Checksum extraction for Fedora Server
        checksum_algorithm_upper=$(echo "$checksum_algorithm" | tr '[:lower:]' '[:upper:]')
        expected_checksum=$(grep "$checksum_algorithm_upper ($file_name)" "$checksum_file" | awk -F'=' '{print $2}' | tr -d ' ')
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
                print_message warn "The checksum file is empty."
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
        print_message info "\033[32mVerifying:\033[0m \033[34m$checksum_algorithm\033[0m checksum for \033[34m$file_name\033[0m.\n"
        # Compare the actual checksum with the expected checksum.
        if [ "$actual_checksum" = "$expected_checksum" ]; then
            print_message info "Verification of checksum \033[32msuccessful\033[0m for \033[34m$file_name\033[0m.\n"
            print_message info "        - \033[32mExpected:\033[0m \033[34m$expected_checksum\033[0m\n"
            print_message info "        - \033[32mActual:\033[0m   \033[34m$actual_checksum\033[0m\n\n"
        else
            print_message error "Verification of checksum \033[31mfailed\033[0m for \033[34m$file_name\033[0m.\n"
            print_message info "        - \033[32mExpected:\033[0m \033[34m$expected_checksum\033[0m\n"
            print_message info "        - \033[31mActual:\033[0m   \033[34m$actual_checksum\033[0m\n\n"
            print_message error "Download \033[1m\033[31mfailed\033[0m for \033[34m$dist $version $arch\033[0m.\n"

            if $cleanup_failed_iso_verification; then
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
            press_enter_continue
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
        print_message info "Renaming: \033[34m$file_name\033[0m => \033[34m$iso_name\033[0m.\n"
    else
        print_message error "Unsupported guest operating system: \033[34m$os\033[0m"
    fi
}

# Check if logging is enabled.
if [[ "$logging_enabled" == "true" ]]; then
    # If logging_path is empty, use the current directory
    if [[ -z "$logging_path" ]]; then
        logging_path=$(pwd)
    fi

    log_file="$logging_path/$logfile_filename"

    # Check if the log file exists. If not, create it.
    if [[ ! -f "$log_file" ]]; then
        touch "$log_file"
        log_message "info" "Log file created: $log_file."
    fi
fi

# Start the script with the selecting the guest operating system.
select_os

# Prompt the user to continue or quit.
while true; do
    if [[ "$downloaded" == true ]]; then
        print_message info "Download completed successfully for $dist $version $arch.\n"
    fi

    read -p $'\nWould you like to (\e[32mc\e[0m)ontinue or (\e[31mq\e[0m)uit? ' action
    log_message "info" "User selected: $action"
    case $action in
    [cC]*)
        cd "$script_path" || {
            printf "\n"
            print_message error "Failed to change to directory: \033[34m$script_path\033[0m"
            exit 1
        }
        exec "$0"
        ;;
    [qQ]*) exit ;;
    esac
done

# TODO:
# - Add support for SUSE Enterprise Linux Server download.
# - Add support for Windows Server 2025 when GA.
