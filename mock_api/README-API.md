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


---

## 🧾 Requirements.txt

```
Flask==2.3.2
```

---

## 📄 data_store.py

```python
# data_store.py

inmates_db = {}
```

---

## 🐍 app.py


---