// Shared JS: loads Leaflet, initializes background map, language toggle, and helpers to interact with /api/lineas
(function(){
  // load Leaflet dynamically
  function loadLeaflet(){
    if(window.L) return Promise.resolve(window.L);
    return new Promise((resolve,reject)=>{
      var css = document.createElement('link'); css.rel='stylesheet'; css.href='https://unpkg.com/leaflet@1.9.4/dist/leaflet.css'; document.head.appendChild(css);
      var s = document.createElement('script'); s.src='https://unpkg.com/leaflet@1.9.4/dist/leaflet.js'; s.onload = ()=> resolve(window.L); s.onerror = reject; document.head.appendChild(s);
    });
  }

  // init a background map that sits behind page content
  let bgMap, bgTile;
  async function initBackgroundMap(){
    try{
      await loadLeaflet();
      const el = document.getElementById('bgMap');
      if(!el) return;
      el.style.background = '#eee';
      bgMap = L.map('bgMap', { zoomControl:false, attributionControl:false, interactive:false }).setView([-16.5, -68.15], 12);
      bgTile = L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', { maxZoom: 18 }).addTo(bgMap);
      // lock interactions
      bgMap.dragging.disable(); bgMap.touchZoom.disable(); bgMap.doubleClickZoom.disable(); bgMap.scrollWheelZoom.disable();
      window.addEventListener('resize', ()=> bgMap.invalidateSize());
    }catch(e){ console.warn('bg map init failed', e); }
  }

  // language toggler: data-i18n attributes on elements
  const i18n = {
    es: { routes:'Rutas', guide:'Guía', login:'Iniciar sesión', myloc:'Mi ubicación', mark:'Marcar destino', title:'GPS Transporte — La Paz' },
    en: { routes:'Routes', guide:'Guide', login:'Sign in', myloc:'My location', mark:'Mark destination', title:'GPS Transport — La Paz' }
  };
  let currentLang = 'es';
  function setLang(lang){ currentLang = lang; document.documentElement.lang = lang; document.querySelectorAll('[data-i18n]').forEach(el=>{ const key = el.dataset.i18n; if(i18n[lang] && i18n[lang][key]) el.textContent = i18n[lang][key]; }); }

  // shared API helpers
  const API = window.API || (window.location.origin);
  async function fetchLineas(){ try{ const res = await fetch(API + '/api/lineas'); if(!res.ok) return []; return await res.json(); }catch(e){ console.error('fetchLineas', e); return []; } }
  async function createLinea(payload){ const res = await fetch(API + '/api/lineas', { method:'POST', headers:{'Content-Type':'application/json'}, body:JSON.stringify(payload) }); return res.ok; }

  // group lineas by sindicato
  function groupBySindicato(lineas){ const map = {}; (lineas||[]).forEach(l=>{ const s = l.sindicato || 'Sin Sindicato'; if(!map[s]) map[s]=[]; map[s].push(l); }); return map; }

  // expose to window
  window.sharedUI = { initBackgroundMap, setLang, fetchLineas, createLinea, groupBySindicato };

  // auto init on DOM ready
  document.addEventListener('DOMContentLoaded', ()=>{
    initBackgroundMap().catch(()=>{});
    // wire global language button if present
    const btnLang = document.getElementById('btnLang');
    if(btnLang){ btnLang.addEventListener('click', ()=> setLang(currentLang==='es'? 'en':'es')); }
  });
})();
