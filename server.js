const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
const PORT = 3000;

// --- Base de datos simulada (en una app real sería MongoDB o PostgreSQL) ---
const transportLines = [];

// --- Configuración de middleware ---
// Usamos body-parser para procesar datos de formularios (URL-encoded)
app.use(bodyParser.urlencoded({ extended: true }));

// Servir archivos estáticos (por ejemplo si mueves el HTML a /public)
// Por simplicidad, se inserta el HTML directamente en la ruta abajo.
// app.use(express.static(path.join(__dirname, 'public')));


// --- Ruta 1: Servir el formulario (GET /) ---
app.get('/', (req, res) => {
  // Enviamos el HTML directamente para que funcione de inmediato.
  // El formulario tiene method="POST" y action="/guardar_linea" para enviar datos al servidor.
    const formHtml = `
    <!DOCTYPE html>
    <html lang="es">
    <head>
      <meta charset="UTF-8">
      <title>Agregar Línea de Transporte</title>
      <style>
        body { font-family: Arial; padding: 20px; background-color: #f4f4f4; }
        h2 { color: #004d40; }
        form { background: #fff; padding: 20px; border-radius: 5px; }
        label { display: block; margin-top: 10px; }
        input, textarea { width: 100%; padding: 8px; margin-top: 5px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;}
        button { margin-top: 15px; padding: 10px 20px; background-color: #004d40; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #00332a; }
        .data-list { margin-top: 20px; padding: 10px; border-top: 1px solid #ccc; }
      </style>
    </head>
    <body>
      <h2>Agregar Nueva Línea</h2>
      <form method="POST" action="/guardar_linea">
        <label>Nombre de la Línea:</label>
        <input type="text" name="nombre" placeholder="Ej: Línea Amarilla" required>

        <label>Código:</label>
        <input type="text" name="codigo" placeholder="Ej: AMR-10" required>

        <label>Sindicato:</label>
        <input type="text" name="sindicato" placeholder="Ej: Sindicato Cementerio" required>

        <label>Paradas (separadas por coma):</label>
        <textarea name="paradas" placeholder="Ej: Cementerio, Hospital Juan XXIII" required></textarea>

        <label>Recorrido (calles o coordenadas):</label>
        <textarea name="recorrido" placeholder="Ej: Av. Busch → Calle 21 → Plaza Murillo" required></textarea>

        <button type="submit">Guardar Línea</button>
      </form>
      
      <div class="data-list">
        <h3>Líneas Registradas (${transportLines.length})</h3>
        <ul>
        ${transportLines.map(line => `
            <li><strong>${line.nombre}</strong> (${line.codigo}) - Sindicato: ${line.sindicato}</li>
        `).join('')}
        </ul>
      </div>
      
    </body>
    </html>
    `;
    res.send(formHtml);
});


// --- Ruta 2: Procesar envío del formulario (POST /guardar_linea) ---
app.post('/guardar_linea', (req, res) => {
  // 1. Obtener datos del cuerpo de la petición (gracias a body-parser)
  const { nombre, codigo, sindicato, paradas, recorrido } = req.body;

  // 2. Procesar/limpiar datos (por ejemplo convertir la cadena de paradas en un array)
  const paradasArray = paradas ? paradas.split(',').map(p => p.trim()).filter(p => p.length > 0) : [];

  // 3. Construir el objeto de la nueva línea
  const newLine = {
    nombre,
    codigo,
    sindicato,
    paradas: paradasArray,
    recorrido,
    timestamp: new Date().toISOString()
  };
    
  // 4. Almacenar los datos (en nuestra base simulada)
  transportLines.push(newLine);

  // 5. Registrar la nueva entrada en la consola (para depuración)
  console.log(`✅ Nueva Línea Guardada: ${newLine.nombre} (${newLine.codigo})`);
  console.log('Datos:', newLine);
  console.log('------------------------------');

  // 6. Responder al cliente (redirigir al formulario o a una página de éxito)
  res.redirect('/');
});


// --- Iniciar el servidor ---
app.listen(PORT, () => {
  console.log(`🚀 Servidor Express corriendo en http://localhost:${PORT}`);
  console.log('Presiona Ctrl+C para detenerlo.');
});
