#!/bin/bash

# HEIC to JPG Converter Script
# Usage: ./convert_heic_to_jpg.sh [directory_path] [quality]
# If no directory is specified, current directory is used
# Quality parameter is optional (1-100, default is 90)

# Set default values
INPUT_DIR="${1:-.}"
QUALITY="${2:-90}"

# Check if heif-convert is available
if ! command -v heif-convert &> /dev/null; then
    echo "Error: heif-convert command not found. Please install libheif-examples package."
    echo "Run: sudo apt install libheif-examples"
    exit 1
fi

# Check if directory exists
if [ ! -d "$INPUT_DIR" ]; then
    echo "Error: Directory '$INPUT_DIR' does not exist."
    exit 1
fi

# Find and convert HEIC files
echo "Converting HEIC files in directory: $INPUT_DIR"
echo "Quality setting: $QUALITY"
echo "----------------------------------------"

# Counter for converted files
converted=0
failed=0

# Process all HEIC files (case insensitive)
for file in "$INPUT_DIR"/*.{heic,HEIC,heif,HEIF}; do
    # Skip if no matching files (glob doesn't expand)
    [ -f "$file" ] || continue
    
    # Get filename without extension
    basename=$(basename "$file")
    filename="${basename%.*}"
    
    # Output JPG file path
    output_file="$INPUT_DIR/${filename}.jpg"
    
    echo "Converting: $basename -> ${filename}.jpg"
    
    # Convert the file
    if heif-convert -q "$QUALITY" "$file" "$output_file"; then
        echo "✓ Successfully converted: $basename"
        ((converted++))
    else
        echo "✗ Failed to convert: $basename"
        ((failed++))
    fi
    echo ""
done

# Summary
echo "----------------------------------------"
echo "Conversion complete!"
echo "Successfully converted: $converted files"
if [ $failed -gt 0 ]; then
    echo "Failed conversions: $failed files"
fi

if [ $converted -eq 0 ] && [ $failed -eq 0 ]; then
    echo "No HEIC/HEIF files found in '$INPUT_DIR'"
fi
