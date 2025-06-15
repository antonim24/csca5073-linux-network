#!/usr/bin/bash

#
# CSCA 5073 - Network Principles in Practice: Linux Networking
# Assignment: Lab 1
# Author: Antoni Meyer
# Date: 2025-05-17

# INCLUDE ALL COMMANDS NEEDED TO PERFORM THE LAB
# This file will get called from capture_submission.sh

set -ex

# Constants
readonly SW="docker exec -it clab-lab1-part1-switch"

########################################
# Create a bridge network and enable it.
# Arguments:
#	name Name of the bridge
# Returns:
#	NONE
########################################
function create_bridge(){
    local name="$1"
    # First create the bridge
    ${SW} ip link add name "${name}" type bridge
    # Then enable the bridge
    ${SW} ip link set "${name}" up
}

########################################
# Add an endpoint to a bridge.
# Arguments:
#	endpoint The endpoint to add
#	bridge_id The Bridge Name / ID to add the endpoint to.
# Returns:
#	NONE
########################################
function add_endpoint_to_bridge(){
    local endpoint="$1"
    local bridge_id="$2"
    # Add the host as a slave to the bridge
    ${SW} ip link set "${endpoint}" master "${bridge_id}"
}

########################################
# Main function for this lab
# Arguments:
#	NONE
# Returns:
#	NONE
########################################
function main(){
    # Create the bridge
    create_bridge lab1_bridge

    # Add the endpoints to the bridge
    add_endpoint_to_bridge eth1 lab1_bridge
    add_endpoint_to_bridge eth2 lab1_bridge
    add_endpoint_to_bridge eth3 lab1_bridge
    add_endpoint_to_bridge eth4 lab1_bridge
}

# Call main function
main
