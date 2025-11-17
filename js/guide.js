class GuideManager {
    constructor() {
        this.modal = document.getElementById('guideModal');
        this.initializeTabs();
        this.bindEvents();
    }

    initializeTabs() {
        const tabsContainer = document.createElement('div');
        tabsContainer.className = 'guide-tabs';
        
        const tabs = [
            { id: 'uso', text: 'Uso General', icon: 'map' },
            { id: 'admin', text: 'Administración', icon: 'wrench' },
            { id: 'rutas', text: 'Rutas', icon: 'route' }
        ];

        tabsContainer.innerHTML = tabs.map(tab => `
            <button class="tab-btn ${tab.id === 'uso' ? 'active' : ''}" data-tab="${tab.id}">
                <i class="fa fa-${tab.icon}"></i> ${tab.text}
            </button>
        `).join('');

        const modalBody = this.modal.querySelector('.modal-body');
        modalBody.insertBefore(tabsContainer, modalBody.firstChild);

        // Crear contenedores de contenido
        const contents = {
            uso: `
                <h4>Cómo usar el mapa:</h4>
                <ol>
                    <li>Usa el campo <em>Destino</em> para escribir o elegir un lugar rápido.</li>
                    <li>Presiona <em>Mi ubicación</em> para ubicarte en el mapa.</li>
                    <li>Marca el destino con <em>Marcar destino</em> y luego <em>Rutas</em> para consultar opciones.</li>
                </ol>
                <p><strong>Tips:</strong></p>
                <ul>
                    <li>Puedes hacer clic directamente en el mapa para marcar un destino</li>
                    <li>Usa la lista de lugares rápidos para ubicaciones comunes</li>
                    <li>El botón de modo oscuro cambia el tema de la aplicación</li>
                </ul>
            `,
            admin: `
                <h4>Panel de Administración:</h4>
                <ul>
                    <li><strong>Agregar línea:</strong> Crear nuevas rutas de transporte</li>
                    <li><strong>Ver base de datos:</strong> Consultar y editar todas las rutas</li>
                    <li><strong>Sindicatos:</strong> Gestionar información de sindicatos</li>
                </ul>
                <p><strong>Acceso Admin:</strong></p>
                <ul>
                    <li>Email: admin@admin.com</li>
                    <li>Contraseña: admin123</li>
                </ul>
            `,
            rutas: `
                <h4>Gestión de Rutas:</h4>
                <ul>
                    <li><strong>Ver todas las rutas:</strong> Listado completo de líneas</li>
                    <li><strong>Buscar ruta:</strong> Filtrar por origen/destino</li>
                    <li><strong>Información de ruta:</strong> Ver detalles, paradas y horarios</li>
                </ul>
                <p><strong>Funciones especiales:</strong></p>
                <ul>
                    <li>Vista de mapa en tiempo real</li>
                    <li>Estimación de tiempos de llegada</li>
                    <li>Reportar problemas en la ruta</li>
                </ul>
            `
        };

        Object.entries(contents).forEach(([id, content]) => {
            const div = document.createElement('div');
            div.className = `tab-content ${id === 'uso' ? 'active' : ''}`;
            div.id = `${id}-content`;
            div.innerHTML = content;
            modalBody.appendChild(div);
        });
    }

    bindEvents() {
        // Mostrar/ocultar modal
        document.getElementById('btnGuide').addEventListener('click', () => {
            this.showModal();
        });

        // Cerrar modal
        this.modal.querySelector('.modal-footer button').addEventListener('click', () => {
            this.hideModal();
        });

        // Cambiar tabs
        this.modal.querySelectorAll('.tab-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const tabId = e.currentTarget.dataset.tab;
                this.switchTab(tabId);
            });
        });

        // Cerrar al hacer clic fuera
        this.modal.addEventListener('click', (e) => {
            if (e.target === this.modal) {
                this.hideModal();
            }
        });

        // Cerrar con Escape
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && this.modal.style.display === 'flex') {
                this.hideModal();
            }
        });
    }

    showModal() {
        this.modal.style.display = 'flex';
        // Guardar estado
        localStorage.setItem('lastGuideTab', this.getCurrentTab());
    }

    hideModal() {
        this.modal.style.display = 'none';
    }

    switchTab(tabId) {
        // Actualizar botones
        this.modal.querySelectorAll('.tab-btn').forEach(btn => {
            btn.classList.toggle('active', btn.dataset.tab === tabId);
        });

        // Actualizar contenido
        this.modal.querySelectorAll('.tab-content').forEach(content => {
            content.classList.toggle('active', content.id === `${tabId}-content`);
        });

        // Guardar estado
        localStorage.setItem('lastGuideTab', tabId);
    }

    getCurrentTab() {
        const activeTab = this.modal.querySelector('.tab-btn.active');
        return activeTab ? activeTab.dataset.tab : 'uso';
    }

    // Restaurar último tab visitado
    restoreLastTab() {
        const lastTab = localStorage.getItem('lastGuideTab');
        if (lastTab) {
            this.switchTab(lastTab);
        }
    }
}