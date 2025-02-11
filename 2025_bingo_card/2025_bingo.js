document.addEventListener("DOMContentLoaded", () => {
    const cells = document.querySelectorAll('.bingo-cell');

    // Load saved state from localStorage
    cells.forEach((cell, index) => {
        const isChecked = localStorage.getItem(`bingo-cell-${index}`);
        if (isChecked === "true") {
            cell.classList.add('checked');
        }

        // Add event listener to toggle checked state, except when clicking on a link
        cell.addEventListener('click', (event) => {
            // Check if the click is on a link (anchor tag) and prevent the default behavior of checking/unchecking
            if (event.target.tagName.toLowerCase() === 'a') {
                return; // Do nothing if it's a link
            }

            // Toggle checked state on cell click
            cell.classList.toggle('checked');
            localStorage.setItem(`bingo-cell-${index}`, cell.classList.contains('checked'));
        });
    });
});