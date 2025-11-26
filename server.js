const express = require('express');
const bodyParser = require('body-parser');
const os = require('os');
const fs = require('fs');

// Cargar configuración
const config = JSON.parse(fs.readFileSync('config.json', 'utf8'));
const PORT = process.env.PORT || config.server.port;
const HOST = config.server.host;

// Detectar IP local
let localIP = 'localhost';
if (config.server.autoDetectIP) {
  const interfaces = os.networkInterfaces();
  for (const name of Object.keys(interfaces)) {
    for (const iface of interfaces[name]) {
      if (iface.family === 'IPv4' && !iface.internal) {
        localIP = iface.address;
        break;
      }
    }
  }
}

const app = express();

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static(__dirname));

// Base de datos simulada
const transportLines = [
  {
    nombre: "Línea 1 - Villa Fátima",
    codigo: "VF-001",
    sindicato: "Sindicato Villa Fátima",
    paradas: ["Villa Fátima", "Terminal", "Plaza Eguino"],
  },
  {
    nombre: "Línea 2 - Ceja El Alto",
    codigo: "CA-002",
    sindicato: "Sindicato Litoral",
    paradas: ["Ceja El Alto", "Plaza Ballivián", "Cementerio"],
  }
];

// Rutas API
app.get('/api/lineas', (req, res) => {
  res.json(transportLines);
});

app.post('/api/lineas', (req, res) => {
  const newLine = {
    nombre: req.body.nombre,
    codigo: req.body.codigo,
    sindicato: req.body.sindicato,
    paradas: req.body.paradas || []
  };
  transportLines.push(newLine);
  res.json({ success: true, line: newLine });
});

// Iniciar servidor
app.listen(PORT, HOST, () => {
  console.log(`\n🚀 Servidor corriendo\n`);
  console.log(`📍 Local: http://localhost:${PORT}`);
  console.log(`📍 Red:   http://${localIP}:${PORT}\n`);
});
