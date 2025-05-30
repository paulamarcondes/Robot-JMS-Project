# 🛠️ JMS API - Robot Framework Tests

This is a mini-project for practicing **API test automation** using [Robot Framework](https://robotframework.org/), focused on a simulated **Jail Management System**.

Tests are organized into basic, positive, negative, and server-failure scenarios.

---

## 📦 Project Structure

```
├── README.md                   # This file
├── api/
│   ├── app.py                  # Mock Flask API
│   └── API-DOC.md              # Full API specification
├── resources/
│   ├── keywords.robot          # Reusable keywords
│   └── variables.robot         # Test data variables
├── tests/
│   ├── 0.basic_tests.robot     # Basic API coverage
│   ├── 1.positive_tests.robot  # Full successful flow
│   ├── 2.negative_tests.robot  # Invalid inputs and errors
│   └── 3.server_tests.robot    # Tests with server offline
```

---

## ▶️ How to Run

1. Install dependencies:

```bash
pip install flask requests robotframework robotframework-requests robotframework-faker
```

2. Start the mock API:

```bash
python app.py
```

3. Run the tests:

```bash
robot tests/
```

> 🧪 To run server tests, **turn off the server** before executing `3.server_tests.robot`.

---

## 🔍 Highlights

- Clean, beginner-friendly and scalable
- Coverage of expected and unexpected behaviors
- Built-in server validation (`500`, connection errors)

---
