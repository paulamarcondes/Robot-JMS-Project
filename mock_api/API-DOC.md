
# Jail System Mock API

This is a simple Flask-based mock server that simulates a Jail Management System interface for inmate bookings.  
It supports basic CRUD operations and is intended for use in QA testing, especially with tools like **Robot Framework**.

---

## 🔧 Setup

1. Install dependencies:

```bash
pip install -r requirements.txt
```

2. Run the server:

```bash
python app.py
```

The API will be available at: `http://localhost:5000`

---

## 📡 Endpoints

| Method | Endpoint             | Description                          |
|--------|----------------------|--------------------------------------|
| POST   | `/inmates`           | Create a new inmate booking          |
| GET    | `/inmates`           | Get a list of all inmate bookings    |
| GET    | `/inmates/<id>`      | Get a specific inmate by ID          |
| PUT    | `/inmates/<id>`      | Update an existing inmate booking    |
| DELETE | `/inmates/<id>`      | Delete an inmate booking             |

---

## 1. Create New Inmate Booking

- **POST** `/inmates`
- **Request Body**:

```json
{
  "name": "John Doe",
  "bookingDate": "2024-04-05",
  "facility": "County Jail A",
  "crimeType": "Misdemeanor",
  "priority": "Medium"
}
```

- **Success Response**: Full inmate object including generated `id` (`201 Created`)
- **Failure**:
  - Missing required field (`400 Bad Request`)
  - Unexpected error (`500 Internal Server Error`)

---

## 2. Get All Inmates

- **GET** `/inmates`
- **Success Response**: List of all inmates (`200 OK`)
- **Failure**: Unexpected error (`500 Internal Server Error`)

---

## 3. Get Single Inmate by ID

- **GET** `/inmates/<id>`
- **Success Response**: Inmate object (`200 OK`)
- **Failure**:
  - Inmate not found (`404 Not Found`)
  - Unexpected error (`500 Internal Server Error`)

---

## 4. Update Inmate Booking

- **PUT** `/inmates/<id>`
- **Request Body**: Any combination of fields from POST
- **Success Response**: Updated inmate object (`200 OK`)
- **Failure**:
  - Inmate not found (`404 Not Found`)
  - Unexpected error (`500 Internal Server Error`)

---

## 5. Delete Inmate Booking

- **DELETE** `/inmates/<id>`
- **Success Response**: No content (`204 No Content`)
- **Failure**:
  - Inmate not found (`404 Not Found`)
  - Unexpected error (`500 Internal Server Error`)

---

## 📦 Example Inmate Record (Response Format)

```json
{
  "id": "abc123",
  "name": "John Doe",
  "bookingDate": "2024-04-05",
  "facility": "County Jail A",
  "crimeType": "Misdemeanor",
  "priority": "Medium"
}
```

---

## 🚨 Error Responses

All errors return JSON in this format:

```json
{
  "error": "Not found"
}
```

```json
{
  "error": "Internal server error"
}
```

---

## 📋 HTTP Status Codes Summary

| Status Code             | Meaning                                      |
|-------------------------|----------------------------------------------|
| `200 OK`                | General success (GET, PUT)                   |
| `201 Created`           | Inmate successfully created                  |
| `204 No Content`        | Inmate successfully deleted                  |
| `400 Bad Request`       | Missing or invalid request data              |
| `404 Not Found`         | Inmate with specified ID does not exist      |
| `500 Internal Server Error` | An unexpected server-side error occurred |

---
