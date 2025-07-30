import 'package:flutter/material.dart';
import 'package:pry_poliza/services/login_service.dart';
import 'package:pry_poliza/themes/text_styles.dart';
import 'package:pry_poliza/themes/button_styles.dart';


class LoginView extends StatefulWidget{
  @override
  State<LoginView> createState() => LoginPageState();
}

class LoginPageState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _claveController = TextEditingController();
  String mensaje = "";
  bool _obscureText = true;
  bool recordarCheck = false;
  bool _isLoading = false; // Para controlar el estado de carga

  final controller = LoginService();

  @override
  void dispose() {
    _emailController.dispose();
    _claveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Form( // Envuelve el Column con Form
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/poliza.png',
                    width: 120,
                    height: 120,
                  ),
                  // Icon(Icons.person, size: 100, color: Colors.white),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    style: AppTextStyles.input,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 13),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: controller.validarEmail,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _claveController,
                    obscureText: _obscureText,
                    style: AppTextStyles.input,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 13),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() => _obscureText = !_obscureText);
                        },
                      ),
                    ),
                    validator: controller.validarClave, // Cambiado a validarClave
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: recordarCheck,
                            onChanged: (bool? value) {
                              setState(() => recordarCheck = value!);
                            },
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                  (states) => recordarCheck
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                            checkColor: Colors.purpleAccent,
                          ),
                          Text('Recuérdame', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                      TextButton(
                        style: AppButtonStyles.ancle(context),
                        onPressed: () {
                          Navigator.pushNamed(
                              context,
                              '/register'
                          );
                        },
                        child: Text(
                          '¿Sin Cuenta?',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          style: AppButtonStyles.signIn(context),
                          onPressed: _isLoading
                              ? null
                              : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => _isLoading = true);
                              String mensajeValidacion = await controller.login(
                                  _emailController,
                                  _claveController,
                                  context);
                              if (mounted) setState(() => _isLoading = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(mensajeValidacion,
                                  selectionColor: Colors.white,)),
                              );
                            }
                          },
                          child: _isLoading
                              ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                              : Text(
                            'Iniciar Sesion',
                            style: TextStyle(
                              color: Colors.purpleAccent,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}