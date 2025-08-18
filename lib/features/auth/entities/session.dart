class Session {
  final String provider; // 'google' or 'apple'
  final String? name;
  final String? email;
  final String? photoUrl;
  final String? idToken;

  Session({
    required this.provider,
    this.name,
    this.email,
    this.photoUrl,
    this.idToken,
  });

  Map<String, dynamic> toJson() => {
        'provider': provider,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'idToken': idToken,
      };

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        provider: json['provider'],
        name: json['name'],
        email: json['email'],
        photoUrl: json['photoUrl'],
        idToken: json['idToken'],
      );
}
