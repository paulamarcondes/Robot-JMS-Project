# app.py

from flask import Flask, request, jsonify
from data_store import inmates_db
import uuid

app = Flask(__name__)

REQUIRED_FIELDS = ['name', 'bookingDate', 'facility', 'crimeType', 'priority']

@app.errorhandler(Exception)
def handle_exception(e):
    app.logger.error(f"Server error: {e}")
    return jsonify(error="Internal server error"), 500

def validate_fields(data):
    missing = [field for field in REQUIRED_FIELDS if field not in data]
    if missing:
        return jsonify(error=f"Missing required fields: {', '.join(missing)}"), 400
    return None

@app.route('/inmates', methods=['POST'])
def create_inmate():
    data = request.get_json()
    error = validate_fields(data)
    if error:
        return error

    iid = str(uuid.uuid4())
    inmate = {'id': iid, **data}
    inmates_db[iid] = inmate
    return jsonify(inmate), 201

@app.route('/inmates', methods=['GET'])
def get_all_inmates():
    return jsonify(list(inmates_db.values())), 200

@app.route('/inmates/<id>', methods=['GET'])
def get_inmate(id):
    inmate = inmates_db.get(id)
    if not inmate:
        return jsonify(error="Not found"), 404
    return jsonify(inmate), 200

@app.route('/inmates/<id>', methods=['PUT'])
def update_inmate(id):
    if id not in inmates_db:
        return jsonify(error="Not found"), 404

    data = request.get_json()
    inmates_db[id].update(data)
    return jsonify(inmates_db[id]), 200

@app.route('/inmates/<id>', methods=['DELETE'])
def delete_inmate(id):
    if id not in inmates_db:
        return jsonify(error="Not found"), 404

    del inmates_db[id]
    return '', 204  # No Content

if __name__ == '__main__':
    app.run(debug=False)
