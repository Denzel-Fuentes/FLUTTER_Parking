import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:parking_app/RegistroScreen.dart';
import 'package:parking_app/Welcome.dart'; // Importa la pantalla de bienvenida
import 'package:parking_app/admin/AdminDashboard.dart';
import 'package:parking_app/animation/FadeAnimation.dart';
import 'package:parking_app/main_screen.dart';
import 'package:parking_app/models/User.dart';
import 'package:parking_app/repositories/user.dart';
import 'package:parking_app/services/user.dart';

class LoginDef extends StatefulWidget {
  const LoginDef({Key? key}) : super(key: key);

  @override
  State<LoginDef> createState() => _LoginDefState();
}

class _LoginDefState extends State<LoginDef> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  UserService service = UserService(repository: UserRepository());

  String _email = "";
  String _password = "";

  Future<void> _handleLogin() async {

    User user = await service.login(email: _email, password: _password);

    // Simulamos una validación de credenciales (deberías implementar una real aquí)
    if (user.isAdmin! && kIsWeb) {
      // Solo en la web y si las credenciales son de un administrador
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminDashboard()),
      );
    } else {
      // Redirección para usuarios móviles o credenciales incorrectas
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: kIsWeb
                ? [Colors.blue.shade800, Colors.blue.shade300] // Azul para web
                : [
                    Color.fromARGB(229, 188, 1, 1),
                    Colors.red
                  ], // Rojo para móvil
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                    1,
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.asset('assets/img/univalle.png'),
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeAnimation(
                    1,
                    const Text("BIENVENIDO",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'MartianMono')),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 60),
                        FadeAnimation(
                          1.5,
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                        hintText: "Usuario",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Por Favor Introduce Tu Email";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _email = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
                                  child: TextFormField(
                                    controller: _passController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        hintText: "Contraseña",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Por Favor Introduce Tu Contraseña";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _password = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        FadeAnimation(
                          1.5,
                          Container(
                            height: 50,
                            width: 200,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  _handleLogin();
                                }
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        FadeAnimation(
                          1.5,
                          Container(
                            height: 50,
                            width: 200,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                  )),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistroScreen()),
                                );
                              },
                              child: const Text(
                                "Registrarse",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
