
# 🚍 Proyecto GPS de Rutas de Transporte en La Paz, Bolivia

Este proyecto tiene como objetivo desarrollar una aplicación móvil y web para visualizar rutas de minibuses en La Paz, Bolivia, utilizando tecnologías modernas y SQLite como base de datos ligera y portable.

---

## 🔐 Configuración del Repositorio

### Configurar SSH en VS Code

1. Abrir terminal en VS Code (Ctrl + Ñ) y ejecutar:
```powershell
# Reiniciar SSH Agent
Stop-Service ssh-agent
Start-Service ssh-agent

# Eliminar claves antiguas
cd ~/.ssh
Remove-Item id_* -Force

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
- **Base de datos:** SQLite (ligera y portable)
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

