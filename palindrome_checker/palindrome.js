function checkPalindrome() {
    let input = document.getElementById("text-input").value.trim();
    let result = document.getElementById("result");

    if (input === "") {
        alert("⚠️ Please input a value ⚠️");
    } else {
        let inputCleaned = input.toLowerCase().replace(/[^a-z0-9]/g, "");
        const inputReversed = inputCleaned.split("").reverse().join("");

        if (inputCleaned === inputReversed) {
            result.innerText = `✅ "${input}" is a palindrome`;
        } else {
            result.innerText = `❌ "${input}" is not a palindrome`;
        }
    }
}