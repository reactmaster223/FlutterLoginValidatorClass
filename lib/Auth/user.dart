import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class User {
  late String email;
  late String name;
  late String password;
  late bool confirmed = false;
  late bool hasAccess = false;

  User({required this.email, required this.name});

  /// Decode user from Cognito User Attributes
  factory User.fromUserAttributes(List<CognitoUserAttribute> attributes) {
    final user = User(email: '', name: '');
    attributes.forEach((attribute) {
      if (attribute.getName() == 'email') {
        user.email = attribute.getValue() as String;
      } else if (attribute.getName() == 'name') {
        user.name = attribute.getValue() as String;
      } else if (attribute
          .getName()
          .toString()
          .toLowerCase()
          .contains('verified')) {
        if (attribute.getValue().toString().toLowerCase() == 'true') {
          user.confirmed = true;
        }
      }
    });
    return user;
  }
}
