import { format } from "date-fns";

const timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;
document.getElementById("timezone").textContent = timezone;

function update() {
    const now = new Date();
    document.getElementById("time").textContent = format(now, "hh:mm:ss aaa");
    document.getElementById("date").textContent = format(now, "PPPP");
}

update();
setInterval(update, 1000);
