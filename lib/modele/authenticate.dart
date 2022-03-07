class Authenticate {
  final int? id;
  final String? token;
  final String? message;

  const Authenticate({
    this.id,
    this.token,
    this.message,
  });

  factory Authenticate.fromJSON(Map json) {
    if (json.containsKey('message')) {
      return Authenticate(message: json['message']);
    } else {
      return Authenticate(id: json['id'], token: json['token']);
    }
  }
}
