from flask import Flask, request, render_template_string

# 1. Configuración de la aplicación Flask
app = Flask(__name__)

# 2. Base de datos simulada (Lista para guardar las líneas)
lineas_de_transporte = []

# --- Función para servir la página HTML (el formulario) ---
@app.route('/', methods=['GET'])
def mostrar_formulario():
    
    return render_template_string(html_formulario)


# --- Función para procesar y guardar los datos del formulario ---
@app.route('/guardar_linea', methods=['POST'])
def guardar_linea():
    # Obtener los datos enviados por el formulario (con los atributos 'name')
    nombre = request.form.get('nombre')
    codigo = request.form.get('codigo')
    sindicato = request.form.get('sindicato')
    paradas_raw = request.form.get('paradas')
    recorrido = request.form.get('recorrido')

    # Procesar las paradas separadas por coma en una lista
    paradas_list = [p.strip() for p in paradas_raw.split(',') if p.strip()]

    # Crear un diccionario con la nueva línea de transporte
    nueva_linea = {
        'nombre': nombre,
        'codigo': codigo,
        'sindicato': sindicato,
        'paradas': paradas_list,
        'recorrido': recorrido
    }

    # Guardar la nueva línea en nuestra "base de datos" simulada
    lineas_de_transporte.append(nueva_linea)

    # Devolver una respuesta al usuario
    return f"""
    <h2>✅ Línea de Transporte Guardada con Éxito</h2>
    <p><strong>Código:</strong> {codigo}</p>
    <p><strong>Nombre:</strong> {nombre}</p>
    <p><strong>Sindicato:</strong> {sindicato}</p>
    <p><strong>Total de Líneas Registradas:</strong> {len(lineas_de_transporte)}</p>
    <p><a href="/">Volver al formulario</a></p>
    """

# 3. Ejecutar el servidor
if __name__ == '__main__':
    # Esto inicia el servidor en http://127.0.0.1:5000/
    print("Servidor Flask corriendo. Visita http://127.0.0.1:5000/")
    app.run(debug=True)
#hello
