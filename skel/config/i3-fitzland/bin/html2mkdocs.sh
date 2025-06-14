#!/bin/bash

echo "HTML to MkDocs Markdown Converter"
echo "=================================="
echo

# Ask for source HTML file
read -p "Enter path to HTML file: " html_file

# Check if file exists
if [ ! -f "$html_file" ]; then
    echo "Error: File '$html_file' not found."
    exit 1
fi

# Extract filename and directory
filename=$(basename -- "$html_file")
filename_no_ext="${filename%.*}"
directory=$(dirname -- "$html_file")

# Ask for output location
read -p "Enter output directory (leave blank for same as input): " output_dir
if [ -z "$output_dir" ]; then
    output_dir=$directory
fi

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Set output filename
output_file="$output_dir/$filename_no_ext.md"

# Ask for media directory
read -p "Enter media directory for extracted assets (leave blank for 'assets'): " media_dir
if [ -z "$media_dir" ]; then
    media_dir="assets"
fi

# Create full path for media directory
media_path="$output_dir/$media_dir"
mkdir -p "$media_path"

echo
echo "Converting '$html_file' to Markdown..."
echo "Output will be saved to '$output_file'"
echo "Media will be extracted to '$media_path'"
echo

# Run pandoc with MkDocs-friendly options
pandoc -f html -t markdown_strict+pipe_tables+fenced_code_blocks+auto_identifiers+link_attributes+raw_html \
    "$html_file" \
    -o "$output_file" \
    --extract-media="$media_path" \
    --wrap=none

# Check if conversion was successful
if [ $? -eq 0 ]; then
    echo "Conversion completed successfully!"
    
    # Optional: Check and fix common issues
    echo
    echo "Post-processing the Markdown file..."
    
    # Fix image paths to be relative to the document
    sed -i "s|$media_path|$media_dir|g" "$output_file"
    
    # Remove any problematic HTML comments
    sed -i '/<!--/,/-->/d' "$output_file"
    
    echo "Adding MkDocs front matter..."
    # Add MkDocs front matter
    temp_file=$(mktemp)
    cat > "$temp_file" << EOL
---
title: ${filename_no_ext}
summary: Converted from HTML using Pandoc
---

EOL
    cat "$output_file" >> "$temp_file"
    mv "$temp_file" "$output_file"
    
    echo
    echo "Done! Your Markdown file is ready for MkDocs."
    echo "File: $output_file"
else
    echo "Error: Conversion failed."
    exit 1
fi
