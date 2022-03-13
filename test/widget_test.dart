
//Testing FormValidator Class

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shopsmart/Validators/FormValidator.dart';
void main() {
  group('Home', () {
    test('Empty Name Test', () {
      var result = FormValidator.validateName('');
      expect(result, 'Please enter your name');
    });
    test('Short Name Test', () {
      var result = FormValidator.validateName('a');
      expect(result, 'Input more than 2 letters.');
    });
    test('Empty Email Test', () {
      var result = FormValidator.validateEmail('');
      expect(result, 'Please enter your email');
    });

    test('Invalid Email Test', () {
      var result = FormValidator.validateEmail('asdfasdfasdf');
      expect(result, 'Not email.');
    });

    test('Valid Email Test', () {
      var result = FormValidator.validateEmail('ajay.kumar@nonstopio.com');
      expect(result, null);
    });

    test('Empty Password Test', () {
      var result = FormValidator.validatePassword('');
      expect(result, 'Please enter your password');
    });

    test('Invalid Password Test', () {
      var result = FormValidator.validatePassword('123');
      expect(result, 'Password is too short!');
    });

    test('Valid Password Test', () {
      var result = FormValidator.validatePassword('ajay12345');
      expect(result, null);
    });

    test('Empty Confirm Password Test', () {
      var result = FormValidator.validateConfirmPassword('', 'ajay12345');
      expect(result, "Please enter your password");
    });

    test('Correct Confirm Password Test', () {
      var result = FormValidator.validateConfirmPassword('ajay12345', 'ajay12345');
      expect(result, null);
    });

  });
}
