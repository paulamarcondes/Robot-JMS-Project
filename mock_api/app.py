# app.py

from flask import Flask, request, jsonify
from data_store import inmates_db
import uuid

app = Flask(__name__)

@app.errorhandler(Exception)
def handle_exception(e):
    app.logger.error(f"Server error: {e}")
    return jsonify(error="Internal server error"), 500

@app.route('/inmates', methods=['POST'])
def create_inmate():
    try:
        data = request.get_json()
        required = ['name', 'bookingDate', 'facility', 'crimeType', 'priority']
        if not all(f in data for f in required):
            return jsonify(error="Missing required field"), 400

        iid = str(uuid.uuid4())
        inmate = {'id': iid, **data}
        inmates_db[iid] = inmate
        return jsonify(inmate), 201
    except Exception as e:
        return handle_exception(e)

@app.route('/inmates', methods=['GET'])
def get_all_inmates():
    try:
        return jsonify(list(inmates_db.values()))
    except Exception as e:
        return handle_exception(e)

@app.route('/inmates/<id>', methods=['GET'])
def get_inmate(id):
    try:
        inmate = inmates_db.get(id)
        return jsonify(inmate) if inmate else jsonify(error="Not found"), 404
    except Exception as e:
        return handle_exception(e)

@app.route('/inmates/<id>', methods=['PUT'])
def update_inmate(id):
    try:
        if id not in inmates_db:
            return jsonify(error="Not found"), 404
        data = request.get_json()
        updated = {**inmates_db[id], **data}
        inmates_db[id] = updated
        return jsonify(updated)
    except Exception as e:
        return handle_exception(e)

@app.route('/inmates/<id>', methods=['DELETE'])
def delete_inmate(id):
    try:
        if id not in inmates_db:
            return jsonify(error="Not found"), 404
        del inmates_db[id]
        return jsonify(message="Inmate deleted successfully"), 200
    except Exception as e:
        return handle_exception(e)

if __name__ == '__main__':
    app.run(debug=False)