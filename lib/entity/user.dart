class User {
  final int id;
  final String email;
  final DateTime registerDate;
  final List posseder;


  const User({
    required this.id,
    required this.email,
    required this.registerDate,
    required this.posseder,
  });

  factory User.fromJSON(Map json) {
      return User(
        id: json['id'],
        email: json['email'],
        registerDate: DateTime.parse(json['dateInscription']),
        posseder: json['posseders'],
      );
  }
}
