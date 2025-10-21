
# 🚍 Proyecto GPS de Rutas de Transporte en La Paz, Bolivia

Este repositorio contiene la parte frontend y archivos relacionados para una aplicación de visualización de rutas de minibuses en La Paz (Flutter + web estática) y un backend ligero en Node.js con SQLite.

---

## Inicio rápido (Windows - PowerShell)

Sigue estos pasos para clonar el repositorio, instalar dependencias y levantar la aplicación en un entorno Windows usando PowerShell.

1) Clonar el repositorio:

```powershell
git clone git@github.com:GabrieJimenez876/GPS-Fronted.git
cd "GPS-Fronted"
```

Si prefieres HTTPS:

```powershell
git clone https://github.com/GabrieJimenez876/GPS-Fronted.git
cd "GPS-Fronted"
```

2) Requisitos (instalar si no los tienes):

- Git: https://git-scm.com/
- Node.js (incluye npm): https://nodejs.org/ (recomendado LTS)
- Flutter + Dart (si vas a ejecutar la parte Flutter): https://flutter.dev/docs/get-started/install
- SQLite (opcional, el proyecto puede usar un script para inicializar la DB): https://www.sqlite.org/download.html

3) Instalar dependencias del backend (Node.js):

```powershell
# desde la raíz del proyecto
npm install
```

4) Instalar dependencias de Flutter (si usarás Flutter):

```powershell
flutter pub get
```

5) Inicializar base de datos SQLite (si existe script):

```powershell
# Si el proyecto incluye un script JS para crear la DB
node initdb.js
```

6) Ejecutar el backend (Node.js):

```powershell
npm start
# o, si el package.json tiene un script dev
npm run dev
```

7) Ejecutar el frontend web estático:

- Abre `index.html` en el navegador (doble clic) o usa un servidor estático (recomendado):

```powershell
# Servir la carpeta actual en el puerto 8080 (requiere http-server o similar)
npx http-server -c-1 -p 8080
# luego abrir http://localhost:8080/index.html
```

8) Ejecutar la app Flutter (opcional):

```powershell
# Ejecutar en Chrome
flutter run -d chrome
# Ejecutar en emulador Android
flutter emulators --launch <emulator_id>; flutter run
```

---

## Credenciales de prueba

- Usuario: `admin`
- Contraseña: `1234`

Usa estas credenciales para pruebas locales en el backend/servicios que respeten autenticación.

---

## Instalación detallada y verificación de requisitos (Windows - PowerShell)

Instala y verifica las siguientes herramientas antes de intentar ejecutar la aplicación.

1) Git

```powershell
git --version
# Debe mostrar una versión, p. ej. git version 2.x.x
```

2) Node.js y npm

```powershell
node --version
npm --version
# Recomendado: Node.js LTS (>= 16.x)
```

3) Flutter (si usarás la parte móvil/web)

```powershell
flutter --version
# Sigue la guía oficial si falta: https://flutter.dev/docs/get-started/install/windows
```

4) SQLite (opcional)

```powershell
sqlite3 --version
# Si no está disponible, muchas operaciones pueden ejecutarse mediante librerías de Node.js que usan sqlite3 internamente.
```

5) Paquetes NPM adicionales (servidor estático):

```powershell
npx http-server --version
# Si no está instalado globalmente, npx lo usará desde npm
```

---

## Tecnologías y herramientas usadas

Aquí están las principales tecnologías, frameworks y librerías usadas en el proyecto:

- Flutter & Dart — Frontend móvil (Android/iOS) y Flutter Web.
- HTML5 + CSS3 — Frontend web estático.
- Leaflet.js — Librería JavaScript para mapas interactivos.
- OpenStreetMap — Fuente de mapas y teselas.
- Node.js + Express — Backend y API REST.
- SQLite — Base de datos ligera y portable.
- JSON Web Tokens (JWT) — Autenticación basada en tokens.
- npm / npx — Gestión de paquetes y ejecución de herramientas.
- http-server (opcional) — Servidor estático para pruebas locales.

Archivos y carpetas importantes en este repositorio:

- `index.html` — Mapa web estático con Leaflet.
- `mapa_page.dart`, `agregar_linea_page.dart` — Páginas Flutter relevantes.
- `server.js` / `api/` — Código del backend (si aplica).
- `punt.json` — Datos de paradas/elementos geojson.
- `pubspec.yaml` — Dependencias de Flutter.

---

## Cómo ejecutar (resumen)

1. Instalar dependencias:

```powershell
npm install
flutter pub get
```

2. Inicializar la base de datos (si existe script):

```powershell
node initdb.js
```

3. Ejecutar backend:

```powershell
npm start
# o
npm run dev
```

4. Servir frontend web:

```powershell
npx http-server -c-1 -p 8080
# Abrir: http://localhost:8080/index.html
```

5. Ejecutar Flutter (opcional):

```powershell
flutter run -d chrome
```

---

Si quieres, puedo:

- Añadir un script `initdb.js` o `scripts/init_db.ps1` si no existe para automatizar la creación de la base de datos.
- Crear un pequeño archivo `run-local.ps1` que ejecute los comandos de inicialización y arranque en el orden correcto para Windows.

Dime si quieres que añada alguno de esos scripts y lo implemento.


## 🔐 Configuración del Repositorio

### Configurar SSH en VS Code

1. Abrir terminal en VS Code (Ctrl + Ñ) y ejecutar:
```powershell
# Reiniciar SSH Agent
Stop-Service ssh-agent
Start-Service ssh-agent
# Limpiar agente SSH
ssh-add -D

# Generar nueva clave SSH
ssh-keygen -t ed25519 -C "tu_email@gmail.com"
# Presionar Enter en todas las preguntas
# Agregar clave al agente
ssh-add ~/.ssh/id_ed25519

# Crear archivo config
notepad ~/.ssh/config
```

2. En el archivo config, pegar:
```
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
```

3. Mostrar y copiar clave pública:
```powershell
cat ~/.ssh/id_ed25519.pub
```

4. Agregar clave en GitHub:
   - Ir a https://github.com/settings/keys
   - Click "New SSH key"
   - Pegar clave y guardar

5. Probar conexión:
```powershell
ssh -T git@github.com
```

---

## 🧱 Estructura del Proyecto

- **Frontend móvil:** Flutter (compatible con Android, iOS y Web)
- **Frontend web:** HTML + Leaflet.js + OpenStreetMap
- **Backend:** Node.js + Express
- **Base de datos:** SQLite 
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
- SQLite (base de datos local)
- API RESTful

### Base de Datos
- SQLite3 para almacenamiento local
- Migraciones automáticas
- Backup automático
- No requiere servidor de base de datos

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

- Base de datos SQLite para mayor portabilidad y facilidad de despliegue
- El mapa está limitado geográficamente a La Paz, Bolivia
- Las rutas y paradas se cargan dinámicamente desde la base de datos
- Soporte para modo offline utilizando caché local
- Interfaz responsive adaptada a móvil y escritorio

## 🔄 Sincronización

Para sincronizar el repositorio en otra PC:

1. Clonar el repositorio:
```powershell
git clone git@github.com:GabrieJimenez876/GPS-Fronted.git
cd GPS-Fronted
```

2. Configurar Git:
```powershell
git config user.name "Tu Nombre"
git config user.email "tu_email@gmail.com"
```

3. Instalar dependencias:
```powershell
flutter pub get  # Para Flutter
npm install     # Para Node.js
```

4. Inicializar base de datos SQLite:
```powershell
node initdb.js
```

## 💡 Mejoras Futuras

- Implementación de PWA para acceso offline completo
- Sincronización de datos en tiempo real
- Notificaciones push para actualizaciones de rutas
- Integración con APIs de clima y tráfico
