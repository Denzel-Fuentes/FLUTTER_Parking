import 'package:flutter/material.dart';
import 'package:parking_app/Welcome.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking_app/main_screen.dart';
import 'package:parking_app/models/User.dart';
import 'package:parking_app/repositories/user.dart';
import 'package:parking_app/services/user.dart';

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
  UserService service = UserService(repository: UserRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Crear cuenta"), backgroundColor: Colors.red),
      body: Container(
        color: Colors.white, // Fondo blanco
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const Text("Registro",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputDecoration('Correo Electronico'),
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
                        flex: 8, // Proporción para el código de país
                        child: DropdownButtonFormField<String>(
                          value: _selectedCountryCode,
                          decoration: inputDecoration(''),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCountryCode = newValue!;
                            });
                          },
                          items: countryCodes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        flex: 20, // Proporción para el número de teléfono
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: inputDecoration('Número de teléfono'),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => registerUser(),
                    child: const Text('Continuar',
                        style: TextStyle(color: Colors.white)),
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
      labelStyle: const TextStyle(color: Colors.grey),
      enabledBorder: const UnderlineInputBorder(
        borderSide:
            BorderSide(color: Colors.grey), // Ajustando al color de los textos
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      fillColor: Colors.white,
      filled: true,
    );
  }

  Widget buildRadioOption(String title) {
    return RadioListTile<String>(
      title: Text(title, style: const TextStyle(color: Colors.black)),
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

  Future<void> registerUser() async {
    User user = User(
      fullName: fullNameController.text,
      phone: phoneController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    try {
      await service.register(user);
      Fluttertoast.showToast(msg: 'Registro exitoso');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } catch (e) {
      dynamic error = e;
      Fluttertoast.showToast(
          msg: error.message ?? 'Error al realizar el registro');
    }
  }
}
