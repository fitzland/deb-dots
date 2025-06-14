#!/usr/bin/env python3
"""
Script to rotate all images in a folder 90 degrees counterclockwise
"""

import os
import sys
from PIL import Image
from pathlib import Path

def rotate_images_in_folder(folder_path, output_folder=None, overwrite=False):
    """
    Rotate all images in a folder 90 degrees counterclockwise
    
    Args:
        folder_path (str): Path to the folder containing images
        output_folder (str, optional): Path to save rotated images. If None, uses input folder
        overwrite (bool): Whether to overwrite original files
    """
    
    # Supported image formats
    supported_formats = {'.jpg', '.jpeg', '.png', '.bmp', '.tiff', '.tif', '.webp'}
    
    folder_path = Path(folder_path)
    
    if not folder_path.exists():
        print(f"Error: Folder '{folder_path}' does not exist.")
        return
    
    if not folder_path.is_dir():
        print(f"Error: '{folder_path}' is not a directory.")
        return
    
    # Set up output folder
    if output_folder:
        output_path = Path(output_folder)
        output_path.mkdir(parents=True, exist_ok=True)
    else:
        output_path = folder_path
    
    # Find all image files
    image_files = []
    for file_path in folder_path.iterdir():
        if file_path.is_file() and file_path.suffix.lower() in supported_formats:
            image_files.append(file_path)
    
    if not image_files:
        print(f"No supported image files found in '{folder_path}'")
        print(f"Supported formats: {', '.join(supported_formats)}")
        return
    
    print(f"Found {len(image_files)} image(s) to rotate...")
    
    processed = 0
    errors = 0
    
    for img_path in image_files:
        try:
            # Open and rotate image
            with Image.open(img_path) as img:
                # Rotate 90 degrees counterclockwise (270 degrees clockwise)
                rotated_img = img.rotate(90, expand=True)
                
                # Determine output path
                if overwrite or output_path == folder_path:
                    save_path = img_path
                else:
                    save_path = output_path / img_path.name
                
                # Save the rotated image
                rotated_img.save(save_path, quality=95, optimize=True)
                
            print(f"✓ Rotated: {img_path.name}")
            processed += 1
            
        except Exception as e:
            print(f"✗ Error processing {img_path.name}: {str(e)}")
            errors += 1
    
    print(f"\nCompleted! Processed: {processed}, Errors: {errors}")

def main():
    """Main function to handle command line arguments"""
    
    if len(sys.argv) < 2:
        print("Usage: python rotate_images.py <folder_path> [output_folder] [--overwrite]")
        print("\nExamples:")
        print("  python rotate_images.py ./photos")
        print("  python rotate_images.py ./photos ./rotated_photos")
        print("  python rotate_images.py ./photos --overwrite")
        return
    
    folder_path = sys.argv[1]
    output_folder = None
    overwrite = False
    
    # Parse additional arguments
    if len(sys.argv) > 2:
        for arg in sys.argv[2:]:
            if arg == '--overwrite':
                overwrite = True
            else:
                output_folder = arg
    
    # If overwrite is specified, ignore output_folder
    if overwrite:
        output_folder = None
    
    rotate_images_in_folder(folder_path, output_folder, overwrite)

if __name__ == "__main__":
    main()
