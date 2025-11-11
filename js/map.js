// Configuración del mapa
const mapConfig = {
    center: [-16.5, -68.15],
    zoom: 13,
    bounds: [[-16.62, -68.24], [-16.43, -68.02]]
};

// Lugares comunes con coordenadas exactas
const commonPlaces = {
    "plaza estudiante": [-16.5041, -68.1311],
    "plaza murillo": [-16.4958, -68.1336],
    "miraflores": [-16.4989, -68.1219],
    "prado": [-16.5050, -68.1345],
    "terminal": [-16.4887, -68.1418],
    "umsa": [-16.5042, -68.1331],
    "cementerio": [-16.4969, -68.1517],
    "teleferico central": [-16.4897, -68.1335],
    "ceja": [-16.5029, -68.1751],
    "achachical": [-16.4839, -68.1350],
    "villa victoria": [-16.5248, -68.1639]
};

class MapManager {
    constructor() {
        this.map = null;
        this.userMarker = null;
        this.destMarker = null;
        this.lastClicked = null;
        this.initMap();
    }

    initMap() {
        this.map = L.map('map', { zoomControl: true }).setView(mapConfig.center, mapConfig.zoom);
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', { 
            maxZoom: 18, 
            attribution: '© OpenStreetMap' 
        }).addTo(this.map);

        const lpBounds = L.latLngBounds(mapConfig.bounds[0], mapConfig.bounds[1]);
        this.map.setMaxBounds(lpBounds);
        this.map.on('drag', () => this.map.panInsideBounds(lpBounds, { animate: false }));
        this.map.on('click', e => this.lastClicked = e.latlng);

        this.userMarker = L.marker(mapConfig.center).addTo(this.map).bindPopup("Tu ubicación");
    }

    markDestination(name) {
        let coords = null;
        if (name) {
            const key = name.trim().toLowerCase();
            if (commonPlaces[key]) coords = commonPlaces[key];
        }
        if (!coords && this.lastClicked) coords = [this.lastClicked.lat, this.lastClicked.lng];
        if (!coords) coords = mapConfig.center;

        if (this.destMarker) this.map.removeLayer(this.destMarker);
        this.destMarker = L.marker(coords).addTo(this.map)
            .bindPopup("Destino: " + (name || "Sin nombre"))
            .openPopup();
        
        this.map.setView(coords, 14);
        return coords;
    }

    getUserLocation() {
        return new Promise((resolve, reject) => {
            if (!navigator.geolocation) {
                reject('Geolocalización no disponible');
                return;
            }

            navigator.geolocation.getCurrentPosition(
                pos => {
                    const { latitude, longitude } = pos.coords;
                    const latlng = L.latLng(latitude, longitude);
                    const lpBounds = L.latLngBounds(mapConfig.bounds[0], mapConfig.bounds[1]);

                    if (!lpBounds.contains(latlng)) {
                        reject('Tu ubicación está fuera de La Paz');
                        return;
                    }

                    if (this.userMarker) this.map.removeLayer(this.userMarker);
                    this.userMarker = L.marker(latlng).addTo(this.map)
                        .bindPopup("Tu ubicación")
                        .openPopup();
                    
                    this.map.setView(latlng, 14);
                    resolve([latitude, longitude]);
                },
                err => reject('No se pudo obtener la ubicación'),
                { enableHighAccuracy: true, timeout: 8000 }
            );
        });
    }

    getRoutePoints() {
        const user = this.userMarker ? this.userMarker.getLatLng() : null;
        const dest = this.destMarker ? this.destMarker.getLatLng() : null;
        
        if (!user || !dest) {
            throw new Error('Marca tu ubicación y un destino para buscar rutas');
        }

        return {
            from: [user.lat, user.lng],
            to: [dest.lat, dest.lng]
        };
    }
}