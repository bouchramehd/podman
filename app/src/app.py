from flask import Flask, jsonify
import os
import mysql.connector

app = Flask(__name__)

@app.route('/health')
def health():
    return jsonify({"status": "healthy"}), 200

@app.route('/data')
def data():
    try:
        conn = mysql.connector.connect(
            host=os.environ.get('DB_HOST', 'mysql'),  # Use 'mysql' if that's your network alias
            user=os.environ.get('DB_USER', 'root'),
            password=os.environ.get('DB_PASSWORD', 'password'),
            database=os.environ.get('DB_NAME', 'test_db')
        )
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM test_table")
        rows = cursor.fetchall()
        result = [{"id": row[0], "message": row[1]} for row in rows]
        cursor.close()
        conn.close()
        return jsonify(result), 200
    except mysql.connector.Error as err:
        return jsonify({"error": str(err)}), 500

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=4743)
