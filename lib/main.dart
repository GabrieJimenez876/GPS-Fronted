import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'theme.dart'; // Importa el tema de colores

// Páginas
import 'pages/login_page.dart';
import 'pages/mapa_page.dart';
import 'pages/registro_page.dart';
import 'pages/agregar_linea_page.dart';
// Asumo que 'ver_rutas.html' se corresponde con 'mapa_page.dart' o similar.
// Usaremos mapa_page.dart como la página principal '/'

// --- CLAVE GLOBAL PARA LA NAVEGACIÓN (Solución al error del Navigator) ---
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Variables globales simuladas para el estado de la aplicación
bool _isLoggedIn = false;
String _userRole = 'GUEST'; // GUEST, USER, ADMIN
String _currentUsername = '';

// --- WIDGET PRINCIPAL DE LA APLICACIÓN ---
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Función llamada al iniciar sesión con éxito
  void _handleLoginSuccess(String username) {
    // Lógica de rol basada en el fragmento que proporcionaste
    final role = (username.toLowerCase() == 'admin') ? 'ADMIN' : 'USER';

    setState(() {
      _isLoggedIn = true;
      _userRole = role;
      _currentUsername = username;
    });

    // Navegar usando la clave global para evitar el error de contexto
    navigatorKey.currentState!.pushReplacementNamed('/');
  }

  // Función para cerrar sesión
  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
      _userRole = 'GUEST';
      _currentUsername = '';
    });
    // Navegar de vuelta a la ruta principal
    navigatorKey.currentState!.pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS Transporte — La Paz',
      theme: appTheme, // Aplicando el tema con colores del CSS original
      navigatorKey: navigatorKey, // Asignando la clave global al Navigator
      initialRoute: '/',
      routes: {
        '/': (context) =>
            const MainAppShell(), // Usa el nuevo shell como principal
        '/login': (context) => LoginPage(onLoginSuccess: _handleLoginSuccess),
        '/register': (context) => const RegistroPage(),
        '/add_line': (context) => const AgregarLineaPage(),
      },
    );
  }
}

// --- APP SHELL (Replicando Header y Footer del index.html) ---

class MainAppShell extends StatelessWidget {
  const MainAppShell({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos los botones de la barra de navegación
    List<Widget> getNavButtons() {
      if (_isLoggedIn) {
        // Usuario logueado
        return [
          if (_userRole == 'ADMIN')
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () => Navigator.of(context).pushNamed('/add_line'),
              icon: const Icon(Icons.settings, size: 18),
              label: const Text('Admin'),
            ),
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () => (_MyAppState()._handleLogout()),
            icon: const Icon(Icons.logout, size: 18),
            label: Text('Salir (${_currentUsername})'),
          ),
        ];
      } else {
        // Usuario no logueado
        return [
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.9),
              foregroundColor: primaryColor,
            ),
            onPressed: () => Navigator.of(context).pushNamed('/register'),
            icon: const Icon(Icons.person_add, size: 18),
            label: const Text('Registrarse'),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pushNamed('/login'),
            icon: const Icon(Icons.login, size: 18),
            label: const Text('Iniciar sesión'),
          ),
        ];
      }
    }

    // Estructura de navegación replicada
    return Scaffold(
      appBar: AppBar(
        // Replicando el .header-inner
        title: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF031A17),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'LP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'GPS Transporte — La Paz',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Centro de transporte comunitario',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
        toolbarHeight:
            90, // Un poco más grande para acomodar el logo y el título
        actions: getNavButtons(), // Botones de Login/Logout
      ),
      body:
          const MapPageWithControls(), // Aquí se inserta el Mapa y los controles (replicando el 'Main content')
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        color: primaryColor,
        child: const Text(
          '© 2025 GPS Transporte - Contacto: lapazbus@lapaz.bo',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}

// --- WIDGET CONTENEDOR DE MAPA Y CONTROLES ---

// Replicando la estructura Grid (Panel y Mapa) del index.html
class MapPageWithControls extends StatelessWidget {
  const MapPageWithControls({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1100,
          ), // Max-width replicado
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Si la pantalla es ancha (desktop), usa el grid de 2 columnas
              if (constraints.maxWidth > 880) {
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 360,
                      child: SearchPanel(), // Panel de búsqueda replicado
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: MapContainer(), // Contenedor del mapa
                    ),
                  ],
                );
              } else {
                // Si la pantalla es móvil/tablet, usa una columna
                return const Column(
                  children: [
                    SearchPanel(),
                    SizedBox(height: 12),
                    MapContainer(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

// --- PANEL DE BÚSQUEDA (Panel izquierdo) ---
class SearchPanel extends StatelessWidget {
  const SearchPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // Contenido replicado del panel de búsqueda del HTML
    return const Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Destino',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // ... (Simulación de campo de texto y botones)
            // Aquí puedes agregar tus controladores y lógica de formulario
            TextField(
              decoration: InputDecoration(
                labelText: 'Destino',
                hintText: 'Ej: Plaza Murillo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: null, // Lógica pendiente
                    child: Text('Mi ubicación'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: null, // Lógica pendiente
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(accentColor),
                    ),
                    child: Text(
                      'Marcar destino',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            // ... (Resto de botones y lista de lugares rápidos)
            // Solo para mantener la estructura visual
            SizedBox(height: 16),
            Divider(color: Color(0xFFEEEEEE), height: 1),
            SizedBox(height: 8),
            Text(
              'Lugares rápidos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            // Esto se reemplazaría por una lista dinámica
            ListTile(
              leading: Icon(Icons.location_on, color: primaryColor),
              title: Text('Plaza Murillo'),
              dense: true,
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: primaryColor),
              title: Text('Miraflores'),
              dense: true,
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: primaryColor),
              title: Text('Terminal'),
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
}

// --- CONTENEDOR DEL MAPA ---
class MapContainer extends StatelessWidget {
  const MapContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // Card replicando .panel y .map-box
    return Card(
      elevation: 4,
      child: SizedBox(
        height: 520, // Replicando --map-height: 520px
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          // Aquí va el widget de mapa real, que será MapViewPage (o mapa_page.dart)
          child: const MapaPage(),
        ),
      ),
    );
  }
}
