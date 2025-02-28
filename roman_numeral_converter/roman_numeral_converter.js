const numberInput = document.getElementById("number")
const output = document.getElementById("output")
const convertButton = document.getElementById("convert-btn")

function convertToRomanNumerals() {
    let number = Number(numberInput.value);
    const romanNumerals = [
        {value: 1000, numeral: "M"},
        {value: 900, numeral: "CM"},
        {value: 500, numeral: "D"},
        {value: 400, numeral: "CD"},
        {value: 100, numeral: "C"},
        {value: 90, numeral: "XC"},
        {value: 50, numeral: "L"},
        {value: 40, numeral: "XL"},
        {value: 10, numeral: "X"},
        {value: 9, numeral: "IX"},
        {value: 5, numeral: "V"},
        {value: 4, numeral: "IV"},
        {value: 1, numeral: "I"}
    ];

    let result = "";

    if (numberInput.value === "") {
        output.innerHTML = "N/A";
        alert("Please enter a valid number");
    } else if (isNaN(number)) {
        output.innerHTML = "N/A";
        alert("Please enter a valid number");
        return;
    } else if (number < 1) {
        output.innerHTML = "N/A";
        alert("Please enter a number greater than or equal to 1")
        return;
    } else if (number >= 4000) {
        output.innerHTML = "N/A";
        alert("Please enter a number less than or equal to 3999");
        return;
    } else {
        for (let i = 0; i < romanNumerals.length; i++) {
            while (number >= romanNumerals[i].value) {
                result += romanNumerals[i].numeral;
                number -= romanNumerals[i].value;
            }
        }
        output.innerHTML = result;
    }
    numberInput.value = "";    
}

convertButton.addEventListener("click", convertToRomanNumerals)

numberInput.addEventListener("keydown", function (event) {
    if (event.key === "Enter") {
        convertToRomanNumerals();
        numberInput.value = "";
    }
});