
//Reusable FormValidator Class
class FormValidator {

  static  validateName(String? value) {
    final alphaNumericText = RegExp(r'^[a-zA-Z0-9]+$');
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    else
    if (alphaNumericText.hasMatch(value) == false) {
      return 'Use alphanumeric characters only.';
    }
    else
    if (value.length<2) {
      return 'Input more than 2 letters.';
    }
    return null;
  }

  static  validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    else{
      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
      if(emailValid==false) {
        return 'Not email.';
      }
    }
    return null;
  }

  static  validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    else
    if(value.length<6) {
      return 'Password is too short!';
    }
    else
    if(value.length<8) {
      return 'Your password is acceptable but not strong!';
    }
    // else
    // if(value.length>=8) {
    //   return 'Your password is strong!';
    // }
    return null;
  }

  static  validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    else
    if(value != password) {
      return 'Please enter correct password';
    }
    return null;
  }

}