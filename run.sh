#!/usr/bin/env bash

set -e

# Variables
DOCKER_IMAGE="c-devbox"
DEV_FOLDER="$(dirname "$0")"

# Functions
function print_usage() {
    echo "Usage: $0 [/path/to/project] [--rebuild]"
}

#function check_docker() {
#    if ! command -v docker &> /dev/null; then
#        echo "Docker is not installed. Please install Docker first."
#        exit 1
#    fi
#}

function build_image() {
    echo "Building Docker image '$DOCKER_IMAGE'..."
    docker build -t "$DOCKER_IMAGE" "$DEV_FOLDER"
    echo "Docker image '$DOCKER_IMAGE' built successfully."
}

function check_or_build_image() {
    if [[ "$REBUILD" == true ]]; then
        build_image
    elif ! docker image inspect "$DOCKER_IMAGE" > /dev/null 2>&1; then
        build_image
    else
        echo "Docker image '$DOCKER_IMAGE' already exists."
    fi
}

function prepare_project_folder() {
    if [ -z "$PROJECT_FOLDER" ]; then
        echo "No project folder provided, using current directory."
        PROJECT_FOLDER=$(pwd)
    else
        PROJECT_FOLDER=$(realpath "$PROJECT_FOLDER")
    fi

    if [ ! -d "$PROJECT_FOLDER" ]; then
        echo "Creating project directory at '$PROJECT_FOLDER'..."
        mkdir -p "$PROJECT_FOLDER"
    fi

    echo "Using project directory: $PROJECT_FOLDER"
}

function run_container() {
    USER_ID=$(id -u)
    GROUP_ID=$(id -g)

    docker run --rm -it \
        -v "$PROJECT_FOLDER":/workspace \
        -e HOST_USER_ID=$USER_ID \
        -e HOST_GROUP_ID=$GROUP_ID \
        "$DOCKER_IMAGE"
}

# Parse arguments
PROJECT_FOLDER=""
REBUILD=false

for arg in "$@"; do
    case $arg in
        --rebuild)
            REBUILD=true
            shift
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            PROJECT_FOLDER=$arg
            ;;
    esac
done

# Main execution
#check_docker
check_or_build_image
prepare_project_folder
run_container
