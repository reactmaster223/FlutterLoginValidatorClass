import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart/Common/APIConst.dart';
import 'package:shopsmart/Pages/SignupPage.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// import 'package:shopsmart/Pages/AuthPage.dart';

final _formKeyLogin = GlobalKey<FormState>();

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final myController = TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String textHolder = '';
  bool hide = true;
  bool _isShown = false;

  changeText(String txt) {
    setState(() {
      textHolder = txt;
    });
  }

  final userPool = CognitoUserPool(
    'xxx',
    'xxx',
  );

  static const PrimaryColor = Color.fromARGB(255, 16, 14, 24);

  @override
  Widget build(BuildContext context) {
    // new page needs scaffolding!
    return Scaffold(
      body: Container(
          color: PrimaryColor,
          child: Form(
            key: _formKeyLogin,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 32.0,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/img/Shopsmart3(S).jpg',
                              scale: 2.5),
                          SizedBox(
                            height: 20,
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      autofocus: true,
                      controller: emailController,
                      decoration: new InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(133, 103, 172, 1),
                                width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: (Color.fromRGBO(133, 103, 172, 1)),
                                width: 2.0),
                          ),
                          border: const OutlineInputBorder(),
                          labelStyle: new TextStyle(
                            color: Color.fromRGBO(133, 103, 172, 1),
                          ),
                          labelText: 'Username / email'),
                      style: TextStyle(color: Color.fromRGBO(133, 103, 172, 1)),
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: TextFormField(
                      autofocus: true,
                      controller: passwordController,
                      decoration: new InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(133, 103, 172, 1),
                                width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: (Color.fromRGBO(133, 103, 172, 1)),
                                width: 2.0),
                          ),
                          border: const OutlineInputBorder(),
                          labelStyle: new TextStyle(
                            color: Color.fromRGBO(133, 103, 172, 1),
                          ),
                          labelText: 'Password'),
                      style: TextStyle(color: Color.fromRGBO(133, 103, 172, 1)),
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
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Visibility(
                        visible: _isShown,
                        child: Text('\u26A0 $textHolder',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(236, 28, 36, 1))),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Builder(
                      builder: (context) {
                        // The basic Material Design action button.
                        return ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isShown = false;
                            });
                            if (_formKeyLogin.currentState!.validate()) {
                              try {
                                final cognitoUser =
                                    CognitoUser(emailController.text, userPool);
                                final authDetails = AuthenticationDetails(
                                  username: emailController.text,
                                  password: passwordController.text,
                                );

                                final CognitoUserSession session;
                                session = (await cognitoUser
                                    .authenticateUser(authDetails))!;
                              } on CognitoClientException catch (e) {
                                setState(() {
                                  _isShown = true;
                                });
                                debugPrint(e.code.toString());
                                //debugPrint(e.code! == 'UserNotFoundException');
                                if (e.code.toString() ==
                                    'UserNotFoundException') {
                                  changeText(APIConst.ACCOUNT_NOT_FOUND);
                                }
                              }
                              // debugPrint('cognitoUser');
                              // debugPrint(cognitoUser.authenticationFlowType);
                              // debugPrint('authDetails');
                              // debugPrint(authDetails.validationData.entries
                              //     .toString());
                              // debugPrint('session');
                              // debugPrint(session.isValid().toString());
                              // debugPrint(
                              //     session.accessToken.jwtToken.toString());
                              //debugPrint('inside the validation');

                              // if (user != null) {
                              //   debugPrint(user.emailVerified.toString());

                              //   if (!user.emailVerified) {
                              //     setState(() {
                              //       hide = !hide;
                              //     });
                              //     return changeText(
                              //         'Please verify your email before logging in');
                              //   }

                              //   return changeText('you\'re in!');
                              // } else if (user == null) {
                              //   setState(() {
                              //     hide = !hide;
                              //   });
                              //   return changeText(
                              //       'Unable to locate your details');
                              // }

                            }
                          },
                          child: Text('LogIn'),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(133, 103, 172, 1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 0),
                              textStyle: const TextStyle(fontSize: 18)),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      onPressed: () {},
                      child: const Text('Forgot Password?',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(133, 103, 172, 1))),
                    ),
                  ),
                  Column(children: <Widget>[
                    Row(
                      children: <Widget>[],
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Color.fromRGBO(133, 103, 172, 1),
                              height: 36,
                            )),
                      ),
                      Text(
                        "OR",
                        style: const TextStyle(
                            color: Color.fromRGBO(133, 103, 172, 1)),
                      ),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: Color.fromRGBO(133, 103, 172, 1),
                              height: 36,
                            )),
                      ),
                    ]),
                    Row(
                      children: <Widget>[],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Builder(
                        builder: (context) {
                          // The basic Material Design action button.
                          return ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupPage()));
                            },
                            child: Text('Create Shopsmart account'),
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(133, 103, 172, 1),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                textStyle: const TextStyle(fontSize: 18)),
                          );
                        },
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          )),
    );
  }
}
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//     return Form(
//       key: _formKeyLogin,
//       child: Column(
//         children: <Widget>[
//           //start here
//         ],
//       ),
//     );
//   }
// }


  // List<Widget> getFormWidget() {
  //   List<Widget> formWidget = new List();

  //   formWidget.add(new TextFormField(
  //     decoration: InputDecoration(labelText: 'Enter Name', hintText: 'Name'),
  //     validator: (value) {
  //       if (value.isEmpty) {
  //         return 'Please enter a name';
  //       }
  //       return null;
  //     },
  //     onSaved: (value) {
  //       setState(() {
  //         _name = value;
  //       });
  //     },
  //   ));

  //   String validateEmail(String value) {
  //     if (value.isEmpty) {
  //       return 'Please enter mail';
  //     }

  //     Pattern pattern =
  //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //     RegExp regex = new RegExp(pattern);
  //     if (!regex.hasMatch(value))
  //       return 'Enter Valid Email';
  //     else
  //       return null;
  //   }


// Positioned(
//     width: MediaQuery.of(context).size.width,
//     top: MediaQuery.of(context).size.width *
//         0.70, //TRY TO CHANGE THIS **0.30** value to achieve your goal
//     child: Container(
//       margin: EdgeInsets.all(16.0),
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               autofocus: true,
//               controller: emailController,
//               decoration: new InputDecoration(
//                   enabledBorder: const OutlineInputBorder(
//                     // width: 0.0 produces a thin "hairline" border
//                     borderSide: const BorderSide(
//                         color:
//                             Color.fromRGBO(133, 103, 172, 1),
//                         width: 0.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                         color: (Color.fromRGBO(
//                             133, 103, 172, 1)),
//                         width: 2.0),
//                   ),
//                   border: const OutlineInputBorder(),
//                   labelStyle: new TextStyle(
//                     color: Color.fromRGBO(133, 103, 172, 1),
//                   ),
//                   labelText: 'Username / email'),
//               onSaved: (String? value) {
//                 // This optional block of code can be used to run
//                 // code when the user saves the form.
//               },
//               validator: (String? value) {
//                 debugPrint('hello>>>>>');
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter enter your username';
//                 }
//                 return null;
//               },
//             ),
//           ]),
//     )),
// Positioned(
//     width: MediaQuery.of(context).size.width,
//     top: MediaQuery.of(context).size.width *
//         0.70, //TRY TO CHANGE THIS **0.30** value to achieve your goal
//     child: Container(
//       margin: EdgeInsets.all(16.0),
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {},
//               child: Text('Login'),
//               style: ElevatedButton.styleFrom(
//                   primary: Color.fromRGBO(133, 103, 172, 1),
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 4, vertical: 4),
//                   textStyle: const TextStyle(fontSize: 26)),
//             ),
//           ]),
//     )),

// Positioned(
//     width: MediaQuery.of(context).size.width,
//     top: MediaQuery.of(context).size.width *
//         0.70, //TRY TO CHANGE THIS **0.30** value to achieve your goal
//     child: Container(
//       margin: EdgeInsets.all(16.0),
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               autofocus: true,
//               controller: emailController,
//               decoration: new InputDecoration(
//                   enabledBorder:
//                       const OutlineInputBorder(
//                     // width: 0.0 produces a thin "hairline" border
//                     borderSide: const BorderSide(
//                         color: Color.fromRGBO(
//                             133, 103, 172, 1),
//                         width: 0.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                         color: (Color.fromRGBO(
//                             133, 103, 172, 1)),
//                         width: 2.0),
//                   ),
//                   border: const OutlineInputBorder(),
//                   labelStyle: new TextStyle(
//                     color: Color.fromRGBO(
//                         133, 103, 172, 1),
//                   ),
//                   labelText: 'Username / email'),
//               onSaved: (String? value) {
//                 // This optional block of code can be used to run
//                 // code when the user saves the form.
//               },
//               validator: (String? value) {
//                 debugPrint('hello>>>>>');
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter enter your username';
//                 }
//                 return null;
//               },
//             ),
//           ]),
//     )),
