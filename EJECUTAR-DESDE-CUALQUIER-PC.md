# Ejecutar desde Cualquier Computadora

## Requisitos

✅ Node.js instalado (cualquier versión reciente)  
✅ El proyecto GPS-Fronted descargado  

## Pasos Rápidos (5 minutos)

### 1️⃣ Abre la carpeta del proyecto

```bash
cd C:\ruta\a\GPS-Fronted
```

### 2️⃣ Instala dependencias (primera vez solamente)

```bash
npm install
```

**O en Windows, double-click:** `install-dependencies.bat`

### 3️⃣ Inicia el servidor

```bash
npm start
```

**O en Windows, double-click:** `start-server.bat`

Verás algo como:
```
🚀 Servidor Express corriendo

📍 Acceso local: http://localhost:3000
📍 Acceso red: http://192.168.1.100:3000

✅ El servidor está disponible desde cualquier computadora en la red
```

### 4️⃣ Accede desde tu navegador

**Desde la misma PC:**
```
http://localhost:3000
```

**Desde otra PC en la red:**
```
http://192.168.1.100:3000
```
(cambia `192.168.1.100` por tu IP)

---

## Encontrar Tu Dirección IP

### En Windows

**Opción 1 - PowerShell:**
```powershell
ipconfig
```
Busca la línea "IPv4 Address" (normalmente algo como `192.168.x.x`)

**Opción 2 - CMD:**
```cmd
ipconfig
```

### En Mac

```bash
ifconfig | grep inet
```

### En Linux

```bash
hostname -I
```

---

## Compartir Acceso en la Red

**Problema:** La otra PC no puede acceder  
**Solución:** Usa la IP que aparece al inicio del servidor

Ejemplo: Si tu servidor muestra:
```
📍 Acceso red: http://192.168.1.50:3000
```

En otra PC (en la misma red WiFi/Red), abre:
```
http://192.168.1.50:3000
```

---

## Puertos Alternativos

Si el puerto 3000 está ocupado:

```bash
set PORT=3001
npm start
```

Luego accede a: `http://localhost:3001`

---

## Uso desde Internet (No en red local)

Para acceso desde **fuera de tu red**, necesitas:

### Opción 1: ngrok (Fácil)

```bash
# Instala ngrok: https://ngrok.com

# En otra terminal, ejecuta:
ngrok http 3000

# Te dará una URL como:
# https://abc123.ngrok.io
```

### Opción 2: Port Forwarding (Avanzado)

1. Accede a tu router (normalmente `192.168.1.1`)
2. Configura Port Forwarding: puerto 3000 → tu IP interna
3. Accede desde: `http://[TU_IP_PUBLICA]:3000`

---

## Detener el Servidor

```bash
Presiona: Ctrl + C
```

---

## Verificar que todo funcione

```bash
# En PowerShell o CMD
node --version
npm --version
npm start
```

Si ves "Servidor corriendo en http://localhost:3000" → ✅ Funciona

---

## Archivos de Script

| Script | Tarea |
|--------|-------|
| `check-setup.bat` | Verifica Node.js y npm |
| `install-dependencies.bat` | Instala paquetes |
| `start-server.bat` | Inicia servidor |
| `clean-reinstall.bat` | Limpia todo y reinstala |

---

## Flujo de Inicio Recomendado

```
1. check-setup.bat     (verifica)
   ↓
2. install-dependencies.bat  (instala una sola vez)
   ↓
3. start-server.bat    (inicia cada vez)
   ↓
4. Abre: http://localhost:3000
   ✅ ¡Listo!
```

---

## Preguntas Comunes

**P: ¿Funciona en todos los sistemas operativos?**  
R: Sí. Node.js funciona en Windows, Mac y Linux. Los scripts .bat son solo para Windows; en Mac/Linux usa `npm start` directamente.

**P: ¿Necesito instalar algo más?**  
R: Solo Node.js. Incluye npm (el gestor de paquetes).

**P: ¿Puedo usar esto en producción?**  
R: Este es un servidor de desarrollo. Para producción, usa herramientas como PM2 o despliega a Heroku/AWS.

**P: ¿Cuánto ancho de banda necesito?**  
R: Muy poco. El servidor es ligero (~5MB instalado). La app web es ~2MB iniciales.

**P: ¿Qué pasa si cierro la terminal?**  
R: El servidor se detiene. Vuelve a abrir `start-server.bat` para reiniciar.

---

## Próximos Pasos

1. ✅ Servidor corriendo
2. 📍 Explorar `http://localhost:3000`
3. 🔐 Prueba login: admin@admin.com / admin123
4. 📚 Lee `SETUP.md` para más opciones

---

**¿Necesitas ayuda?**

```
Email: lapazbus@lapaz.bo
Tel: 2652444 / +591 76522444
GitHub: GabrieJimenez876/GPS-Fronted
```

🎉 ¡Ya está todo listo para funcionar desde cualquier computadora!
