## Jail System Mock API

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



### 1. Create New Inmate Booking
- **POST** `/inmates`
- **Request Body**:
```json
{
  "name": "John Doe",
  "bookingDate": "2024-04-05T14:30:00Z",
  "facility": "County Jail A",
  "crimeType": "Misdemeanor",
  "priority": "Medium"
}
```
- **Success Response**: `201 Created` with full inmate record including generated `id`.


---

### 2. Get All Inmates
- **GET** `/inmates`
- **Response**: Array of all stored inmates.
- **Status Code**: `200 OK`


---

### 3. Get Single Inmate by ID
- **GET** `/inmates/<id>`
- **Path Parameter**: `<id>` – UUID string
- **Response**: Single inmate object or `404 Not Found`


---

### 4. Update Inmate Booking
- **PUT** `/inmates/<id>`
- **Request Body**: Any combination of fields from POST
- **Success Response**: Updated inmate object (`200 OK`)
- **Failure**: `404 Not Found` if ID does not exist


---

### 5. Delete Inmate Booking
- **DELETE** `/inmates/<id>`
- **Success Response**: `204 No Content`
- **Failure**: `404 Not Found`


---

## 📦 Example Inmate Record (Response Format)

```json
{
  "id": "abc123",
  "name": "John Doe",
  "bookingDate": "2024-04-05T14:30:00Z",
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
   "error": "Resource not found",
   "message": "No inmate found with ID 'xyz'"
 }
 ```

```json
{
  "error": "Internal server error",
  "message": "An unexpected error occurred"
}
```


The following HTTP status codes may be returned:

- `400 Bad Request`: Missing or invalid request data
- `404 Not Found`: Inmate with specified ID does not exist
- `500 Internal Server Error`: An unexpected server-side error occurred


---
