# 🛠️ JMS API - Robot Framework Tests

![CI](https://github.com/paulamarcondes/RobotJMSProject/actions/workflows/ci.yml/badge.svg)

This is a mini-project for practicing **API test automation** using [Robot Framework](https://robotframework.org/), focused on a simulated **Jail Management System (JMS)**.

Tests are organized into basic, positive, negative, and server-failure scenarios.  
The project uses **Docker** to run the API and **GitHub Actions** for CI/CD.


---


## 📦 Project Structure

    ├── README.md
    ├── requirements.txt
    ├── .gitignore
    ├── .github/
    │   └── workflows/
    │       └── ci.yml             # GitHub Actions workflow
    ├── api/
    │   ├── app.py                 # Mock Flask API
    │   └── API-DOC.md             # API specification
    ├── docker/
    │   └── Dockerfile             # API container setup
    ├── reports/
    │   ├── log.html
    │   ├── output.xml
    │   └── report.html
    ├── resources/
    │   ├── keywords.robot         # Reusable keywords
    │   └── variables.robot        # Test data variables
    ├── tests/
    │   ├── 0.basic_tests.robot
    │   ├── 1.positive_tests.robot
    │   ├── 2.negative_tests.robot
    │   └── 3.server_tests.robot


---


## ▶️ How to Run Locally

1. Install dependencies:

    pip install flask requests robotframework robotframework-requests robotframework-faker


2. Start the API:

    python api/app.py


3. Run the tests:

    robot -d reports tests/

> 🧪 To run `3.server_tests.robot`, **manually stop the API first**.


---


## 🔄 GitHub Actions CI

Every push to `main` runs:

- The mock API in Docker
- All Robot tests (except server tests)
- Uploads `log.html` and `report.html` as downloadable artifacts

Check them in the **Actions** tab → run → "Artifacts".


---


## ✅ Highlights

- Clean and modular test structure
- Covers both expected and edge-case behaviors
- Uses Flask + Docker + Robot Framework + GitHub Actions