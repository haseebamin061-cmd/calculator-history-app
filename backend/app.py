import os
import mysql.connector
db = mysql.connector.connect(
    host=os.getenv("DB_HOST"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    database=os.getenv("DB_NAME")
)

cursor = db.cursor()


from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route("/")
def home():
    return "Calculator Backend API is running!"

@app.route("/calculate", methods=["POST"])
def calculate():

    data = request.get_json()

    num1 = float(data["num1"])
    num2 = float(data["num2"])
    operation = data["operation"]

    if operation == "add":
        result = num1 + num2

    elif operation == "subtract":
        result = num1 - num2

    elif operation == "multiply":
        result = num1 * num2

    elif operation == "divide":
        result = num1 / num2

    else:
        return jsonify({"error": "Invalid Operation"}), 400

    query = """
    INSERT INTO history
    (num1, num2, operation, result)
    VALUES (%s, %s, %s, %s)
    """

    cursor.execute(
        query,
        (num1, num2, operation, result)
    )

    db.commit()

    return jsonify({
        "result": result
     })


@app.route("/history", methods=["GET"])
def history():

    cursor.execute("""
        SELECT num1, num2, operation, result
        FROM history
        ORDER BY id DESC
        LIMIT 10
    """)

    rows = cursor.fetchall()

    history = []

    for row in rows:

        history.append({

            "num1": row[0],

            "num2": row[1],

            "operation": row[2],

            "result": row[3]

        })

    return jsonify(history)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
