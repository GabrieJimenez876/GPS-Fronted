# REFERENCIA RÁPIDA - GPS Transporte La Paz

## Comandos Principales

```bash
# Instalar dependencias
npm install

# Iniciar servidor
npm start

# Puerto predeterminado: 3000
```

## URLs de Acceso

| Acceso | URL |
|--------|-----|
| Local | http://localhost:3000 |
| Red | http://[TU_IP]:3000 |
| API Líneas | http://localhost:3000/api/lineas |
| Ver Líneas | http://localhost:3000/ver_lineas |

## Scripts Windows Disponibles

| Script | Descripción |
|--------|-------------|
| `check-setup.bat` | Verifica que todo esté instalado |
| `install-dependencies.bat` | Instala dependencias npm |
| `start-server.bat` | Inicia el servidor |
| `clean-reinstall.bat` | Limpia y reinstala todo |

## Estructura de Carpetas

```
lib/
├── main.dart           # Punto de entrada Flutter
├── theme.dart          # Temas y colores
├── constants.dart      # Constantes globales
├── models/             # Modelos de datos
├── pages/              # Páginas de la aplicación
├── services/           # Servicios de API
└── viewmodels/         # ViewModels

web/
├── index.html          # Página web principal

android/ / ios/        # Configuración móvil
```

## Puntos de Entrada

| Tecnología | Archivo | Comando |
|----------|---------|---------|
| Node.js | server.js | `npm start` |
| Web | index.html | Acceso: http://localhost:3000 |
| Flutter | lib/main.dart | `flutter run` |

## Variables de Entorno

```bash
# Puerto del servidor (default: 3000)
set PORT=3000

# Ejemplo con puerto diferente:
set PORT=8080
npm start
```

## Solución de Problemas Rápida

| Problema | Solución |
|----------|----------|
| "npm: command not found" | Instala Node.js desde nodejs.org |
| Puerto 3000 en uso | `set PORT=3001 && npm start` |
| Dependencies outdated | `npm install` |
| "Cannot GET /" | Asegúrate que server.js esté corriendo |
| Permiso geolocalización | Permite en la pregunta del navegador |

## Credenciales de Prueba (Web)

```
Admin:
Email: admin@admin.com
Password: admin123

Usuario Normal:
Registrarse desde la interfaz
```

## API Endpoints

```
GET  /               Página principal
GET  /api/lineas     Obtener todas las líneas
POST /guardar_linea  Guardar nueva línea
GET  /ver_lineas     Ver vista de líneas
```

## Características Activas

✅ Geolocalización  
✅ Búsqueda de rutas  
✅ Autenticación (web)  
✅ Panel admin  
✅ API REST  
✅ Mapa interactivo  

## Archivos Importantes

| Archivo | Propósito |
|---------|-----------|
| server.js | Servidor backend Express |
| index.html | Interface web principal |
| pubspec.yaml | Dependencias Flutter |
| package.json | Dependencias Node.js |

## Próximos Pasos

1. ✅ Servidor funcionando
2. Personalizar datos en `server.js`
3. Añadir más rutas/líneas
4. Integrar base de datos real
5. Deploy a producción

## Contacto y Soporte

**Email:** lapazbus@lapaz.bo  
**Teléfono:** 2652444 / +591 76522444  
**GitHub:** GabrieJimenez876/GPS-Fronted

---

**Última actualización:** Noviembre 2025
