USE calculator;

CREATE TABLE IF NOT EXISTS history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    num1 DOUBLE,
    num2 DOUBLE,
    operation VARCHAR(20),
    result DOUBLE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
