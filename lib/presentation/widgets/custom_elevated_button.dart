import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // Estilo base
        foregroundColor: Colors.black, // Color del texto
        backgroundColor: Colors.grey[300], // Color de fondo
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ), // Espaciado interno
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
        ),
        elevation: 8, // Sombra
        shadowColor: Colors.black, // Color de la sombra
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        // Efecto al presionar
        side: const BorderSide(width: 1), // Borde exterior
      ),
      child: Text(text),
    );
  }
}
