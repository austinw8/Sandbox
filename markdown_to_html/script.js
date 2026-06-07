function convertMarkdown() {
  const input = document.getElementById("markdown-input").value;
  let html = input;

  // Images before links to avoid partial match on []
  html = html.replace(/!\[(.*?)\]\((.*?)\)/g, '<img alt="$1" src="$2">');

  // Links
  html = html.replace(/\[(.*?)\]\((.*?)\)/g, '<a href="$2">$1</a>');

  // Bold (**text** or __text__) before italic to avoid * collision
  html = html.replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>");
  html = html.replace(/__(.*?)__/g, "<strong>$1</strong>");

  // Italic (*text* or _text_)
  html = html.replace(/\*(.*?)\*/g, "<em>$1</em>");
  html = html.replace(/_(.*?)_/g, "<em>$1</em>");

  // Headings h3→h2→h1 (longer prefix first)
  html = html.replace(/^\s*### (.*)$/gm, "<h3>$1</h3>");
  html = html.replace(/^\s*## (.*)$/gm, "<h2>$1</h2>");
  html = html.replace(/^\s*# (.*)$/gm, "<h1>$1</h1>");

  // Blockquotes (only at start of line)
  html = html.replace(/^\s*> (.*)$/gm, "<blockquote>$1</blockquote>");

  // Strip newlines so elements are concatenated with no separator
  html = html.replace(/\n/g, "");

  return html;
}

document.addEventListener("DOMContentLoaded", function () {
  document.getElementById("markdown-input").addEventListener("input", function () {
    const result = convertMarkdown();
    document.getElementById("html-output").textContent = result;
    document.getElementById("preview").innerHTML = result;
  });
});
