import MicroModal from 'micromodal';
import { createIcons, Pencil, X } from 'lucide';

let selectedTimezone = Intl.DateTimeFormat().resolvedOptions().timeZone;

document.getElementById('timezone').textContent = selectedTimezone;

const allTimezones = Intl.supportedValuesOf('timeZone');
const select = document.getElementById('timezone-select');
const searchInput = document.getElementById('timezone-search');

function populateSelect(filter = '') {
    const lower = filter.toLowerCase();
    const filtered = filter
        ? allTimezones.filter(tz => tz.toLowerCase().includes(lower))
        : allTimezones;

    select.innerHTML = '';
    filtered.forEach(tz => {
        const option = document.createElement('option');
        option.value = tz;
        option.textContent = tz;
        if (tz === selectedTimezone) option.selected = true;
        select.appendChild(option);
    });
}

populateSelect();

searchInput.addEventListener('input', () => {
    populateSelect(searchInput.value);
});

select.addEventListener('click', () => {
    if (!select.value) return;
    selectedTimezone = select.value;
    document.getElementById('timezone').textContent = selectedTimezone;
    MicroModal.close('modal-timezone');
});

function update() {
    const now = new Date();
    document.getElementById('time').textContent = now.toLocaleTimeString('en-US', {
        timeZone: selectedTimezone,
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
    });
    document.getElementById('date').textContent = now.toLocaleDateString('en-US', {
        timeZone: selectedTimezone,
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric',
    });
}

update();
setInterval(update, 1000);

MicroModal.init({
    onShow: () => {
        searchInput.value = '';
        populateSelect();
        searchInput.focus();
    },
});

createIcons({
    icons: { Pencil, X },
    attrs: { 'stroke-width': 2 },
});
