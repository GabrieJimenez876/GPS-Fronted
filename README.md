
# 🚍 Proyecto GPS de Rutas de Transporte en La Paz, Bolivia

Este proyecto tiene como objetivo desarrollar una aplicación móvil y web para visualizar rutas de minibuses en La Paz, Bolivia, utilizando tecnologías modernas y sin depender de PHP ni MySQL.

---

## 🧱 Estructura del Proyecto

- **Frontend móvil:** Flutter (compatible con Android, iOS y Web)
- **Frontend web:** HTML + Leaflet.js + OpenStreetMap
- **Backend:** Node.js + Express
- **Base de datos:** PostgreSQL + PostGIS
- **Mapas:** OpenStreetMap (con soporte offline opcional)
- **Autenticación:** JWT (JSON Web Tokens)

---

## 📦 Libretas y Archivos Utilizados

- `index.html` → Mapa interactivo con rutas y paradas
- `mapa_page.dart` → Página principal en Flutter con GPS y rutas
- `api/` → Backend en Node.js para consultar rutas y paradas
- `db/` → Scripts de base de datos PostgreSQL/PostGIS

---

## 🚀 Funcionalidades Principales

- Visualización de rutas de minibuses en La Paz
- GPS en tiempo real: ubicación actual y destino
- Consulta de paradas cercanas y líneas disponibles
- Cuadro informativo con sindicatos y recorridos
- Panel administrativo para gestión de rutas (en desarrollo)
- Compatible con Flutter Web para ejecución en navegador

---

## 🗺️ Tecnologías Utilizadas

### Frontend
- Flutter
- HTML5 + CSS3
- Leaflet.js
- OpenStreetMap

### Backend
- Node.js + Express
- PostgreSQL + PostGIS

---

## 👤 Usuario de Prueba

- **Usuario:** admin  
- **Contraseña:** 1234  

Con estas credenciales se puede acceder al sistema principal y probar el mapa.

---

## 📁 Instalación

1. Instalar Flutter y ejecutar `flutter pub get`
2. Ejecutar el backend con Node.js (`npm install && npm start`)
3. Crear la base de datos PostgreSQL con extensión PostGIS
4. Ejecutar la app en navegador con `flutter run -d chrome` o abrir `index.html`

---

## 📌 Notas

- Este proyecto reemplaza el uso de PHP y MySQL por tecnologías modernas.
- El mapa está limitado geográficamente a La Paz, Bolivia.
- Las rutas y paradas se cargan dinámicamente desde la base de datos.

