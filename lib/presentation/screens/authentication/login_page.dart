import 'package:flutter/material.dart';
import 'package:notes_app/business/providers/auth_provider.dart';
import 'package:notes_app/core/utils/helpers.dart';
import 'package:notes_app/presentation/screens/authentication/register_page.dart';
import 'package:notes_app/presentation/widgets/custom_elevated_button.dart';
import 'package:notes_app/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Icono de notas
                const Icon(Icons.note, size: 50, color: Colors.amber),
                const SizedBox(height: 10),

                //Texto de bienvenida
                const Text(
                  "Bienvenido a notas",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 15),

                //Textfield para correo
                CustomTextField(
                  hint: "Correo electronico",
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                //Text field para contrasena
                CustomTextField(
                  hint: "Contraseña",
                  controller: passwordController,
                  isObscured: true,
                ),
                const SizedBox(height: 10),

                //Texto no tienes cuenta, registrate
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "No tienes una cuenta?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Registrate",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                //Boton iniciar sesion
                CustomElevatedButton(
                  text: "Iniciar sesion",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String email = emailController.text.trim();
                      String password = passwordController.text;

                      await authProvider.login(email, password);
                      if (authProvider.currentUser != null) {
                        emailController.clear();
                        passwordController.clear();
                      } else {
                        showGlobalSnackBar(authProvider.errorMessage);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
