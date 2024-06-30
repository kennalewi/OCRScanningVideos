#!/bin/bash

# Prompt the user for the directory containing the images
read -p "Enter the path to the directory containing the images: " IMAGE_DIR

# Prompt the user for the output directory
read -p "Enter the path to the output directory: " OUTPUT_DIR

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Temporary file to store all extracted text
TEMP_FILE=$(mktemp)

# Process each image
for image in "$IMAGE_DIR"/*.png; do
  tesseract "$image" - >> "$TEMP_FILE"
done

# Remove duplicate lines and save the unique text to the final output file
sort "$TEMP_FILE" | uniq > "$OUTPUT_DIR/unique_text.txt"

# Clean up the temporary file
rm "$TEMP_FILE"

echo "OCR processing complete. Unique text saved in $OUTPUT_DIR/unique_text.txt."
