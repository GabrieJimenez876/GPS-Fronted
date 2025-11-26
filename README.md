# 🚍 GPS Transporte — La Paz, Bolivia

Sistema integral de visualización y gestión de rutas de transporte para La Paz. Aplicación completa con frontend web estático, backend Node.js, y opciones de Flutter.

---

## ⚡ Inicio Rápido (5 minutos)

### Opción 1: Windows (Automático)

```batch
1. Double-click: check-setup.bat
2. Double-click: install-dependencies.bat
3. Double-click: start-server.bat
4. Abre: http://localhost:3000
```

### Opción 2: Línea de comandos

```powershell
npm install
npm start
# Abre: http://localhost:3000
```

---

## 🌐 Acceso desde Otra Computadora (Red Local)

1. En la PC principal, ejecuta: `start-server.bat`
2. El servidor mostrará:
   ```
   📍 Acceso red: http://192.168.1.100:3000
   ```
3. Desde otra PC en la misma red, abre esa URL
4. **¡Listo!** Funciona automáticamente

---

## 📋 Requisitos Previos

- **Node.js** v14+ (incluye npm) - [Descargar](https://nodejs.org/)
- **Flutter** (opcional, solo para app móvil) - [Descargar](https://flutter.dev/)
- **Git** (para clonar el repositorio) - [Descargar](https://git-scm.com/)

---

## 📦 Instalación Completa

### 1. Clonar el repositorio

```powershell
git clone https://github.com/GabrieJimenez876/GPS-Fronted.git
cd GPS-Fronted
```

### 2. Instalar dependencias Node.js

```powershell
npm install
```

### 3. (Opcional) Instalar dependencias Flutter

```powershell
flutter pub get
```

### 4. Ejecutar el servidor

```powershell
npm start
```

---

## 🎯 Scripts Disponibles

| Script | Descripción |
|--------|-------------|
| `npm start` | Inicia el servidor en puerto 3000 |
| `npm install` | Instala todas las dependencias |
| `start-server.bat` | Inicia servidor (Windows, automático) |
| `install-dependencies.bat` | Instala dependencias (Windows) |
| `check-setup.bat` | Verifica configuración (Windows) |
| `clean-reinstall.bat` | Limpia y reinstala (Windows) |
| `test-quick.bat` | Prueba rápida del setup (Windows) |

---

## 🔐 Credenciales de Prueba

```
Admin:
  Email: admin@admin.com
  Contraseña: admin123

Usuario Normal:
  Registrarse desde la interfaz web
```

---

## 🌟 Características Principales

✅ **Geolocalización en tiempo real** - Ubícate en el mapa  
✅ **Búsqueda de rutas** - Encuentra la mejor opción  
✅ **Mapa interactivo** - Basado en Leaflet y OpenStreetMap  
✅ **Sistema de autenticación** - Login y registro  
✅ **Panel de administración** - Gestiona líneas y sindicatos  
✅ **API REST** - Para integraciones externas  
✅ **Responsive Design** - Funciona en móvil, tablet y desktop  
✅ **Portátil** - Funciona desde cualquier computadora  

---

## 📁 Estructura del Proyecto

```
GPS-Fronted/
├── index.html                    ← Página web principal
├── server.js                     ← Backend Express
├── package.json                  ← Dependencias Node.js
├── pubspec.yaml                  ← Dependencias Flutter
│
├── lib/                          ← Código Flutter/Dart
│   ├── main.dart
│   ├── pages/
│   ├── services/
│   ├── models/
│   └── viewmodels/
│
├── css/                          ← Estilos
├── js/                           ← Scripts JavaScript
├── android/                      ← Configuración Android
├── ios/                          ← Configuración iOS
│
├── 🔧 Scripts de inicio (.bat)
├── 📖 Guías de instalación
└── .gitignore
```

---

## 🚀 Tecnologías Utilizadas

### Backend
- **Node.js** + **Express** - Servidor web
- **Body-parser** - Procesa formularios
- **Detección automática de IP** - Funciona en cualquier red

### Frontend Web
- **HTML5** + **CSS3** - Interfaz
- **JavaScript vanilla** - Interactividad
- **Leaflet.js** - Mapas interactivos
- **OpenStreetMap** - Datos cartográficos

### Frontend Móvil (Opcional)
- **Flutter** + **Dart** - Aplicación multiplataforma
- **flutter_map** - Mapas en Flutter
- **geolocator** - Geolocalización
- **http** - Cliente HTTP

---

## 🌐 URLs Disponibles

| Ruta | Descripción |
|------|-------------|
| `/` | Página principal con mapa |
| `/api/lineas` | API: obtener todas las líneas |
| `/ver_lineas` | Vista HTML de todas las líneas |
| `/guardar_linea` | API: guardar nueva línea (POST) |

---

## 🔧 Configuración Adicional

### Cambiar Puerto (default: 3000)

```powershell
set PORT=8080
npm start
```

### Limpiar Todo y Reinstalar

```powershell
# Windows
clean-reinstall.bat

# Mac/Linux
rm -rf node_modules package-lock.json
npm install
```

---

## 📚 Documentación Completa

- **SETUP.md** - Guía detallada de instalación
- **EJECUTAR-DESDE-CUALQUIER-PC.md** - Cómo compartir en la red
- **QUICK-REFERENCE.md** - Referencia rápida de comandos
- **CAMBIOS-REALIZADOS.md** - Detalles de las modificaciones
- **INICIO.txt** - Guía visual de bienvenida

---

## 🆘 Solución de Problemas

| Problema | Solución |
|----------|----------|
| npm no encontrado | Instala Node.js desde nodejs.org |
| Puerto 3000 en uso | `set PORT=3001 && npm start` |
| No funciona desde otra PC | Verifica firewall y usa la IP correcta |
| Dependencias outdated | Ejecuta `clean-reinstall.bat` |
| Geolocalización no funciona | Permite acceso a ubicación en navegador |

---

## 📞 Contacto y Soporte

**Email:** lapazbus@lapaz.bo  
**Teléfono:** 2652444 / +591 76522444  
**GitHub:** [GabrieJimenez876/GPS-Fronted](https://github.com/GabrieJimenez876/GPS-Fronted)

---

## 📝 Licencia

MIT - Ver `LICENSE` para más detalles

---

## ✨ Próximos Pasos

1. ✅ Clonar y ejecutar
2. ✅ Acceder a `http://localhost:3000`
3. 🔄 Probar desde otra PC en la red
4. 🔧 Personalizar datos y rutas
5. 🗄️ Conectar base de datos real
6. 🚀 Desplegar a producción

---

**¡Listo para comenzar!** 🎉

Ejecuta `start-server.bat` o `npm start` para iniciar el servidor.
