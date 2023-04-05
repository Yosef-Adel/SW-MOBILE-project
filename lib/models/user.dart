///This is the model class for the user. It contains the user's uid, username, email and password.

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String password;
  final String isVerified;
  final String isCreator;
  final String verifyEmailToken;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.password,
    required this.isVerified,
    required this.isCreator,
    required this.verifyEmailToken,
  });
}
