import 'package:flutter/material.dart';
import 'package:parking_app/Welcome.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({Key? key}) : super(key: key);

  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String _selectedCountryCode = '+591'; // Código predeterminado
  String _userType = 'Cliente'; // Tipo de usuario seleccionado
  List<String> countryCodes = ['+1', '+44', '+34', '+591']; // Lista de códigos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crear cuenta"), backgroundColor: Colors.red),
      body: Container(
        color: Colors.white, // Fondo blanco
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text("Registro", style: TextStyle(color: Colors.red, fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: inputDecoration('Usuario'),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: inputDecoration('Contraseña'),
                  ),
                  TextField(
                    controller: fullNameController,
                    decoration: inputDecoration('Nombre Completo'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2, // Proporción para el código de país
                        child: DropdownButtonFormField<String>(
                          value: _selectedCountryCode,
                          decoration: inputDecoration(''),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCountryCode = newValue!;
                            });
                          },
                          items: countryCodes.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(width: 5), // Espacio entre los dos campos
                      Expanded(
                        flex: 20, // Proporción para el número de teléfono
                        child: TextField(
                          controller: phoneController,
                          decoration: inputDecoration('Número de teléfono'),
                        ),
                      ),
                    ],
                  ),
                  
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => registerUser(),
                    child: Text('Continuar', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey), // Ajustando al color de los textos
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      fillColor: Colors.white,
      filled: true,
    );
  }

  Widget buildRadioOption(String title) {
    return RadioListTile<String>(
      title: Text(title, style: TextStyle(color: Colors.black)),
      value: title,
      groupValue: _userType,
      onChanged: (value) {
        setState(() {
          _userType = value!;
        });
      },
      activeColor: Colors.red,
    );
  }

  void registerUser() {
  print('Usuario registrado con: ${emailController.text}');
  print('Tipo de usuario: $_userType');
  Fluttertoast.showToast(msg: 'Registro exitoso');
  
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Welcome()),
  );
}}