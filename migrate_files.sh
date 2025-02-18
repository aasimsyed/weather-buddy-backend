#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting file migration...${NC}"

# Create directories if they don't exist
mkdir -p backend
mkdir -p frontend

# Function to merge package.json files
merge_package_json() {
    if [ -f "package.json" ] && [ -f "frontend/package.json" ]; then
        echo -e "${BLUE}Merging package.json files...${NC}"
        # Create a temporary file for the merged content
        TEMP_FILE=$(mktemp)
        
        # Use jq to merge the files, preferring the frontend version for conflicts
        jq -s '
            .[0] * .[1] + {
                dependencies: (.[0].dependencies // {}) * (.[1].dependencies // {}),
                devDependencies: (.[0].devDependencies // {}) * (.[1].devDependencies // {})
            }
        ' frontend/package.json package.json > "$TEMP_FILE"
        
        # Backup the original frontend package.json
        mv frontend/package.json frontend/package.json.bak
        
        # Move the merged file to frontend/package.json
        mv "$TEMP_FILE" frontend/package.json
        
        # Remove the root package.json
        rm package.json
        
        echo -e "${GREEN}Successfully merged package.json files${NC}"
        echo -e "${BLUE}Original frontend/package.json backed up as package.json.bak${NC}"
    else
        # If only root package.json exists, move it to frontend
        safe_move "package.json" "frontend/package.json"
    fi
}

# Function to safely move files
safe_move() {
    if [ -f "$1" ] && [ ! -f "$2" ]; then
        mv "$1" "$2"
        echo -e "${GREEN}Moved $1 to $2${NC}"
    elif [ -f "$1" ] && [ -f "$2" ]; then
        echo -e "${RED}Warning: $2 already exists. Keeping both files for manual merge.${NC}"
        mv "$1" "${1}.old"
        echo -e "${BLUE}Renamed $1 to ${1}.old${NC}"
    fi
}

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo -e "${RED}Error: jq is required for merging package.json files${NC}"
    echo "Please install jq first:"
    echo "  - On Ubuntu/Debian: sudo apt-get install jq"
    echo "  - On macOS: brew install jq"
    echo "  - On Windows: choco install jq"
    exit 1
fi

# Merge package.json files
merge_package_json

# Move backend-specific files
safe_move "requirements.txt" "backend/requirements.txt"
safe_move "pytest.ini" "backend/pytest.ini"
safe_move "alembic.ini" "backend/alembic.ini"
safe_move ".env.example" "backend/.env.example"

# Move frontend-specific files
safe_move "package-lock.json" "frontend/package-lock.json"
safe_move ".nvmrc" "frontend/.nvmrc"
safe_move "tailwind.config.js" "frontend/tailwind.config.js"
safe_move "app.json" "frontend/app.json"

# Move any remaining configuration files to appropriate locations
for file in .*.json; do
    if [ -f "$file" ]; then
        if [[ $file == *"eslint"* ]] || [[ $file == *"prettier"* ]] || [[ $file == *"babel"* ]]; then
            safe_move "$file" "frontend/$file"
        fi
    fi
done

# Move README.md to project root (if it exists)
if [ -f "README.md" ]; then
    if [ ! -f "./README.md" ]; then
        mv "README.md" "./README.md"
        echo -e "${GREEN}Kept README.md in project root${NC}"
    fi
fi

# Clean up any empty directories in root
find . -maxdepth 1 -type d -empty -delete 2>/dev/null

# If .gitignore is not already in root directory, move it there
if [ -f ".gitignore" ]; then
    if [ ! -f "./.gitignore" ]; then
        mv ".gitignore" "./.gitignore"
        echo -e "${GREEN}Moved .gitignore to project root${NC}"
    fi
fi

echo -e "${GREEN}File migration complete!${NC}"
echo -e "${BLUE}Please review the following:${NC}"
echo "1. Check for any .old files that need manual merging"
echo "2. Verify that all files are in their correct locations"
echo "3. Update any import paths in your code if necessary"
echo "4. Update any CI/CD configurations to reflect the new structure"
echo "5. Review frontend/package.json.bak and delete if no longer needed" 