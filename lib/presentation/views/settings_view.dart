import 'package:flutter/material.dart';
import 'package:agripure_mobile/services/settings_service.dart';
import 'package:agripure_mobile/services/auth_service.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isExpanded = false;

  Future<void> changeEmail(String newEmail, String password) async {
    try {
      await SettingsService.changeEmail(newEmail);
      // Mostrar una notificación o mensaje de éxito aquí
    } catch (error) {
      // Mostrar una notificación o mensaje de error aquí
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await SettingsService.changePassword(currentPassword, newPassword);
      // Mostrar una notificación o mensaje de éxito aquí
    } catch (error) {
      // Mostrar una notificación o mensaje de error aquí
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 40, 1.0), // Color de fondo gris
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Alinear al centro
          children: [
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20), // Espacio en blanco entre "Settings" y las divisiones

            // División para "Profile Settings" centrada
            Container(
              margin: EdgeInsets.symmetric(vertical: 10), // Ajuste del margen vertical
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpansionTile(
                    title: Text(
                      "Profile Settings",
                      textAlign: TextAlign.center, // Centrar el texto
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onExpansionChanged: (value) {
                      setState(() {
                        isExpanded = value;
                      });
                    },
                    children: [
                      if (isExpanded)
                        ListTile(
                          title: Text(
                            "Change Email",
                            textAlign: TextAlign.center, // Centrar el texto
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                String newEmail = '';
                                String password = '';

                                return AlertDialog(
                                  title: Text(
                                    "Change Email",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "New Email Address",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      TextField(
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                        ),
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          hintText: "Enter your new email",
                                          hintStyle: TextStyle(
                                            color: Colors.white.withOpacity(0.5),
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        onChanged: (value) {
                                          newEmail = value;
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.grey, // Color de fondo verde
                                        onPrimary: Colors.white, // Color del texto en blanco
                                      ),
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await changeEmail(newEmail, password);
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green, // Color de fondo verde
                                        onPrimary: Colors.white, // Color del texto en blanco
                                      ),
                                      child: Text(
                                        "Change",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      if (isExpanded)
                        ListTile(
                          title: Text(
                            "Change Password",
                            textAlign: TextAlign.center, // Centrar el texto
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                String currentPassword = '';
                                String newPassword = '';

                                return AlertDialog(
                                  title: Text(
                                    "Change Password",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Current Password",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      TextField(
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                        ),
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          hintText: "Current Password",
                                          hintStyle: TextStyle(
                                            color: Colors.white.withOpacity(0.5),
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        obscureText: true,
                                        onChanged: (value) {
                                          currentPassword = value;
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "New Password",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      TextField(
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                        ),
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          hintText: "Enter New Password",
                                          hintStyle: TextStyle(
                                            color: Colors.white.withOpacity(0.5),
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        obscureText: true,
                                        onChanged: (value) {
                                          newPassword = value;
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Reenter new Password",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      TextField(
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                        ),
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          hintText: "Enter New Password",
                                          hintStyle: TextStyle(
                                            color: Colors.white.withOpacity(0.5),
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        obscureText: true,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.grey, // Color de fondo verde
                                        onPrimary: Colors.white, // Color del texto en blanco
                                      ),
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await changePassword(currentPassword, newPassword);
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green, // Color de fondo verde
                                        onPrimary: Colors.white, // Color del texto en blanco
                                      ),
                                      child: Text(
                                        "Change",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Línea de división
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            // "Sign Off"
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Sign Off",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        content: Text(
                          "¿Está seguro de que desea salir?",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        backgroundColor: Colors.grey[800],
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              "Cancelar",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(); // Cierra el diálogo
                            },
                          ),
                          TextButton(
                            child: Text(
                              "Aceptar",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            onPressed: () {
                              AuthService.logOut().then((_) => {
                                Navigator.pushReplacementNamed(context, '/auth')
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Sign Off",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}