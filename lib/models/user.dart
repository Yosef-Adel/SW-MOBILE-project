///This is the model class for the user. It contains the user's uid, username, email and password.

class User {
  final String uid;
  final String username;
  final String email;
  final String password;

  const User(
      {required this.uid,
      required this.username,
      required this.email,
      required this.password});
}
