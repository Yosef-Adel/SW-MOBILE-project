///This is the model class for the user. It contains the user's uid, username, email and password.

class User {
  //final String uid;
  final String firstName;
  final String surName;
  final String email;
  final String password;

  const User(
      { //required this.uid,
      required this.firstName,
      required this.surName,
      required this.email,
      required this.password});
}
