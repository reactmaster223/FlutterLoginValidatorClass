import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart/Common/APIConst.dart';
// import 'package:amazon_cognito_identity_dart_2/cognito.dart';

final _formKeySignup = GlobalKey<FormState>();

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignupPage> {
  final myController = TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordCompareController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  final userPool = CognitoUserPool(
    'xxx',
    'xxxx',
  );

  String textHolder = '';
  bool hide = true;
  // var _user = '';
  //var userService;

  changeText(String txt) {
    setState(() {
      textHolder = txt;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
        body: Column(children: [
      SizedBox(height: 200),
      Text('Sign up', style: TextStyle(fontSize: 30)),
      Form(
        key: _formKeySignup,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'What\'s your name?',
                labelText: 'Name *',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Whats you\'re email?',
                labelText: 'Email *',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                debugPrint('dsadasdsa');
                debugPrint(value);
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                icon: Icon(Icons.password),
                hintText: 'What\'s your password',
                labelText: 'Password *',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordCompareController,
              decoration: const InputDecoration(
                icon: Icon(Icons.password),
                hintText: 'Confirm password',
                labelText: 'Confirm Password *',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (passwordController.text != passwordCompareController.text) {
                  return 'The passwords do not match';
                }
                return null;
              },
            ),
            Text('$textHolder', style: TextStyle(fontSize: 21)),
            Opacity(
                opacity: hide ? 1 : 0,
                child: ElevatedButton(
                  style: style,
                  onPressed: () async {
                    changeText('');
                    debugPrint(emailController.text);
                    if (_formKeySignup.currentState!.validate()) {
                      String message;
                      bool signUpSuccess = false;

                      var data;
                      try {
                        final userAttributes = [
                          AttributeArg(
                              name: 'email', value: emailController.text),
                        ];

                        data = await userPool.signUp(
                          nameController.text,
                          passwordController.text,
                          userAttributes: userAttributes,
                        );

                        changeText(APIConst.ACCOUNT_CREATED);
                        setState(() {
                          hide = !hide;
                        });
                      } on CognitoClientException catch (e) {
                        debugPrint(e.code);
                        debugPrint(e.statusCode.toString());
                        if (e.code == 'UsernameExistsException') {
                          changeText(APIConst.USER_ALREADY_EXISTS);
                        }
                        if (e.code == 'InvalidPasswordException') {
                          changeText(APIConst.PASSWORD_REQUIREMENTS_NOT_MET);
                        }
                      }
                    }
                  },
                  child: const Text('Create account'),
                )),
            // Opacity(
            //     opacity: hide ? 1 : 0,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => AuthPage()));
            //       },
            //       child: Text('Login'),
            //       style: style,
            //     )),
          ],
        ),
      ),
    ]));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
}
