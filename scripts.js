// Configuración inicial
document.addEventListener('DOMContentLoaded', () => {
  // Ocultar botón de admin inicialmente
  const btnAdmin = document.getElementById('btnAdmin');
  if (btnAdmin) btnAdmin.style.display = 'none';
  
  // Evento para botón de inicio de sesión
  const btnLogin = document.getElementById('btnLogin');
  if (btnLogin) {
    btnLogin.addEventListener('click', () => {
      document.getElementById('loginModal').style.display = 'flex';
    });
  }
});

// Funciones de autenticación
function closeLoginModal() {
  document.getElementById('loginModal').style.display = 'none';
}

function login() {
  const email = document.getElementById('email').value;
  const password = document.getElementById('password').value;
  
  // Validar que el email contiene @
  if (!email.includes('@')) {
    alert('El correo debe contener @');
    return;
  }
  
  // Validar credenciales de admin
  if (email === 'admin@admin.com' && password === 'admin123') {
    // Mostrar botón de admin
    const btnAdmin = document.getElementById('btnAdmin');
    if (btnAdmin) btnAdmin.style.display = 'inline-flex';
    
    alert('Bienvenido Administrador');
    closeLoginModal();
    
    // Guardar estado de sesión
    sessionStorage.setItem('isAdmin', 'true');
  } else {
    alert('Credenciales incorrectas');
  }
}

// Verificar estado de sesión al cargar
if (sessionStorage.getItem('isAdmin') === 'true') {
  const btnAdmin = document.getElementById('btnAdmin');
  if (btnAdmin) btnAdmin.style.display = 'inline-flex';
}