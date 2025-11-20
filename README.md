# JMS API - Robot Framework

![GitHub Actions CI](https://github.com/paulamarcondes/Robot-JMS-Project/actions/workflows/ci.yml/badge.svg)

Mini-project for **API test automation** using [Robot Framework](https://robotframework.org/), focused on a simulated **Jail Management System (JMS)**.


---

## Project Structure

- `tests/`: Test cases and scenarios.
- `resources/`: Reusable keywords and variables.
- `api/`: Mock API with Flask, and Docker.
- `reports/`: Robot Framework logs and reports.
- `.github/workflows/`: GitHub Actions CI configuration (`ci.yml`).

---

## Technologies

- Flask
- Robot Framework
- Docker
- GitHub Actions (CI/CD)

---

## Test Types

| Type           | Description                                      |
|----------------|--------------------------------------------------|
| Basic          | API sanity and health checks                     |
| Positive       | Happy path - expected behaviors                  |
| Negative       | Invalid inputs and error handling                |
| Server-failure | Simulates outages or 500 errors                  |

---


## How to run locally

### 1. Clone the repository

```bash
git clone https://github.com/paulamarcondes/Robot-JMS-Project.git
cd Robot-JMS-Project
```

### 2. Build the API Docker image

```bash
docker build -t robot-jms:latest -f docker/Dockerfile .
```

### 3. Run the API

```bash
docker run -d -p 5000:5000 --name api robot-jms:latest
```

### 4. Run Robot Framework tests

```bash
mkdir -p reports
robot -d reports tests/0.basic_tests.robot tests/1.positive_tests.robot tests/2.negative_tests.robot
```

---


## How CI Works

Every push to the `main` branch:
1. Builds and runs the Flask API inside a Docker container.
2. Waits for the `/health` endpoint to respond.
3. Executes Robot Framework tests.
4. Prints the path to the reports inside the CLI logs.


---


## Notes

- You can view logs (`log.html`) and reports (`report.html`) in the `reports/` folder after running tests locally.
- For CI runs, logs are not uploaded as artifacts (you’ll see CLI paths only).


---


## Author

Created with ❤️ by [Paula Marcondes](https://www.linkedin.com/in/paulamarcondes/)


---
