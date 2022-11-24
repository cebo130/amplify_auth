import 'dart:async';

import 'auth_credentials.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify/amplifyconfiguration.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

// 1
enum AuthFlowStatus { login, signUp, verification, session }


// 2
class AuthState {
  final AuthFlowStatus? authFlowStatus;

  AuthState({this.authFlowStatus});
}

// 3
class AuthService {
  // 4
  final authStateController = StreamController<AuthState>();
  late AuthCredentials _credentials;
  // 5
  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signUp);
    authStateController.add(state);
  }

  // 6
  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }
  void loginWithCredentials(AuthCredentials credentials) async {
    try {
      // 2
      final result = await Amplify.Auth.signIn(
          username: credentials.username, password: credentials.password);

      // 3
      if (result.isSignedIn) {
        final state = AuthState(authFlowStatus: AuthFlowStatus.session);
        authStateController.add(state);
      } else {
        // 4
        print('User could not be signed in');
      }
    } on AmplifyException catch (authError) {
      print('Failed to sign up - ${authError.message}');
    }
  }

// 2
  void signUpWithCredentials(SignUpCredentials credentials) async {
    try {
      // 2

      final Map<CognitoUserAttributeKey, String> userAttributes = {
        // 'email': credentials.email,
        // 'phone_number': credentials.phonenumber,
        CognitoUserAttributeKey.email: credentials.email,
        CognitoUserAttributeKey.phoneNumber: credentials.phonenumber,
      };

      final result = await Amplify.Auth.signUp(
          username: credentials.username,
          password: credentials.password,
          options: CognitoSignUpOptions(userAttributes: userAttributes,));

      if (result.isSignUpComplete) {
        // 5
        this._credentials = credentials;

        // 6
        final state = AuthState(authFlowStatus: AuthFlowStatus.verification);
        authStateController.add(state);
      }
      // 7
    } on AmplifyException catch (authError) {
      print('Failed to sign up - ${authError.message}');
    }
  }
  void verifyCode(String verificationCode) async {
    try {
      // 2
      final result = await Amplify.Auth.confirmSignUp(
          username: _credentials.username, confirmationCode: verificationCode);

      // 3
      if (result.isSignUpComplete) {
        loginWithCredentials(_credentials);
      } else {
        // 4
        // Follow more steps
      }
    } on AmplifyException catch (authError) {
      print('Failed to sign up - ${authError.message}');
    }
  }
  void logOut() async {
    try {
      // 1
      await Amplify.Auth.signOut();

      // 2
      showLogin();
    } on AmplifyException catch (authError) {
      print('Failed to sign up - ${authError.message}');
    }
  }
  void checkAuthStatus() async {
    try {
      await Amplify.Auth.fetchAuthSession();

      final state = AuthState(authFlowStatus: AuthFlowStatus.session);
      authStateController.add(state);
    } catch (_) {
      final state = AuthState(authFlowStatus: AuthFlowStatus.login);
      authStateController.add(state);
    }
  }
}
