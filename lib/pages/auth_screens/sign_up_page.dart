import 'package:amplify/pages/auth_screens/login_page.dart';
import 'package:flutter/material.dart';

import '../../models/auth_credentials.dart';

class SignUpPage extends StatefulWidget {
  final ValueChanged<SignUpCredentials>? didProvideCredentials;


  SignUpPage({Key? key, this.didProvideCredentials, this.shouldShowLogin})
      : super(key: key);

  final VoidCallback? shouldShowLogin;
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phonenumberController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            // Sign Up Form
            SingleChildScrollView(
             child: Column(
               children: [
                 _signUpForm(),
                 // Login Button
                 Container(
                   alignment: Alignment.bottomCenter,
                   child: TextButton(
                       style: flatButtonStyle,
                       onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (BuildContext _)=>LoginPage()));
                       },//widget.shouldShowLogin,
                       child: Text('Already have an account? Login.')),
                 ),
               ],
             ),
           ),
          ])),
    );
  }

  Widget _signUpForm() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      // Username TextField
      TextField(
        controller: _usernameController,
        decoration:
        InputDecoration(icon: Icon(Icons.person), labelText: 'Username'),
      ),

      // Email TextField
      TextField(
        controller: _emailController,
        decoration: InputDecoration(icon: Icon(Icons.mail), labelText: 'Email'),
      ),

      TextField(
        controller: _phonenumberController,
        decoration: InputDecoration(icon: Icon(Icons.mail), labelText: 'Phone'),
      ),

      // Password TextField
      TextField(
        controller: _passwordController,
        decoration:
        InputDecoration(icon: Icon(Icons.lock_open), labelText: 'Password'),
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
      ),

      // Sign Up Button
      TextButton(
        style: flatButtonStyle,
        onPressed: _signUp,
        child: Text('Sign Up'),
      )
    ]);
  }

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final phonenumber = _phonenumberController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('email: $email');
    print('phonenumber: $phonenumber');
    print('password: $password');
    final credentials = SignUpCredentials(
        username: username,
        phonenumber: phonenumber,
        email: email,
        password: password);
    widget.didProvideCredentials!(credentials);
  }
}

