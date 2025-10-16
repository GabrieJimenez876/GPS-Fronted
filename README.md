# GPS-Fronted

Proyecto frontend para visualización de rutas y mapas (HTML + JS + Flutter).

## Contenido
- Páginas estáticas: `index.html`, `ver_rutas.html`, `sindicatos.html`, etc.
- Backend de ejemplo: `server.js` (Node/Express) y `app.py` (Flask) — demos básicas.
- Aplicación móvil/web: archivos Dart (`mapa_page.dart`, `agregar_linea_page.dart`).

## Requisitos
- Node.js (para `server.js`) opcional
- Python (para `app.py`) opcional
- Flutter SDK (para la parte Dart/Flutter)

## Cómo ejecutar (rápido)
- Abrir las páginas estáticas con el navegador (doble clic) o servir con un servidor estático.

### Node (server.js)
```powershell
node server.js
# luego abrir http://localhost:3000
```

### Flask (app.py)
```powershell
python app.py
# luego abrir http://127.0.0.1:5000/
```

### Flutter (si trabajas la app Dart)
```powershell
flutter pub get
flutter analyze
flutter run
```

## Git / subir cambios
Si tienes problemas para hacer `git push` por SSH (error de deploy key), revisa las opciones:
- Añadir una clave SSH personal a tu cuenta GitHub (recomendado).
- O usar HTTPS y un Personal Access Token (PAT).

## Notas
- No editar manualmente archivos en `.dart_tool` ni `pubspec.lock` salvo que sepas lo que haces.
- Este README es mínimo; puedes ampliarlo con instrucciones específicas del flujo de trabajo.
