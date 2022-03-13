import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart/Auth/fire_auth.dart';
import 'package:shopsmart/Pages/SignupPage.dart';

final _formKey = GlobalKey<FormState>();

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final myController = TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String textHolder = '';

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
      Text('Shopsmart auth', style: TextStyle(fontSize: 30)),
      Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
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
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
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
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Text('$textHolder', style: TextStyle(fontSize: 21)),
            ElevatedButton(
              style: style,
              onPressed: () async {
                changeText('');

                if (_formKey.currentState!.validate()) {
                  // text in form is valid
                  User? user = await FireAuth.signInUsingEmailPassword(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context)
                      .catchError((Object e, StackTrace stackTrace) {
                    debugPrint('e.toString()');
                    debugPrint(e.toString());
                    // var arr = e.toString().split(']');
                    // if (arr.length > 0)
                    //   return changeText(arr[1]);
                    // else
                    //   debugPrint('An internal error occured');
                  });
                  //debugPrint(user!.emailVerified.toString());
                  debugPrint('inside the validation');

                  if (user != null) {
                    debugPrint(user.emailVerified.toString());

                    if (!user.emailVerified)
                      return changeText(
                          'Please verify your email before logging in');

                    return changeText('you\'re in!');
                  } else if (user == null) {
                    return changeText('We were unable to locate your details');
                  }
                }
                //changeText('Don\'t know you sorry');

                debugPrint('outside the validation');
                // UserCredential userCredential = await auth.signInWithEmailAndPassword(
                // email: email,
                // password: password,
                // );
                // user = userCredential.user;
              },
              child: const Text('Login'),
            ),
            Text('Or', style: TextStyle(fontSize: 21)),
            ElevatedButton(
              style: style,
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupPage()));
              },
              child: const Text('Sign up'),
            ),
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
