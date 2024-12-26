#!/bin/bash

################################################################################
# Script Name : RecHunter.sh
# Author      : shxim
# Description : A DNS enumeration tool for querying DNS records and domain info.
# Usage       : ./RecHunter.sh <domain_name>
################################################################################

# Define colors for output formatting
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)
CYAN=$(tput setaf 6)

# Display author information and important notes
AUTHOR() {
    rechunter_color="${CYAN}"
    rechunter_bg_color="${YELLOW}"
    author_color="${RED}"
    author_bg_color="${GREEN}"

    echo "  ${rechunter_bg_color}${rechunter_color}__________                ___ ___               __                ${RESET}"
    echo "  ${rechunter_bg_color}${rechunter_color}\______   \ ____   ____  /   |   \ __ __  _____/  |_  ___________ ${RESET}"
    echo "  ${rechunter_bg_color}${rechunter_color} |       _// __ \_/ ___\/    ~    \  |  \/    \   __\/ __ \_  __ \ ${RESET}"
    echo "  ${rechunter_bg_color}${rechunter_color} |    |   \  ___/\  \___\    Y    /  |  /   |  \  | \  ___/|  | \/ ${RESET}"
    echo "  ${rechunter_bg_color}${rechunter_color} |____|_  /\___  >\___  >\___|_  /|____/|___|  /__|  \___  >__|    ${RESET}"
    echo "  ${rechunter_bg_color}${rechunter_color}        \/     \/     \/       \/            \/          \/        ${RESET}"
    echo -e "                                                                        ${CYAN}𝒜𝓊𝓉𝒽ℴ𝓇: 𝓈𝒽𝓍𝒾𝓂${RESET}\n"
}

# Function to display usage instructions
function show_usage {
    echo -e "${YELLOW}Usage: $0 <domain_name>${RESET}"
    echo -e "${YELLOW}Example: $0 example.com${RESET}"
}

# Function to check domain validity
function validate_domain {
    local domain=$1
    if [[ ! "$domain" =~ ^[a-zA-Z0-9.-]+\.com$ ]]; then
        echo -e "${RED}Error: Invalid domain name. The domain must end with '.com'.${RESET}"
        show_usage
        exit 1
    fi
}

# Function to check dependencies
function check_dependencies {
    if ! command -v dig &>/dev/null; then
        echo -e "${RED}Error: 'dig' is required but not installed.${RESET}"
        exit 1
    fi
    if ! command -v whois &>/dev/null; then
        echo -e "${RED}Error: 'whois' is required but not installed.${RESET}"
        exit 1
    fi
}

# Function to ask if the user wants to continue
function ask_continue {
    echo -n "Do you want to return to the menu? (yes/no): "
    read -r continue_choice
    if [[ "$continue_choice" =~ ^[Nn](o)?$ ]]; then
        echo -e "${GREEN}Exiting. Thank you for using the RecHunter!${RESET}"
        exit 0
    fi
}

# Function to perform DNS record lookup
function dns_lookup {
    local domain=$1
    local record=$2
    local log_file="${record}_${domain}.log"

    echo -e "${RED}Querying ${record} record for ${domain}...${RESET}"
    local result
    result=$(dig "${domain}" "${record}" +short)

    if [[ -z "$result" ]]; then
        echo -e "${RED}No results for ${record} record.${RESET}"
        ask_continue
        return
    fi

    echo -e "${GREEN}${result}${RESET}"

    # Prompt user to save the output
    echo -n "Do you want to save this output to ${log_file}? (yes/no): "
    read -r save_choice
    if [[ "$save_choice" =~ ^[Yy](es)?$ ]]; then
        echo "${result}" > "${log_file}"
        echo -e "${GREEN}Output saved to ${log_file}.${RESET}"
    else
        echo -e "${YELLOW}Output not saved.${RESET}"
    fi
}

# Function to perform WHOIS lookup
function whois_lookup {
    local domain=$1
    local log_file="WHOIS_${domain}.log"

    echo -e "${YELLOW}Performing WHOIS lookup for ${domain}...${RESET}"
    local result
    result=$(whois "${domain}")

    echo -e "${GREEN}${result}${RESET}"

    # Prompt user to save the output
    echo -n "Do you want to save this output to ${log_file}? (yes/no): "
    read -r save_choice
    if [[ "$save_choice" =~ ^[Yy](es)?$ ]]; then
        echo "${result}" > "${log_file}"
        echo -e "${GREEN}Output saved to ${log_file}.${RESET}"
    else
        echo -e "${YELLOW}Output not saved.${RESET}"
    fi
}

# Function to perform all DNS enumerations and save combined output
function perform_all_operations {
    local domain=$1
    local all_log_file="All_Records_${domain}.log"
    local combined_output=""

    echo -e "${YELLOW}Performing all operations for ${domain}...${RESET}"

    # Default DNS record types
    local record_types=("A" "AAAA" "CNAME" "MX" "TXT")

    # Query each record type and append to combined output
    for record in "${record_types[@]}"; do
        local result
        result=$(dig "${domain}" "${record}" +short)

        if [[ -z "$result" ]]; then
            combined_output+="${record} Record:\nNo results found\n\n"
        else
            combined_output+="${record} Record:\n${result}\n\n"
        fi
    done

    # Perform WHOIS lookup and append to combined output
    local whois_result
    whois_result=$(whois "${domain}")
    combined_output+="WHOIS Lookup:\n${whois_result}\n"

    echo -e "${GREEN}${combined_output}${RESET}"

    # Prompt user to save the combined output
    echo -n "Do you want to save this output to ${all_log_file}? (yes/no): "
    read -r save_choice
    if [[ "$save_choice" =~ ^[Yy](es)?$ ]]; then
        echo -e "${combined_output}" > "${all_log_file}"
        echo -e "${GREEN}All outputs saved to ${all_log_file}.${RESET}"
    else
        echo -e "${YELLOW}Combined output not saved.${RESET}"
    fi
}

# Function to display menu
function display_menu {
    echo -e "${YELLOW}Select an operation:${RESET}"
    echo "1. Query A record"
    echo "2. Query AAAA record"
    echo "3. Query CNAME record"
    echo "4. Query MX record"
    echo "5. Query TXT record"
    echo "6. Perform WHOIS lookup"
    echo "7. Perform all operations"
    echo "8. Exit"
    echo -n "Enter your choice: "
}

# Main script execution starts here
if [[ $# -ne 1 ]]; then
    echo -e "${RED}Error: Domain name is required.${RESET}"
    show_usage
    exit 1
fi

# Assign domain name from input argument
DOMAIN=$1

# Validate the domain format
validate_domain "$DOMAIN"

# Check for required tools
check_dependencies

echo

# Show the author information
AUTHOR

# Show menu until the user chooses to exit
while true; do
    display_menu
    read -r choice
    echo

    case $choice in
        1)
            dns_lookup "${DOMAIN}" "A"
            ask_continue
            ;;
        2)
            dns_lookup "${DOMAIN}" "AAAA"
            ask_continue
            ;;
        3)
            dns_lookup "${DOMAIN}" "CNAME"
            ask_continue
            ;;
        4)
            dns_lookup "${DOMAIN}" "MX"
            ask_continue
            ;;
        5)
            dns_lookup "${DOMAIN}" "TXT"
            ask_continue
            ;;
        6)
            whois_lookup "${DOMAIN}"
            ask_continue
            ;;
        7)
            perform_all_operations "${DOMAIN}"
            ask_continue
            ;;
        8)
            echo -e "${GREEN}Exiting. Thank you for using the RecHunter!${RESET}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice. Please try again.${RESET}"
            ;;
    esac
    echo
done
