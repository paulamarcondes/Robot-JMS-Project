# app.py

from flask import Flask, request, jsonify
from data_store import inmates_db
import uuid

app = Flask(__name__)

@app.route('/inmates', methods=['POST'])
def create_inmate():
    data = request.get_json()
    required_fields = ['name', 'bookingDate', 'facility', 'crimeType', 'priority']
    
    for field in required_fields:
        if field not in data:
            return jsonify(error="Missing required field", message=f"Field '{field}' is required"), 400

    inmate_id = str(uuid.uuid4())
    new_inmate = {
        'id': inmate_id,
        **data
    }
    inmates_db[inmate_id] = new_inmate
    return jsonify(new_inmate), 201

@app.route('/inmates', methods=['GET'])
def get_all_inmates():
    return jsonify(list(inmates_db.values()))

@app.route('/inmates/<id>', methods=['GET'])
def get_inmate(id):
    inmate = inmates_db.get(id)
    if not inmate:
        return jsonify(error="Resource not found", message=f"No inmate found with ID '{id}'"), 404
    return jsonify(inmate)

@app.route('/inmates/<id>', methods=['PUT'])
def update_inmate(id):
    if id not in inmates_db:
        return jsonify(error="Resource not found", message=f"No inmate found with ID '{id}'"), 404
    
    data = request.get_json()
    updated = {**inmates_db[id], **data}
    inmates_db[id] = updated
    return jsonify(updated)

@app.route('/inmates/<id>', methods=['DELETE'])
def delete_inmate(id):
    if id not in inmates_db:
        return jsonify(error="Resource not found", message=f"No inmate found with ID '{id}'"), 404
    
    del inmates_db[id]
    return '', 204

if __name__ == '__main__':
    app.run(debug=True)