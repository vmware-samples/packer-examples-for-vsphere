#!/usr/bin/env bash
# Check if the endpoint environment variable is stored

set -e

follow_link() {
  FILE="$1"
  while [ -h "$FILE" ]; do
    # On Mac OS, readlink -f doesn't work.
    FILE="$(readlink "$FILE")"
  done
  echo "$FILE"
}

run_check_dependencies=false
run_show_help=false

# This function prompts the user to press Enter to exit.
press_enter_exit() {
    printf "Press \033[31mEnter\033[0m to exit.\n"
    read -r
    exit 0
}

press_enter_continue() {
    printf "Press \033[32mEnter\033[0m to continue.\n"
    read -r
    exec "$0"
}

get_project_info() {
    local field=$1
    jq -r ".project.${field}" "$json_path"
}

print_message() {
    message=$1
    echo "$message"
}

json_path="project.json"

# This function displays the information about the script and project.
info() {
    project_name=$(get_project_info "name")
    project_description=$(get_project_info "description")
    project_version=$(get_project_info "version")
    project_license=$(get_project_info "license[0].name")
    project_github_url=$(get_project_info "urls.github")
    project_docs_url=$(get_project_info "urls.documentation")
    clear
    printf "\033[32m%s\033[0m: \033[34m%s\033[0m\n\n" "$project_name" "$project_version"
    printf "Copyright 2023-%s Broadcom. All Rights Reserved.\n\n" "$(date +%Y)"
    printf "License: %s\n\n" "$project_license"
    printf "%s\n\n" "$project_description"
    printf "GitHub Repository: %s\n" "$project_github_url"
    printf "Documentation: %s\n\n" "$project_docs_url"
    show_help "continue"
    press_enter_continue
}

# This function displays the help message.
show_help() {
    local exit_after=${1:-"exit"}
    script_name=$(basename "$0")
    printf "Usage: %s [options]\n\n" "$script_name"
    printf "Options:\n"
    printf "  --help, -h, -H       Display this help message.\n\n"
    printf "  --deps, -d, -D       Check the dependencies.\n"
    printf "Arguments:\n"
    printf "  CONFIG_PATH   Path to the configuration directory.\n"
    printf ""
    printf "Examples:\n"
    printf "  ./upload.sh config\n"
    printf "  ./upload.sh us-west-1\n"
    if [[ -z "$input" ]]; then
        [ "$exit_after" = "exit" ] && exit 0
    else
        press_enter_continue
    fi
}


# Set CONFIG_PATH if it's not already set and the environment variables are not set
if [ -z "${PKR_VAR_vsphere_endpoint}" ] && [ -z "${PKR_VAR_vsphere_username}" ] && [ -z "${PKR_VAR_vsphere_password}" ] && [ -z "${PKR_VAR_vsphere_insecure_connection}" ] && [ -z "${PKR_VAR_vsphere_datastore}" ] && [ -z "${PKR_VAR_common_content_library_name}" ] && [ -z "$CONFIG_PATH" ]; then
    SCRIPT_PATH=$(realpath "$(dirname "$(follow_link "$0")")")


if [[ "$1" != --* ]]; then
  CONFIG_PATH="$(pwd)/$1"
else
   CONFIG_PATH="${SCRIPT_PATH}/config"
fi

fi

check_dependencies() {
local verbose=$1
# Initialize a flag variable
empty_var_flag=0x

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

CHECKMARK="${GREEN}[✔]${NC}"
CROSSMARK="${RED}[✘]${NC}"


# Check if the PKR_VAR_vsphere_endpoint environment variable is stored
if [[ -z "${PKR_VAR_vsphere_endpoint}" ]]; then
    # If PKR_VAR_vsphere_endpoint is not set, use vsphere_endpoint from the config file
    if [ -n "$CONFIG_PATH" ] && [ -f "$CONFIG_PATH/vsphere.pkrvars.hcl" ]; then
        # Parse the vsphere.pkrvars.hcl file and extract the vsphere_endpoint value
        vsphere_endpoint=$(grep 'vsphere_endpoint' "$CONFIG_PATH/vsphere.pkrvars.hcl" | awk -F'=' '{print $2}' | tr -d ' "')
        GOVC_URL="https://${vsphere_endpoint}/sdk"
    fi
else
    GOVC_URL="https://${PKR_VAR_vsphere_endpoint}/sdk"
fi


# Check if GOVC_URL is a valid URL
if [[ -z "$GOVC_URL" || "$GOVC_URL" == "https:///sdk" ]]; then
    echo -e "$CROSSMARK Error: Neither PKR_VAR_vsphere_endpoint environment variable nor vsphere_endpoint in the config file are set."
    empty_var_flag=1
elif [ "$verbose" = "true" ]; then
    echo -e "$CHECKMARK Good: GOVC_URL is set."
fi

# Check if the PKR_VAR_vsphere_username environment variable is stored
if [[ -z "${PKR_VAR_vsphere_username}" ]]; then
    # If PKR_VAR_vsphere_username is not set, use vsphere_username from the config file
    if [ -n "$CONFIG_PATH" ] && [ -f "$CONFIG_PATH/vsphere.pkrvars.hcl" ]; then
        # Parse the vsphere.pkrvars.hcl file and extract the vsphere_username value
        vsphere_username=$(grep 'vsphere_username' "$CONFIG_PATH/vsphere.pkrvars.hcl" | awk -F'=' '{print $2}' | tr -d ' "')
        GOVC_USERNAME=$vsphere_username
    fi
else
    GOVC_USERNAME="${PKR_VAR_vsphere_username}"
fi


# Check if GOVC_USERNAME is not empty
if [[ -z "$GOVC_USERNAME" ]]; then
    echo -e "$CROSSMARK Error: Neither PKR_VAR_vsphere_username environment variable nor vsphere_username in the config file are set."
    empty_var_flag=1
elif [ "$verbose" = "true" ]; then
    echo -e "$CHECKMARK Good: GOVC_USERNAME is set."
fi

# Check if the vsphere_password environment variable is stored
if [[ -z "${PKR_VAR_vsphere_password}" ]]; then
    if [ -n "$CONFIG_PATH" ] && [ -f "$CONFIG_PATH/vsphere.pkrvars.hcl" ]; then
    vsphere_password=$(grep 'vsphere_password' "$CONFIG_PATH/vsphere.pkrvars.hcl" | awk -F'=' '{print $2}' | tr -d ' "')
    GOVC_PASSWORD=$vsphere_password
    fi
else
    GOVC_PASSWORD="${PKR_VAR_vsphere_password}"
fi


# Check if GOVC_PASSWORD is not empty
if [[ -z "$GOVC_PASSWORD" ]]; then
    echo -e "$CROSSMARK Error: Neither PKR_VAR_vsphere_password environment variable nor vsphere_password in the config file are set."
    empty_var_flag=1
elif [ "$verbose" = "true" ]; then
    echo -e "$CHECKMARK Good: GOVC_PASSWORD is set."
fi

# Check if the vsphere_insecure_connection environment variable is stored
if [[ -z "${PKR_VAR_vsphere_insecure_connection}" ]]; then
    if [ -n "$CONFIG_PATH" ] && [ -f "$CONFIG_PATH/vsphere.pkrvars.hcl" ]; then
    vsphere_insecure_connection=$(grep 'vsphere_insecure_connection' "$CONFIG_PATH/vsphere.pkrvars.hcl" | awk -F'=' '{print $2}' | tr -d ' "')
    GOVC_INSECURE=$vsphere_insecure_connection
    fi
else
    GOVC_INSECURE="${PKR_VAR_vsphere_insecure_connection}"

fi


# Check if GOVC_INSECURE is not empty
if [[ -z "$GOVC_INSECURE" ]]; then
    echo -e "$CROSSMARK Error: Neither PKR_VAR_vsphere_insecure_connection environment variable nor vsphere_insecure_connection in the config file are set."
    empty_var_flag=1
elif [ "$verbose" = "true" ]; then
    echo -e "$CHECKMARK Good: GOVC_INSECURE is set."
fi


# Check if the vsphere_datastore environment variable is stored
if [[ -z "${PKR_VAR_vsphere_datastore}" ]]; then
    if [ -n "$CONFIG_PATH" ] && [ -f "$CONFIG_PATH/vsphere.pkrvars.hcl" ]; then
    datastore_name=$(grep 'vsphere_datastore' "$CONFIG_PATH/vsphere.pkrvars.hcl" | awk -F'=' '{print $2}' | tr -d ' "')
    fi
else
    datastore_name="${PKR_VAR_vsphere_datastore}"
fi


# Check if datastore_name is not empty
if [[ -z "$datastore_name" ]]; then
    echo -e "$CROSSMARK Error: Neither PKR_VAR_vsphere_datastore environment variable nor vsphere_datastore in the $CONFIG_PATH/vsphere.pkrvars.hcl file are set."
    empty_var_flag=1
elif [ "$verbose" = "true" ]; then
    echo -e "$CHECKMARK Good: Datastore Name is set."
fi


# Check if the common_content_library_name environment variable is stored
if [[ -z "${PKR_VAR_common_content_library_name}" ]]; then
     if [ -n "$CONFIG_PATH" ] && [ -f "$CONFIG_PATH/vsphere.pkrvars.hcl" ]; then
    library_name=$(grep -w 'common_iso_content_library' "$CONFIG_PATH/common.pkrvars.hcl" | awk -F'=' '{print $2}' | tr -d ' "')
    fi
else
    library_name="${PKR_VAR_common_content_library_name}"

fi


# Check if datastore_name is not empty
if [[ -z "$library_name" ]]; then
    echo -e "$CROSSMARK Error: Neither PKR_VAR_common_content_library_name environment variable nor vsphere_datastore in the $CONFIG_PATH/common.pkrvars.hcl file are set."
    empty_var_flag=1
elif [ "$verbose" = "true" ]; then
    echo -e "$CHECKMARK Good: Content Library is set."
fi

# Exit the script if any of the variables are empty
if [[ $empty_var_flag -eq 1 ]]; then
    press_enter_exit
fi
}

verbose=false
# Script options.
while (("$#")); do
    case "$1" in
    --deps | -d | -D)
        verbose=true
        check_dependencies $verbose
        shift
        ;;
    --help | -h | -H)
        run_show_help=true
        show_help
        exit 0
        ;;
    *)
        if [[ "$1" != -* ]]; then
            CONFIG_PATH=$(realpath "$1")
        fi
        shift
        ;;
    esac
done

# After the loop, check if show_help needs to be run
if $run_show_help; then
    show_help
fi

if $run_check_dependencies; then
    check_dependencies $verbose
fi

print_title() {
    project_name=$(jq -r '.project.name' "$json_path")
    project_version=$(jq -r '.project.version' "$json_path")
    line_width=80
    title="${project_name} ${project_version}"
    subtitle="U P L O A D  I S O   T O   V S P H E R E"
    padding_title=$((($line_width - ${#title}) / 2))
    padding_subtitle=$((($line_width - ${#subtitle}) / 2))
    printf "\033[34m%*s%s\033[0m\n" $padding_title '' "$title"
    printf "\033[32m%*s%s\033[0m\n" $padding_subtitle '' "$subtitle"
}

upload_iso_to_vsphere() {
local target=$1
# Set the necessary environment variables for govc
export GOVC_URL="${GOVC_URL}"
export GOVC_USERNAME="${GOVC_USERNAME}"
export GOVC_PASSWORD="${GOVC_PASSWORD}"
export GOVC_INSECURE="${GOVC_INSECURE}"


# Set the directory to search for ISO files
local_directory_to_search="iso"

# Find all ISO files in the directory and its subfolders
iso_files=$(find "$local_directory_to_search" -type f -name "*.iso")

# Loop over the found ISO files
for iso_file in $iso_files; do
    # Extract the file name from the file path
    file_name=$(basename "$iso_file")

    skip_library_import=false
    skip_datastore_import=false

    if [ "$target" = "Content Library" ] || [ "$target" = "Both" ]; then
        # Check if the item exists in the library
        file_name_no_ext=${file_name%.iso}
        library_file=$(govc library.ls "$library_name/$file_name_no_ext")
        if [ -n "$library_file" ]; then
            # The item exists, ask for confirmation before deleting
            read -p "The item already exist in $library_name and $file_name exists. Do you want to delete it? (y/n) " -n 1 -r
            echo    # (optional) move to a new line
            if [[ $REPLY =~ ^[Yy]$ ]]
            then
                # If yes, delete it
                if govc library.rm "$library_name/${file_name%.iso}"; then
                    echo "Item deleted successfully."
                else
                    echo "Error deleting item. Please check the library and item names."
                    exit 1
                fi
            elif [[ $REPLY =~ ^[Nn]$ ]]
                then
                    # If no, skip this file and continue with the next one
                    echo "Skipping this library upload because file exist and replace was skipped."
                    skip_library_import=true
                else
                    echo "Invalid response. Please enter 'Y' for yes or 'N' for no."
                    exit 1
                fi
        fi
        if [ "$skip_library_import" = false ]; then
        # Import the ISO file to the library
        GREEN='\033[0;32m'
        NC='\033[0m' # No Color
        echo -e  "${GREEN}Importing $file_name to content library $library_name...${NC}"
        if govc library.import "$library_name" "$iso_file"; then
            echo "Item imported successfully."
        else
            echo "Error importing item. Please check the library and item names."
            exit 1
        fi
    fi
fi

    if [ "$target" = "Datastore" ] || [ "$target" = "Both" ]; then
        datastore_directory=$(dirname "$iso_file" | cut -d'/' -f1-3)
        datastore_directory="${datastore_directory//iso\/\//iso/}"
        datastore_file=$(govc datastore.ls -ds="$datastore_name" "$datastore_directory/$file_name" 2>/dev/null)
            if [ -n "$datastore_file" ]; then
            #if govc datastore.ls -ds="$datastore_name" "$datastore_directory/$file_name" >/dev/null; then
            read -p "The item $file_name exists on $datastore_name. Do you want to delete it? (y/n) " -n 1 -r
            echo    # (optional) move to a new line
            if [[ $REPLY =~ ^[Yy]$ ]]
            then
                # If yes, delete it
                if govc datastore.rm -ds=$datastore_name $datastore_directory/$file_name; then
                    echo "Item deleted successfully."
                else
                    echo "Error deleting item. Please check the datastore, directory, and item names."
                    exit 1
                fi
                 elif [[ $REPLY =~ ^[Nn]$ ]]
                then
                    # If no, skip this file and continue with the next one
                    echo "Skipping this datastore upload because file exist and replace was skipped."
                    skip_datastore_import=true
                else
                    echo "Invalid response. Please enter 'Y' for yes or 'N' for no."
                    exit 1
                fi
        fi
        if [ "$skip_datastore_import" = false ]; then
        # Upload the ISO file to the datastore
        #GREEN='\033[0;32m'
        #NC='\033[0m' # No Color
        #echo -e "${GREEN}Uploading $iso_file to $datastore_name:$datastore_directory/$file_name...${NC}"
        printf "\n"
        print_message info "\033[32mUploading:\033[0m \033[34m$file_name\033[0m =>  \033[34m$library_name\033[0m."
        printf "\n\n"
        if govc datastore.upload -ds="$datastore_name" "$iso_file" "$datastore_directory/$file_name"; then
            echo "Item uploaded successfully."
        else
            echo "Error uploading item. Please check the datastore, directory, and item names."
            exit 1
        fi
    fi
fi
done
}

menu_selection() {
clear

print_title
check_dependencies false
options=("Content Library" "Datastore" "Both")
while true; do
    printf "\nDo you want to upload to:\n\n"
    printf "1: ${options[0]}\n"
    printf "2: ${options[1]}\n"
    printf "3: ${options[2]}\n"
    printf "\nEnter \033[31mq\033[0m to quit or \033[34mi\033[0m for info.\n\n"
    read -r -p "Your choice: " input
    if [[ $input == [qQ] ]]; then
        exit 0
    elif [[ $input == [iI] ]]; then
        info
    elif ((input >= 1 && input <= ${#options[@]})); then
        target=${options[$((input - 1))]}
        upload_iso_to_vsphere "$target"
    else
        printf "\n"
        print_message warn "\033[33mInvalid Selection:\033[0m Enter a number between 1 and ${#options[@]}, or q to quit, or i for info."
        printf "\n\n"
    fi
done
}
menu_selection
