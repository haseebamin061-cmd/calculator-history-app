async function calculate() {

    // Read values from HTML
    const num1 = document.getElementById("num1").value;
    const num2 = document.getElementById("num2").value;
    const operation = document.getElementById("operation").value;

    // Send request to Flask
    const response = await fetch("/calculate", {

        method: "POST",

        headers: {
            "Content-Type": "application/json"
        },

        body: JSON.stringify({
            num1: num1,
            num2: num2,
            operation: operation
        })

    });

    // Read JSON response
    const data = await response.json();

    // Show result
    document.getElementById("result").innerHTML =
        "Result: " + data.result;

    // Refresh history automatically
    loadHistory();
}

async function loadHistory() {

    // Request history from Flask
    const response = await fetch("/history");

    // Convert JSON into JavaScript object
    const history = await response.json();

    // Get UL element
    const list = document.getElementById("history");

    // Clear previous history
    list.innerHTML = "";

    // Add every calculation
    history.forEach(item => {

        const li = document.createElement("li");

        li.innerHTML =
            `${item.num1} ${item.operation} ${item.num2} = ${item.result}`;

        list.appendChild(li);

    });

}

// Load history when page opens
loadHistory();
