# Real-Time Weather and Disaster Alert System

A real-time weather and disaster alert system that provides timely and localized severe weather notifications. This system integrates weather data from Weatherbit, push notifications via OneSignal, interactive maps with Google Maps & Geolocation APIs, and robust analytics powered by Pandas. The mobile app is built using React Native with NativeWind CSS and deployed for demos via the Expo Go app.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture Diagram](#architecture-diagram)
- [Development Environment Setup](#development-environment-setup)
- [Technical Challenges & Solutions](#technical-challenges--solutions)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Overview

The Real-Time Weather and Disaster Alert System is designed to:

- Fetch and process severe weather data in real time using the Weatherbit API.
- Deliver instant push notifications using OneSignal.
- Provide an interactive map interface with Google Maps & Geolocation APIs for hyper-localized alerts.
- Allow users to share alerts with friends and family.
- Process engagement data using Pandas for analytical insights.

## Features

### Core Weather Alert Integration

- **Description:** Integrates Weatherbit API to fetch severe weather data, filter relevant alerts, and make them available via a RESTful Flask backend.
- **User Benefit:** Ensures timely and actionable weather alerts for local residents to take necessary precautions.

### Push Notification Service Integration

- **Description:** Uses OneSignal to deliver real-time push notifications to users' devices.
- **User Benefit:** Provides immediate alerts and safety instructions during severe weather events.

### Interactive Map & Location-Based Alert Filtering

- **Description:** Leverages Google Maps and Geolocation APIs to display alerts on an interactive map, filtering them based on user-defined proximity.
- **User Benefit:** Offers hyper-localized weather information to reduce noise and improve preparedness.

### Alert Sharing and Contact Management

- **Description:** Enables users to share alerts with trusted contacts and manage their contact lists within the app.
- **User Benefit:** Enhances community safety by spreading critical information quickly.

### Analytics Dashboard and Engagement Tracking

- **Description:** Processes engagement logs using Pandas to generate key performance metrics and visual dashboards.
- **User Benefit:** Allows administrators and data analysts to monitor alert effectiveness and optimize the system based on real usage data.

## Tech Stack

- **Frontend Framework:** React Native with NativeWind CSS (for streamlined styling)
- **Backend Technology:** Flask (Python)
- **Database:** PostgreSQL
- **APIs & Integrations:**
  - Weatherbit API (for severe weather data)
  - Google Maps & Geolocation APIs (for interactive maps and location detection)
  - OneSignal (for push notification delivery)
- **Analytics & Data Processing:** Pandas (Python)
- **Testing & Quality Assurance:**
  - pytest (for API, unit, and integration tests)
  - Detox (for end-to-end mobile app testing)
- **Deployment:**
  - Frontend: Demo deployment via Expo Go app
  - Backend: Flask application on EC2 instance
- **CI/CD:** GitHub Actions
- **Testing:** pytest, Detox

## Architecture Diagram

Below is a simplified diagram showing how different components of the system interact:

```plaintext
                    +----------------------------------+
                    |         User Devices           |
                    |  (iOS/Android via Expo Go App)   |
                    +---------------+------------------+
                                    |
                                    | (React Native App via Expo)
                                    V
                    +----------------------------------+
                    |         Frontend Layer           |
                    |    React Native with NativeWind  |
                    +---------------+------------------+
                                    |
                                    | REST API Calls
                                    V
                    +----------------------------------+
                    |         Backend API Layer        |
                    |         (Flask Application)      |
                    +---------------+------------------+
                     /      |         \         \
                    /       |          \         \
                   V        V           V         V
       +----------------+ +--------------+  +--------------+  
       | Weatherbit API | |  OneSignal   |  | Google Maps  |  
       | (Weather Data) | | (Push Notif.)|  | & Geolocation|
       +----------------+ +--------------+  +--------------+  
                          \       |        /
                           \      |       /
                            V     V      V
                    +----------------------------------+
                    |         PostgreSQL Database      |
                    | (User Data, Alerts, Engagement   |
                    |  Logs, Preferences & History)    |
                    +----------------------------------+
                                    |
                                    | Analytics Processing
                                    V
                    +----------------------------------+
                    |         Analytics Module         |
                    |         (Pandas Scripts)         |
                    +----------------------------------+
```

## Development Environment Setup

### Backend Setup (Flask & PostgreSQL)

1. **Clone the Repository:**

   ```bash
   git clone <repository-url>
   cd project-directory
   ```

2. **Create a Python Virtual Environment:**

   ```bash
   python -m venv venv
   source venv/bin/activate  # Windows: venv\Scripts\activate
   ```

3. **Install Dependencies:**

   ```bash
   pip install -r requirements.txt
   ```

4. **Database Setup:**

   - Install PostgreSQL and create a new database (e.g., `weather_alerts_db`).
   - Configure the connection settings in your configuration file (`config.py` or via environment variables).
   - Run migration scripts (using Alembic or Flask-Migrate).

5. **Environment Variables:**

   - Create a `.env` file with variables such as `WEATHERBIT_API_KEY`, `ONESIGNAL_API_KEY`, `GOOGLE_MAPS_API_KEY`, and `DATABASE_URL`.

### Testing Environment Setup

  ```bash
  pip install pytest pytest-flask
  ```

- Follow Detox documentation for simulator setup.

### CI/CD Setup

- Configure a CI pipeline (using GitHub Actions, CircleCI, etc.) to run tests automatically on each commit.
- Securely store your environment variables in your CI/CD tool.

## Technical Challenges & Solutions

- **Third-Party API Integration:**
  - **Challenge:** Handling rate limits, downtime, or latency issues with Weatherbit, OneSignal, and Google Maps.
  - **Solution:** Implement robust error handling, retries, caching, and fallback mechanisms.

- **Real-Time Data Accuracy:**
  - **Challenge:** Keeping weather alerts updated in near real-time.
  - **Solution:** Optimize polling frequency, consider webhooks, and apply event-driven updates when available.

- **Push Notification Reliability:**
  - **Challenge:** Timely delivery of push notifications across networks.
  - **Solution:** Utilize OneSignal's retry features, monitor deliveries, and incorporate user feedback.

- **Geolocation and Map Rendering:**
  - **Challenge:** Variability in geolocation accuracy and smooth map performance.
  - **Solution:** Use device-native geolocation APIs, test on various devices, and optimize map rendering with clustering techniques.

- **Data Volume and Analytics:**
  - **Challenge:** Efficient processing of large data volumes.
  - **Solution:** Leverage Pandas for in-memory processing and optimize PostgreSQL queries with indexing.

- **Development & Testing Coordination:**
  - **Challenge:** Ensuring seamless collaboration and continuous integration.
  - **Solution:** Follow Lean Agile principles with shift-left testing, daily stand-ups, and integrated automated tests.

- **Expo Demo Constraints:**
  - **Challenge:** Ensuring the app functions seamlessly within the Expo Go environment.
  - **Solution:** Regularly test on Expo Go, use Expo debugging tools, and refer to the Expo documentation for environment-specific issues.

## Testing

- **Unit & Integration Testing:**  
  Use `pytest` for backend API endpoints and service layers.
- **End-to-End Testing:**  
  Use Detox for React Native app flows.
- **Regression Testing:**  
  Continuously run tests in your CI/CD pipeline to catch regressions.
- **Performance Testing:**  
  Optionally use tools like Locust or JMeter for load testing critical endpoints.

## Contributing

1. **Fork the Repository**
2. **Clone your Fork:**

   ```bash
   git clone <your-fork-url>
   ```

3. **Create a Feature Branch:**

   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Commit and Push your Changes**

5. **Create a Pull Request** detailing your changes.

Please follow our code style guidelines and commit message conventions.

## License

This project is licensed under the [MIT License](LICENSE).

Happy coding! 🚀
