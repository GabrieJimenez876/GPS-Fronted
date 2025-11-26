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

// Data persistence: load from `data/lineas.json` or use defaults
const dataDir = './data';
if (!fs.existsSync(dataDir)) fs.mkdirSync(dataDir);
const dbFile = `${dataDir}/lineas.json`;

let transportLines = [];
const defaultLines = [
  {
    id: 1,
    nombre: 'Línea 1 - Villa Fátima',
    codigo: 'VF-001',
    sindicato: 'Sindicato Villa Fátima',
    paradas: ['Villa Fátima', 'Terminal', 'Plaza Eguino'],
  },
  {
    id: 2,
    nombre: 'Línea 2 - Ceja El Alto',
    codigo: 'CA-002',
    sindicato: 'Sindicato Litoral',
    paradas: ['Ceja El Alto', 'Plaza Ballivián', 'Cementerio'],
  }
];

function saveDb() {
  try {
    fs.writeFileSync(dbFile, JSON.stringify(transportLines, null, 2), 'utf8');
  } catch (err) {
    console.error('Error saving DB file:', err);
  }
}

function loadDb() {
  try {
    if (fs.existsSync(dbFile)) {
      const raw = fs.readFileSync(dbFile, 'utf8');
      transportLines = JSON.parse(raw);
    } else {
      transportLines = defaultLines;
      saveDb();
    }
  } catch (err) {
    console.error('Error loading DB file, using defaults:', err);
    transportLines = defaultLines;
    saveDb();
  }
}

loadDb();

// Rutas API
app.get('/api/lineas', (req, res) => {
  res.json(transportLines);
});

app.post('/api/lineas', (req, res) => {
  const nextId = transportLines.length ? Math.max(...transportLines.map(l => l.id || 0)) + 1 : 1;
  const newLine = {
    id: nextId,
    nombre: req.body.nombre,
    codigo: req.body.codigo,
    sindicato: req.body.sindicato,
    paradas: req.body.paradas || []
  };
  transportLines.push(newLine);
  saveDb();
  res.json({ success: true, line: newLine });
});

// Update a line
app.put('/api/lineas/:id', (req, res) => {
  const id = parseInt(req.params.id, 10);
  const idx = transportLines.findIndex(l => l.id === id);
  if (idx === -1) return res.status(404).json({ success: false, message: 'Not found' });
  const updated = { ...transportLines[idx], ...req.body, id };
  transportLines[idx] = updated;
  saveDb();
  res.json({ success: true, line: updated });
});

// Delete a line
app.delete('/api/lineas/:id', (req, res) => {
  const id = parseInt(req.params.id, 10);
  const prev = transportLines.length;
  transportLines = transportLines.filter(l => l.id !== id);
  if (transportLines.length === prev) return res.status(404).json({ success: false, message: 'Not found' });
  saveDb();
  res.json({ success: true });
});

// Iniciar servidor
app.listen(PORT, HOST, () => {
  console.log(`\n🚀 Servidor corriendo\n`);
  console.log(`📍 Local: http://localhost:${PORT}`);
  console.log(`📍 Red:   http://${localIP}:${PORT}\n`);
});
