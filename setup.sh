#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting development environment setup...${NC}"

# Create project structure
echo -e "${BLUE}Creating project directory structure...${NC}"
mkdir -p src/{app,tests,migrations,config}
mkdir -p src/app/{models,routes,services,utils}
mkdir -p src/tests/{unit,integration,e2e}

# Create initial __init__.py files for Python packages
touch src/app/__init__.py
touch src/app/models/__init__.py
touch src/app/routes/__init__.py
touch src/app/services/__init__.py
touch src/app/utils/__init__.py
touch src/tests/__init__.py

# Move or create configuration files
if [ -f "requirements.txt" ]; then
    mv requirements.txt src/
else
    echo -e "${BLUE}Creating requirements.txt with initial dependencies...${NC}"
    echo "flask
flask-sqlalchemy
flask-migrate
psycopg2-binary
python-dotenv
requests
pandas
pytest
pytest-flask
locust
onesignal-sdk
alembic" > requirements.txt
fi

# Create backend specific files
echo -e "${BLUE}Creating backend configuration files...${NC}"
echo "from flask import Flask

def create_app():
    app = Flask(__name__)
    return app" > src/app/__init__.py

echo "import pytest
from app import create_app

@pytest.fixture
def app():
    app = create_app()
    return app

@pytest.fixture
def client(app):
    return app.test_client()" > src/tests/conftest.py

# Check if Python 3.12 is installed
if ! command -v python3.12 &> /dev/null; then
    echo "Python 3.12 is required but not installed. Please install Python 3.12 first."
    exit 1
fi

# Create Python virtual environment if it doesn't exist
if [ ! -d "src/venv" ]; then
    echo -e "${BLUE}Creating Python virtual environment...${NC}"
    python -m venv venv
    echo -e "${GREEN}Virtual environment created.${NC}"
fi

# Activate virtual environment and install requirements
echo -e "${BLUE}Activating virtual environment and installing Python requirements...${NC}"
source src/venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt

# Create example .env files for both frontend and backend
if [ ! -f "src/.env.example" ]; then
    echo -e "${BLUE}Creating src/.env.example file...${NC}"
    echo "# API Keys
WEATHERBIT_API_KEY=your_weatherbit_api_key
ONESIGNAL_API_KEY=your_onesignal_api_key
GOOGLE_MAPS_API_KEY=your_google_maps_api_key

# Database Configuration
DATABASE_URL=postgresql://user:password@localhost:5432/weather_alerts_db

# Flask Configuration
FLASK_APP=app
FLASK_ENV=development
FLASK_DEBUG=1

# OneSignal Configuration
ONESIGNAL_APP_ID=your_onesignal_app_id" > src/.env.example
fi

echo -e "${GREEN}Development environment setup complete!${NC}"
echo -e "${BLUE}Project structure created:${NC}"
echo "
├── src/
│   ├── app/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── services/
│   │   └── utils/
│   ├── tests/
│   │   ├── unit/
│   │   ├── integration/
│   │   └── e2e/
│   ├── migrations/
│   ├── config/
│   └── requirements.txt
└── setup.sh"

echo -e "${BLUE}Next steps:${NC}"
echo "1. Copy .env.example to .env and fill in your API keys"
echo "2. Set up your PostgreSQL database"
echo "3. cd src && flask db upgrade"
echo "4. Start the Flask backend with 'flask run'"
