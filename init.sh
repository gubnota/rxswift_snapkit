#!/bin/bash

# Check if the script received at least one argument
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <bundle_id> [project_name]"
    exit 1
fi

# Get the bundle ID and optional project name from the arguments
BUNDLE_ID=$1
PROJECT_NAME=${2:-"rxswift_snapkit"} # Default to "rxswift_snapkit" if not provided

# Define the source and target file paths
SOURCE_FILE="project_template.yml"
TARGET_FILE="project.yml"

# Check if the source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: $SOURCE_FILE not found!"
    exit 1
fi

# Replace the placeholders in the source file and write to the target file
sed -e "s/# bundleIdPrefix: your_id/bundleIdPrefix: $BUNDLE_ID/" \
    -e "s/# PRODUCT_BUNDLE_IDENTIFIER: \"yourid\"/PRODUCT_BUNDLE_IDENTIFIER: $BUNDLE_ID/" \
    -e "s/rxswift_snapkit/$PROJECT_NAME/" \
    "$SOURCE_FILE" >"$TARGET_FILE"

# Run xcodegen to generate the Xcode project
xcodegen generate

echo "✅ Project '$PROJECT_NAME' generated with bundle ID: $BUNDLE_ID"
echo "Don't forget to add RxCocoa "
echo "to Build Phases > Link Binary with Libraries"
