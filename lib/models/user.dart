///This is the model class for the user. It contains the user's uid, username, email and password.

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? password;
  bool? isVerified;
  bool? isCreator;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.password,
    this.isVerified,
    this.isCreator,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      emailAddress: json['emailAddress'],
      password: json['password'],
      isVerified: json['isVerified'],
      isCreator: json['isCreator'],
    );
  }
}
