class AdminManager {
    constructor() {
        this.currentView = null;
        this.isVisible = false;
        this.initializeAdminPanel();
        this.bindEvents();
    }

    initializeAdminPanel() {
        // Crear el contenedor de administración
        const adminContainer = document.createElement('div');
        adminContainer.className = 'admin-container hidden';
        adminContainer.innerHTML = `
            <button class="admin-toggle">
                <i class="fa fa-cog"></i>
            </button>
            <div class="admin-header">
                <h3>Panel de Administración</h3>
                <button class="nav-btn" id="closeAdminPanel">
                    <i class="fa fa-times"></i>
                </button>
            </div>
            <div class="admin-body">
                <div class="admin-menu">
                    <button class="admin-btn" data-view="agregarLinea">
                        <i class="fa fa-plus"></i> Agregar Línea
                    </button>
                    <button class="admin-btn" data-view="baseDatos">
                        <i class="fa fa-database"></i> Base de Datos
                    </button>
                    <button class="admin-btn" data-view="sindicatos">
                        <i class="fa fa-users"></i> Sindicatos
                    </button>
                </div>
                <div id="adminContent"></div>
            </div>
        `;
        document.body.appendChild(adminContainer);
        this.container = adminContainer;
    }

    bindEvents() {
        // Toggle del panel
        this.container.querySelector('.admin-toggle').addEventListener('click', () => {
            this.togglePanel();
        });

        // Cerrar panel
        this.container.querySelector('#closeAdminPanel').addEventListener('click', () => {
            this.hidePanel();
        });

        // Botones de vista
        this.container.querySelectorAll('.admin-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const view = e.currentTarget.dataset.view;
                this.showView(view);
            });
        });

        // Mantener el estado al navegar
        window.addEventListener('popstate', () => {
            const view = this.getViewFromURL();
            if (view) {
                this.showView(view, false);
            }
        });
    }

    togglePanel() {
        this.container.classList.toggle('hidden');
        this.isVisible = !this.container.classList.contains('hidden');
    }

    hidePanel() {
        this.container.classList.add('hidden');
        this.isVisible = false;
    }

    showPanel() {
        this.container.classList.remove('hidden');
        this.isVisible = true;
    }

    showView(view, updateURL = true) {
        // Actualizar botones
        this.container.querySelectorAll('.admin-btn').forEach(btn => {
            btn.classList.toggle('active', btn.dataset.view === view);
        });

        // Actualizar contenido
        const content = document.getElementById('adminContent');
        
        switch(view) {
            case 'agregarLinea':
                content.innerHTML = this.getAgregarLineaHTML();
                this.initAgregarLineaForm();
                break;
            case 'baseDatos':
                this.loadBaseDatos();
                break;
            case 'sindicatos':
                this.loadSindicatos();
                break;
        }

        this.currentView = view;
        this.showPanel();

        // Actualizar URL si es necesario
        if (updateURL) {
            const url = new URL(window.location);
            url.searchParams.set('admin', view);
            window.history.pushState({}, '', url);
        }
    }

    getViewFromURL() {
        const params = new URLSearchParams(window.location.search);
        return params.get('admin');
    }

    getAgregarLineaHTML() {
        return `
            <form class="admin-form" id="lineaForm">
                <div class="form-group">
                    <label>Nombre de la Línea:</label>
                    <input type="text" name="nombre" required placeholder="Ej: Línea 1 - Villa Fátima">
                </div>
                <div class="form-group">
                    <label>Código:</label>
                    <input type="text" name="codigo" required placeholder="Ej: VF-001">
                </div>
                <div class="form-group">
                    <label>Sindicato:</label>
                    <input type="text" name="sindicato" required placeholder="Ej: Sindicato Villa Fátima">
                </div>
                <div class="form-group">
                    <label>Paradas:</label>
                    <textarea name="paradas" required placeholder="Una parada por línea"></textarea>
                </div>
                <div class="form-group">
                    <label>Recorrido:</label>
                    <textarea name="recorrido" required placeholder="Describe el recorrido completo"></textarea>
                </div>
                <div class="form-actions">
                    <button type="submit" class="admin-btn">
                        <i class="fa fa-save"></i> Guardar
                    </button>
                </div>
            </form>
        `;
    }

    initAgregarLineaForm() {
        const form = document.getElementById('lineaForm');
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(form);
            const data = {
                nombre: formData.get('nombre'),
                codigo: formData.get('codigo'),
                sindicato: formData.get('sindicato'),
                paradas: formData.get('paradas').split('\n').map(p => p.trim()).filter(p => p),
                recorrido: formData.get('recorrido')
            };

            try {
                const response = await fetch('/guardar_linea', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                });

                if (response.ok) {
                    alert('Línea guardada correctamente');
                    form.reset();
                } else {
                    throw new Error('Error al guardar la línea');
                }
            } catch (error) {
                alert('Error: ' + error.message);
            }
        });
    }

    async loadBaseDatos() {
        const content = document.getElementById('adminContent');
        content.innerHTML = '<div class="loading">Cargando...</div>';

        try {
            const response = await fetch('/api/lineas');
            const lineas = await response.json();

            content.innerHTML = `
                <div class="admin-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Nombre</th>
                                <th>Sindicato</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${lineas.map(linea => `
                                <tr>
                                    <td>${linea.codigo}</td>
                                    <td>${linea.nombre}</td>
                                    <td>${linea.sindicato}</td>
                                    <td>
                                        <button class="nav-btn" onclick="adminManager.editarLinea('${linea.codigo}')">
                                            <i class="fa fa-edit"></i>
                                        </button>
                                        <button class="nav-btn" onclick="adminManager.eliminarLinea('${linea.codigo}')">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            `).join('')}
                        </tbody>
                    </table>
                </div>
            `;
        } catch (error) {
            content.innerHTML = '<div class="error">Error al cargar los datos</div>';
        }
    }

    async loadSindicatos() {
        const content = document.getElementById('adminContent');
        content.innerHTML = `
            <div class="admin-form">
                <h4>Gestión de Sindicatos</h4>
                <p>Próximamente: Gestión de sindicatos y cooperativas de transporte.</p>
            </div>
        `;
    }

    editarLinea(codigo) {
        alert('Función de edición en desarrollo: ' + codigo);
    }

    eliminarLinea(codigo) {
        if (confirm('¿Estás seguro de eliminar esta línea?')) {
            alert('Función de eliminación en desarrollo: ' + codigo);
        }
    }
}