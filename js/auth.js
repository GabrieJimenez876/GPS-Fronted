class AuthManager {
    constructor() {
        this.USERS_KEY = 'gps_users';
        this.CURRENT_USER_KEY = 'gps_current_user';
        this.MIN_PASSWORD_LENGTH = 6;
        
        // Event bindings
        this.bindEvents();
        this.checkSession();
    }

    bindEvents() {
        // DOM Elements
        const $ = selector => document.querySelector(selector);
        
        // Auth buttons
        $('#btnLogin').addEventListener('click', () => this.showLoginModal());
        $('#btnRegister').addEventListener('click', () => this.showRegisterModal());
        $('#btnLogout').addEventListener('click', e => {
            e.preventDefault();
            this.logout();
        });
        $('#btnSwitchUser').addEventListener('click', e => {
            e.preventDefault();
            this.switchUser();
        });
        
        // Modal form submissions
        $('#loginForm').addEventListener('submit', e => {
            e.preventDefault();
            this.handleLogin();
        });
        
        $('#registerForm').addEventListener('submit', e => {
            e.preventDefault();
            this.handleRegister();
        });
    }

    validatePassword(password) {
        if (password.length < this.MIN_PASSWORD_LENGTH) {
            throw new Error(`La contraseña debe tener al menos ${this.MIN_PASSWORD_LENGTH} caracteres`);
        }
        
        if (!/[A-Z]/.test(password)) {
            throw new Error('La contraseña debe contener al menos una mayúscula');
        }
        
        if (!/[0-9]/.test(password)) {
            throw new Error('La contraseña debe contener al menos un número');
        }
    }

    validateEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            throw new Error('El correo electrónico no es válido');
        }
    }

    async handleRegister() {
        const $ = selector => document.querySelector(selector);
        
        try {
            const name = $('#regName').value.trim();
            const email = $('#regEmail').value.trim();
            const password = $('#regPassword').value;
            const confirmPassword = $('#regConfirmPassword').value;

            // Validaciones
            if (!name) throw new Error('El nombre es requerido');
            this.validateEmail(email);
            this.validatePassword(password);
            
            if (password !== confirmPassword) {
                throw new Error('Las contraseñas no coinciden');
            }

            const users = this.getUsers();
            if (users.some(u => u.email === email)) {
                throw new Error('Este correo ya está registrado');
            }

            // Hash password before storing (en producción usar bcrypt)
            const hashedPassword = await this.hashPassword(password);
            
            const newUser = { 
                name, 
                email, 
                password: hashedPassword,
                createdAt: new Date().toISOString()
            };

            this.saveUser(newUser);
            
            // Auto-login
            const session = { 
                isAdmin: false, 
                name: name, 
                email: email 
            };
            
            this.setSession(session);
            this.updateUIForSession(session);
            
            this.closeRegisterModal();
            this.showToast('¡Registro exitoso!');
            
        } catch (error) {
            this.showError(error.message);
        }
    }

    async handleLogin() {
        const $ = selector => document.querySelector(selector);
        
        try {
            const email = $('#loginEmail').value.trim();
            const password = $('#loginPassword').value;

            this.validateEmail(email);

            const users = this.getUsers();
            const user = users.find(u => u.email === email);

            if (!user) {
                throw new Error('Credenciales incorrectas');
            }

            // Verify password (en producción usar bcrypt)
            const passwordMatch = await this.verifyPassword(password, user.password);
            
            if (!passwordMatch) {
                throw new Error('Credenciales incorrectas');
            }

            const session = {
                isAdmin: email === 'admin@admin.com',
                name: user.name,
                email: user.email
            };

            this.setSession(session);
            this.updateUIForSession(session);
            
            this.closeLoginModal();
            this.showToast('¡Bienvenido!');
            
        } catch (error) {
            this.showError(error.message);
        }
    }

    // Utility methods
    async hashPassword(password) {
        // En producción usar bcrypt
        return btoa(password);
    }

    async verifyPassword(password, hashedPassword) {
        // En producción usar bcrypt
        return btoa(password) === hashedPassword;
    }

    getUsers() {
        const users = localStorage.getItem(this.USERS_KEY);
        return users ? JSON.parse(users) : [];
    }

    saveUser(user) {
        const users = this.getUsers();
        users.push(user);
        localStorage.setItem(this.USERS_KEY, JSON.stringify(users));
    }

    setSession(session) {
        localStorage.setItem(this.CURRENT_USER_KEY, JSON.stringify(session));
    }

    getSession() {
        const session = localStorage.getItem(this.CURRENT_USER_KEY);
        return session ? JSON.parse(session) : null;
    }

    clearSession() {
        localStorage.removeItem(this.CURRENT_USER_KEY);
    }

    checkSession() {
        const session = this.getSession();
        if (session) {
            this.updateUIForSession(session);
        }
    }

    updateUIForSession(session) {
        const $ = selector => document.querySelector(selector);
        
        // Update UI elements
        $('#btnLogin').style.display = 'none';
        $('#btnRegister').style.display = 'none';
        
        if (session && session.email) {
            $('#profileName').textContent = session.name || session.email.split('@')[0];
            $('#profileEmail').textContent = session.email;
            $('#profileAvatar').textContent = (session.name || session.email).charAt(0).toUpperCase();
            $('#profileWrap').style.display = 'block';
            
            // Admin section visibility
            $('#adminSection').style.display = session.isAdmin ? 'block' : 'none';
        }
    }

    logout() {
        this.clearSession();
        location.reload();
    }

    switchUser() {
        this.logout();
        this.showLoginModal();
    }

    // Modal controls
    showLoginModal() {
        document.querySelector('#loginModal').style.display = 'flex';
    }

    closeLoginModal() {
        const $ = selector => document.querySelector(selector);
        $('#loginModal').style.display = 'none';
        $('#loginEmail').value = '';
        $('#loginPassword').value = '';
    }

    showRegisterModal() {
        document.querySelector('#registerModal').style.display = 'flex';
    }

    closeRegisterModal() {
        const $ = selector => document.querySelector(selector);
        $('#registerModal').style.display = 'none';
        $('#regName').value = '';
        $('#regEmail').value = '';
        $('#regPassword').value = '';
        $('#regConfirmPassword').value = '';
    }

    // UI feedback
    showError(message) {
        // Implementar toast o alert personalizado
        alert(message);
    }

    showToast(message) {
        // Implementar sistema de notificaciones
        alert(message);
    }
}