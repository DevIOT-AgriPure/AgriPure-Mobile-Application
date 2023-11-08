import 'package:agripure_mobile/presentation/views/register.dart';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:agripure_mobile/presentation/views/login_view.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1.0),
      body: SafeArea( child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/logo_agripure.png'),
                        radius: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                        child: Text("AgriPure", style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 40,
                ),

                Center(
                  child: SlidingSwitch(
                    value: _isSignIn,
                    onChanged: (value) {
                      setState(() {
                        _isSignIn = value;
                      });
                    },
                    textOff: "Log In",
                    textOn: "Register",
                    width: 320,
                    height: 45,
                    colorOn: Colors.white,
                    colorOff: Colors.white,
                    background: const Color.fromRGBO(25, 25, 26, 1.0),
                    buttonColor: const Color.fromRGBO(47, 152, 48, 1.0),
                    onTap: (){}, onDoubleTap: (){}, onSwipe: (){},

                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 30,
          ),

          Expanded(
            child: _isSignIn ? const RegisterView() : const LoginView(),
          )

        ],
      )),
    );
  }
}