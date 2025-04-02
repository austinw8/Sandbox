function checkNumber() {
    const numInput = document.getElementById("user-input").value;
    const result = document.getElementById("result-div");

    const regex = /^(1\s?)?(\(\d{3}\)|\d{3})[\s.-]?\d{3}[\s.-]?\d{4}$/;

    if (!numInput) {
        result.textContent = "Please provide a phone number";
        result.style.color = "red";
    } else if (regex.test(numInput)) {
        result.textContent = `Valid US Number: ${numInput}`;
        result.style.color = "green";
    } else {
        result.textContent = " Invalid Phone Number";
        result.style.color = "red";
    }
}

function clearInput() {
    document.getElementById("user-input").value = "";
    document.getElementById("result-div").textContent = "";
}

// ❌
// ✅