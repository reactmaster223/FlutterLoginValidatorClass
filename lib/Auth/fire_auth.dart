import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FireAuth {
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      debugPrint(user!.emailVerified.toString());
      // if (user!.emailVerified) {
      //   debugPrint('email not verified');
      //   user.sendEmailVerification();
      // }

      // await user!.updateProfile(displayName: name);
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
      debugPrint('fuck>>>');
      if (!user!.emailVerified) {
        debugPrint('fuck');
        await user.sendEmailVerification();
        //  user.sendEmailVerification().then(function(){
        //     console.log("email verification sent to user");
        //   });
      }
    } on FirebaseAuthException catch (e) {
      throw (e);
    } catch (e) {
      throw (e);
    }

    return user;
  }
}

Future<User?> signInUsingEmailPassword({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    throw (e);
  } catch (e) {
    debugPrint('e.toString()');
    throw (e);
  }

  return user;
}
