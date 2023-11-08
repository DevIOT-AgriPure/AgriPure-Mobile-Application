import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registro de Usuarios',
      home: UserTypeSelection(),
    );
  }
}

class UserTypeSelection extends StatelessWidget {
  const UserTypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1.0),
      
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Select your role',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20, // Tamaño de fuente del título
                fontWeight: FontWeight.bold, // Estilo de fuente en negrita
              ),
            ),
          const SizedBox(height: 50), // Espacio entre el título y los botones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la vista de Farmer
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(47, 152, 48, 1.0),
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Haz que el botón sea cuadrado
                    ),
                  ),
                  child: const Text('FARMER'),
                ),
                const SizedBox(width: 16), // Espacio entre los botones
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la vista de Specialist
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(47, 152, 48, 1.0),                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Haz que el botón sea cuadrado
                    ),
                  ),
                  child: const Text('SPECIALIST'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignInFarmer extends StatelessWidget {
  const SignInFarmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1.0),
      body: Center(
        child: const Text('Vista de registro para Farmer'),
      ),
    );
  }
}

class SignInSpecialist extends StatelessWidget {
  const SignInSpecialist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1.0),
      body: Center(
        child: const Text('Vista de registro para Specialist'),
      ),
    );
  }
}