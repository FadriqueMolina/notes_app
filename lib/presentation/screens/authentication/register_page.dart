import 'package:flutter/material.dart';
import 'package:notes_app/business/providers/auth_provider.dart';
import 'package:notes_app/core/utils/helpers.dart';
import 'package:notes_app/presentation/screens/authentication/login_page.dart';
import 'package:notes_app/presentation/widgets/custom_elevated_button.dart';
import 'package:notes_app/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

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

                //Text field para confirmar contrasena
                CustomTextField(
                  hint: "Confirmar contraseña",
                  controller: confirmPasswordController,
                  isObscured: true,
                ),
                const SizedBox(height: 10),

                //Texto no tienes cuenta, registrate
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Ya tienes una cuenta?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Inicia sesion",
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
                  text: "Registrarse",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        String email = emailController.text.trim();
                        String password = passwordController.text;
                        await authProvider.register(email, password);
                        if (authProvider.currentUser != null) {
                          //TODO: Fix bug usuario no es redirigido a home page despues de hacer sign up
                          emailController.clear();
                          passwordController.clear();
                          confirmPasswordController.clear();
                          showGlobalSnackBar(
                            "El usuario fue creado exitosamente.",
                          );
                        } else {
                          showGlobalSnackBar(authProvider.errorMessage);
                        }
                      } else {
                        showGlobalSnackBar(
                          "Las contraseñas no coinciden, intentelo de nuevo.",
                        );
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
