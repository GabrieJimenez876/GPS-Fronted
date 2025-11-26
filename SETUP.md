# GPS Transporte — La Paz

Sistema integral de gestión y seguimiento de rutas de transporte para La Paz.

## Requisitos Previos

- **Node.js** (v14 o superior) - [Descargar](https://nodejs.org/)
- **npm** (incluido con Node.js)
- **Flutter** (para la app móvil) - [Descargar](https://flutter.dev/)
- **Dart SDK** (incluido con Flutter)

## Instalación Rápida

### 1. Clonar o descargar el proyecto

```bash
git clone https://github.com/GabrieJimenez876/GPS-Fronted.git
cd GPS-Fronted
```

### 2. Instalar dependencias Node.js

**Windows (automático):**
```bash
install-dependencies.bat
```

**Mac/Linux:**
```bash
npm install
```

### 3. Instalar dependencias Flutter (opcional, solo si usas la app móvil)

```bash
flutter pub get
```

## Ejecutar la Aplicación

### Opción A: Servidor Web (Recomendado para comenzar)

**Windows:**
```bash
start-server.bat
```

**Mac/Linux:**
```bash
npm start
```

El servidor se iniciará en:
- **Local:** http://localhost:3000
- **Red:** http://[TU_IP_LOCAL]:3000

Abre tu navegador y ve a `http://localhost:3000`

### Opción B: Aplicación Flutter (Móvil/Desktop)

```bash
flutter run
```

## Acceso desde Otra Computadora

Una vez que el servidor esté corriendo:

1. Encuentra la IP local de tu computadora:
   - **Windows:** Abre PowerShell y ejecuta `ipconfig`
   - **Mac/Linux:** Abre Terminal y ejecuta `ifconfig`

2. Desde otra computadora en la misma red, abre:
   ```
   http://[IP_DE_TU_COMPUTADORA]:3000
   ```

3. Si estás en Docker o una red diferente, considera usar:
   - ngrok para exponer localmente: `ngrok http 3000`
   - Cambiar el puerto: `set PORT=8080 && npm start`

## Estructura del Proyecto

```
├── index.html          # Página principal web
├── server.js           # Servidor Express Node.js
├── package.json        # Dependencias de Node.js
├── pubspec.yaml        # Dependencias de Flutter/Dart
├── lib/                # Código Dart/Flutter
│   ├── main.dart       # Punto de entrada
│   ├── pages/          # Páginas de la aplicación
│   ├── services/       # Servicios de API
│   └── models/         # Modelos de datos
├── android/            # Configuración Android
├── ios/                # Configuración iOS
├── css/                # Estilos CSS
├── js/                 # Scripts JavaScript
└── rutas/              # Datos de rutas
```

## Características Principales

✅ Geolocalización en tiempo real  
✅ Búsqueda de rutas optimizadas  
✅ Sistema de autenticación (web y móvil)  
✅ Panel de administración  
✅ Gestión de líneas de transporte  
✅ Sindicatos y cooperativas  
✅ API REST para integraciones  

## Problemas Comunes

### Error: "npm: command not found"
→ Instala Node.js desde https://nodejs.org/

### Error: "Puerto 3000 ya en uso"
→ Cambia el puerto: `set PORT=3001 && npm start`

### Error de geolocalización
→ Asegúrate de permitir acceso a ubicación en el navegador

### Flutter no encuentra paquetes
→ Ejecuta: `flutter pub get`

## Documentación

- [API REST](docs/API.md)
- [Guía de Desarrollo](docs/DEVELOPMENT.md)
- [Contribuciones](CONTRIBUTING.md)

## Licencia

MIT - Ver `LICENSE` para más detalles

## Contacto

Email: lapazbus@lapaz.bo  
Teléfono: 2652444 / +591 76522444

---

⭐ Si este proyecto te fue útil, considera darle una estrella en GitHub
