import 'package:amplify/pages/auth_screens/sign_up_page.dart';
import 'package:flutter/material.dart';

import '../../models/auth_credentials.dart';

class LoginPage extends StatefulWidget {
  // class LoginPage extends StatefulWidget { (line 3)

  final ValueChanged<LoginCredentials>? didProvideCredentials;

// final VoidCallback? shouldShowSignUp;

  LoginPage({Key? key, this.didProvideCredentials, this.shouldShowSignUp})
      : super(key: key);
  final VoidCallback? shouldShowSignUp;

 // @override (line 4)

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 1
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.black87,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // 2
    return Scaffold(
      // 3
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40),
          // 4
          child: Stack(children: [
            // Login Form
            SingleChildScrollView(
              child: Column(
                children: [
                  _loginForm(),

                  // 6
                  // Sign Up Button
                  Container(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        style: flatButtonStyle,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext _)=>SignUpPage()));
                        },
                        child: Text('Don\'t have an account? Sign up.'),
                      )),
                ],
              ),
            )
          ])),
    );
  }

  // 5
  Widget _loginForm() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      // Username TextField
      TextField(
        controller: _usernameController,
        decoration:
        InputDecoration(icon: Icon(Icons.mail), labelText: 'Username'),
      ),

      // Password TextField
      TextField(
        controller: _passwordController,
        decoration:
        InputDecoration(icon: Icon(Icons.lock_open), labelText: 'Password'),
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
      ),

      // Login Button
      TextButton(
        style: flatButtonStyle,
        onPressed: _login,
        child: Text('Login'),
      )
    ]);
  }

  // 7
  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('password: $password');

    final credentials =
    LoginCredentials(username: username, password: password);
    widget.didProvideCredentials!(credentials);
  }

}

