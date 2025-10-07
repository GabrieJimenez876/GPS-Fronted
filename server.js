const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
const PORT = 3000;

// --- Mock Database (In a real app, this would be MongoDB or PostgreSQL) ---
const transportLines = [];

// --- Middleware Setup ---
// Use body-parser to process form data (URL-encoded)
app.use(bodyParser.urlencoded({ extended: true }));

// Serve static files (like the HTML, if you moved it)
// For simplicity, we'll serve the HTML directly below.
// app.use(express.static(path.join(__dirname, 'public')));


// --- Route 1: Serve the Form (GET /) ---
app.get('/', (req, res) => {
    // We send the modified HTML directly so it works right away.
    // The key change is adding method="POST" and action="/guardar_linea" to the form.
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


// --- Route 2: Process Form Submission (POST /guardar_linea) ---
app.post('/guardar_linea', (req, res) => {
    // 1. Get data from the request body (thanks to body-parser)
    const { nombre, codigo, sindicato, paradas, recorrido } = req.body;

    // 2. Process/Clean Data (e.g., convert the string of stops into an array)
    const paradasArray = paradas ? paradas.split(',').map(p => p.trim()).filter(p => p.length > 0) : [];

    // 3. Create the new line object
    const newLine = {
        nombre,
        codigo,
        sindicato,
        paradas: paradasArray,
        recorrido,
        timestamp: new Date().toISOString()
    };
    
    // 4. Store the data (in our mock database)
    transportLines.push(newLine);

    // 5. Log the new entry in the console (for debugging)
    console.log(`✅ Nueva Línea Guardada: ${newLine.nombre} (${newLine.codigo})`);
    console.log('Datos:', newLine);
    console.log('------------------------------');

    // 6. Send a response to the user (Redirect back to the form or a success page)
    res.redirect('/');
});


// --- Start the Server ---
app.listen(PORT, () => {
    console.log(`🚀 Servidor Express corriendo en http://localhost:${PORT}`);
    console.log('Presiona Ctrl+C para detenerlo.');
});
