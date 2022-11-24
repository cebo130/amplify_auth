import 'package:amplify/pages/auth_screens/login_page.dart';
import 'package:amplify/pages/auth_screens/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'models/auth_service.dart';
import 'package:amplify/pages/auth_screens/verification_page.dart';
import 'pages/gps_page.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify/amplifyconfiguration.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

void main() {
  runApp(MyApp());
}

// 1
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _authService = AuthService();
  @override
  void initState() {
    super.initState();
    _configureAmplify();
    _authService.showLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workshop App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      // 2
      home: StreamBuilder<AuthState>(
        // 2
          stream: _authService.authStateController.stream,
          builder: (context, snapshot) {
            // 3
            if (snapshot.hasData) {
              return Navigator(
                pages: [
                  // 4
                  // Show Login Page
                  if (snapshot.data!.authFlowStatus == AuthFlowStatus.login)
                    MaterialPage(
                        child: LoginPage(
                            shouldShowSignUp: _authService.showSignUp,didProvideCredentials: _authService.loginWithCredentials,)),

                  // 5
                  // Show Sign Up Page
                  if (snapshot.data!.authFlowStatus == AuthFlowStatus.signUp)
                    MaterialPage(
                        child: SignUpPage(
                            shouldShowLogin: _authService.showLogin,didProvideCredentials: _authService.signUpWithCredentials,)),
                  if (snapshot.data!.authFlowStatus == AuthFlowStatus.verification)
                    MaterialPage(child: VerificationPage(
                        didProvideVerificationCode: _authService.verifyCode)),
                  if (snapshot.data!.authFlowStatus == AuthFlowStatus.session)
                    MaterialPage(
                        child: GpsPage(shouldLogOut: _authService.logOut))
                ],
                onPopPage: (route, result) => route.didPop(result),
              );
            } else {
              // 6
              return Container(
                alignment: Alignment.center,
                child: Scaffold(body: Center(child: CircularProgressIndicator())),
              );
            }
          }),

    );
  }
  void _configureAmplify() async {
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    Amplify.addPlugins([authPlugin]);
    try {
      await Amplify.configure(amplifyconfig);
      print('Successfully configured Amplify');
    } catch (e) {
      print(e);
      print('Could not configure Amplify');
    }
  }
}
