#!/bin/bash
# Save this as convert_to_mkdocs.sh and make executable with chmod +x convert_to_mkdocs.sh

input_file=$1
filename=$(basename -- "$input_file")
filename_noext="${filename%.*}"
output_file="${filename_noext}.md"
docs_dir="$HOME/git/fitzland/octo-potoato/docs/journal/newt/matthew/sotm/"

# Convert HTML to Markdown
pandoc -f html -t markdown_strict+pipe_tables+footnotes -o "$output_file" "$input_file"

# Optional: automatically move to MkDocs docs directory
cp "$output_file" "$docs_dir"

echo "Converted $input_file to $output_file and copied to MkDocs docs directory."
