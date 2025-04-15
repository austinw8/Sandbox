import os
import shutil
from pathlib import Path

# define downloads path
downloads_path = Path("C:/Users/austi/Downloads")

# define folder categories
categories = {
    "web files": [".html", ".htm"],
    "text": [".txt", ".docx", ".doc", ".rtf", ".odt"],
    "pdf": [".pdf"],
    "csv": [".csv", ".xlsx", ".xls"],
    "audio": [".mp3", ".wav", ".aac", ".flac", ".ogg"],
    "video": [".mp4", ".avi", ".mkv", ".mov", ".wmv"],
    "images": [".png", ".jpg", ".jpeg", ".gif", ".bmp", ".tiff", ".webp"],
}

# Create a fallback category for misc
misc_category = "misc"

def categorize_file(file_path):
    ext = file_path.suffix.lower()
    for category, extensions in categories.items():
        if ext in extensions:
            return category
    return misc_category

def organize_downloads():
    for item in downloads_path.iterdir():
        if item.is_file():
            category = categorize_file(item)
            destination_folder = downloads_path/category
            destination_folder.mkdir(exist_ok=True)
            try:
                shutil.move(str(item), destination_folder / item.name)
                print(f"Moved {item.name} to {category}/")
            except Exception as e:
                print(f"Failed to move {item.name}: {e}")

if __name__ == "__main__":
    organize_downloads()
