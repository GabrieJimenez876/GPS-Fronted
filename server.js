const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
const PORT = 3000;


// Servir archivos estáticos desde el directorio raíz
app.use(express.static(__dirname));

// --- Base de datos simulada (en una app real sería MongoDB o PostgreSQL) ---
const transportLines = [
    {
        nombre: "Línea 1 - Villa Fátima",
        codigo: "VF-001",
        sindicato: "Sindicato Villa Fátima",
        paradas: ["Villa Fátima", "Terminal", "Plaza Eguino", "San Pedro", "Miraflores"],
        recorrido: "Villa Fátima → Terminal → Plaza Eguino → San Pedro → Miraflores",
        timestamp: new Date().toISOString()
    },
    {
        nombre: "Línea 2 - Ceja El Alto",
        codigo: "CA-002",
        sindicato: "Sindicato Litoral",
        paradas: ["Ceja El Alto", "16 de Julio", "Plaza Ballivián", "Cementerio", "Garita"],
        recorrido: "Ceja El Alto → 16 de Julio → Plaza Ballivián → Cementerio → Garita",
        timestamp: new Date().toISOString()
    },
    {
        nombre: "Línea 3 - PUC",
        codigo: "PUC-003",
        sindicato: "Sindicato PUC",
        paradas: ["Plaza Humboldt", "UMSA", "Plaza del Estudiante", "San Jorge", "Obrajes"],
        recorrido: "Plaza Humboldt → UMSA → Plaza del Estudiante → San Jorge → Obrajes",
        timestamp: new Date().toISOString()
    }
];

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

// --- Ruta 3: API para obtener todas las líneas ---
app.get('/api/lineas', (req, res) => {
  res.json(transportLines);
});

// --- Ruta 4: Vista de todas las líneas ---
app.get('/ver_lineas', (req, res) => {
  const linesHtml = `
    <!DOCTYPE html>
    <html lang="es">
    <head>
      <meta charset="UTF-8">
      <title>Líneas de Transporte</title>
      <style>
        body { font-family: Arial; padding: 20px; background-color: #f4f4f4; }
        h2 { color: #004d40; }
        .line-card { 
          background: #fff; 
          padding: 15px; 
          margin: 10px 0; 
          border-radius: 5px; 
          box-shadow: 0 2px 4px rgba(0,0,0,0.1); 
        }
        .line-header { 
          display: flex; 
          justify-content: space-between; 
          align-items: center; 
          margin-bottom: 10px;
        }
        .code { 
          background: #004d40; 
          color: white; 
          padding: 4px 8px; 
          border-radius: 4px; 
          font-size: 0.9em;
        }
        .stops { 
          display: flex; 
          gap: 10px; 
          flex-wrap: wrap; 
          margin: 10px 0;
        }
        .stop { 
          background: #e0f2f1; 
          padding: 4px 8px; 
          border-radius: 12px; 
          font-size: 0.9em;
        }
        .route { 
          color: #666; 
          margin-top: 10px;
        }
        nav {
          margin-bottom: 20px;
        }
        nav a {
          background: #004d40;
          color: white;
          padding: 8px 16px;
          text-decoration: none;
          border-radius: 4px;
          margin-right: 10px;
        }
        nav a:hover {
          background: #00695c;
        }
      </style>
    </head>
    <body>
      <nav>
        <a href="/">🏠 Inicio</a>
        <a href="/agregar_linea.html">➕ Agregar Línea</a>
      </nav>
      
      <h2>Líneas de Transporte</h2>
      ${transportLines.map(line => `
        <div class="line-card">
          <div class="line-header">
            <h3>${line.nombre}</h3>
            <span class="code">${line.codigo}</span>
          </div>
          <div>Sindicato: ${line.sindicato}</div>
          <div class="stops">
            ${line.paradas.map(stop => `
              <span class="stop">${stop}</span>
            `).join('')}
          </div>
          <div class="route">📍 ${line.recorrido}</div>
        </div>
      `).join('')}
    </body>
    </html>
  `;
  res.send(linesHtml);
});

// --- Iniciar el servidor ---
app.listen(PORT, () => {
  console.log(`🚀 Servidor Express corriendo en http://localhost:${PORT}`);
  console.log('Presiona Ctrl+C para detenerlo.');
});
