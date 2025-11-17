class UIManager {
    constructor() {
        this.initializeUI();
        this.bindEvents();
    }

    initializeUI() {
        // Inicializar componentes UI
        this.initializeModals();
        this.initializeDropdowns();
        this.adjustIcons();
    }

    bindEvents() {
        // Dark mode toggle
        document.querySelector('#btnDark').addEventListener('click', () => {
            document.body.classList.toggle('dark-mode');
            // Guardar preferencia
            localStorage.setItem('darkMode', document.body.classList.contains('dark-mode'));
        });

        // Language toggle
        document.querySelector('#btnLang').addEventListener('click', () => this.toggleLanguage());

        // Guide modal
        document.querySelector('#btnGuide').addEventListener('click', () => {
            document.querySelector('#guideModal').style.display = 'flex';
        });
    }

    initializeModals() {
        // Cerrar modales con escape
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                document.querySelectorAll('.modal-backdrop').forEach(modal => {
                    modal.style.display = 'none';
                });
            }
        });

        // Cerrar modal al hacer click fuera
        document.querySelectorAll('.modal-backdrop').forEach(modal => {
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    modal.style.display = 'none';
                }
            });
        });
    }

    initializeDropdowns() {
        // Cerrar dropdowns al hacer click fuera
        document.addEventListener('click', (e) => {
            if (!e.target.closest('.menu-item')) {
                document.querySelectorAll('.dropdown').forEach(dropdown => {
                    dropdown.style.display = 'none';
                });
            }
        });
    }

    adjustIcons() {
        document.querySelectorAll('.nav-btn .fa').forEach(icon => {
            icon.style.width = '18px';
        });
    }

    toggleLanguage() {
        const currentLang = document.documentElement.lang === 'es' ? 'en' : 'es';
        document.documentElement.lang = currentLang;
        
        const translations = {
            es: {
                routes: 'Rutas',
                guide: 'Guía',
                login: 'Iniciar sesión',
                register: 'Registrarse',
                myloc: 'Mi ubicación',
                mark: 'Marcar destino',
                findRoutes: 'Rutas',
                title: 'GPS Transporte — La Paz',
                placeholder: 'Ej: Plaza Murillo'
            },
            en: {
                routes: 'Routes',
                guide: 'Guide',
                login: 'Sign in',
                register: 'Sign up',
                myloc: 'My location',
                mark: 'Mark destination',
                findRoutes: 'Routes',
                title: 'GPS Transport — La Paz',
                placeholder: 'Ex: Plaza Murillo'
            }
        };

        // Actualizar textos
        const t = translations[currentLang];
        this.updateText('#btnRoutes span', t.routes);
        this.updateText('#btnGuide span', t.guide);
        this.updateText('#btnLogin span', t.login);
        this.updateText('#btnRegister span', t.register);
        this.updateText('#btnMyLoc', `<i class="fa fa-location-crosshairs"></i> ${t.myloc}`);
        this.updateText('#btnMarkDest', `<i class="fa fa-map-pin"></i> ${t.mark}`);
        this.updateText('#btnFindRoutes', `<i class="fa fa-route"></i> ${t.findRoutes}`);
        this.updateText('#appTitle', t.title);

        // Actualizar placeholder
        document.querySelector('#dest').placeholder = t.placeholder;

        // Guardar preferencia
        localStorage.setItem('lang', currentLang);
    }

    updateText(selector, text) {
        const element = document.querySelector(selector);
        if (element) {
            element.innerHTML = text;
        }
    }

    showToast(message, type = 'info') {
        // Implementar sistema de notificaciones toast
        const toast = document.createElement('div');
        toast.className = `toast toast-${type}`;
        toast.textContent = message;
        
        document.body.appendChild(toast);
        
        setTimeout(() => {
            toast.remove();
        }, 3000);
    }

    showLoading(show = true) {
        let loader = document.querySelector('#loader');
        
        if (!loader && show) {
            loader = document.createElement('div');
            loader.id = 'loader';
            loader.className = 'loader';
            document.body.appendChild(loader);
        } else if (loader && !show) {
            loader.remove();
        }
    }
}