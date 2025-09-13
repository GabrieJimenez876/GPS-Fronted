// Inicializar mapa centrado en La Paz
const map = L.map('map').setView([-16.5, -68.15], 13);

// Capa base de OpenStreetMap
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: 'Map data © <a href="https://openstreetmap.org">OpenStreetMap</a> contributors'
}).addTo(map);

// Marcadores
let userMarker = null;
let destMarker = null;

// Botones y elementos
const locateBtn = document.getElementById('locateBtn');
const markBtn = document.getElementById('markBtn');
const destInput = document.getElementById('dest');
const resultsDiv = document.getElementById('results');

// 1) Localizar al usuario
locateBtn.addEventListener('click', () => {
    if (!navigator.geolocation) {
        alert('Geolocalización no soportada por tu navegador');
        return;
    }

    navigator.geolocation.getCurrentPosition(position => {
        const { latitude, longitude } = position.coords;
        if (userMarker) map.removeLayer(userMarker);

        userMarker = L.marker([latitude, longitude]).addTo(map)
            .bindPopup('Tu ubicación').openPopup();

        map.setView([latitude, longitude], 15);
        resultsDiv.innerHTML = `<p>Ubicación detectada: ${latitude.toFixed(5)}, ${longitude.toFixed(5)}</p>`;
    }, () => {
        alert('No se pudo obtener tu ubicación');
    });
});

// 2) Marcar destino con el valor del input
markBtn.addEventListener('click', () => {
    const destino = destInput.value.trim();
    if (!destino) {
        resultsDiv.innerHTML = '<p style="color:#b91c1c">Escribe un destino</p>';
        return;
    }

    // Ejemplo: coordenadas simuladas (en app real, usar geocoding)
    const destLatLng = [-16.5 + Math.random() * 0.01, -68.15 + Math.random() * 0.01];

    if (destMarker) map.removeLayer(destMarker);

    destMarker = L.marker(destLatLng, {icon: L.icon({iconUrl: 'https://cdn-icons-png.flaticon.com/512/684/684908.png', iconSize: [32, 32]})})
        .addTo(map)
        .bindPopup(destino)
        .openPopup();

    map.setView(destLatLng, 15);
    resultsDiv.innerHTML = `<p>Destino marcado: ${destino} (${destLatLng[0].toFixed(5)}, ${destLatLng[1].toFixed(5)})</p>`;
});
