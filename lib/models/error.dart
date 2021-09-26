class Error {
  String? name;
  String? message;
  String? code;

  Error({
    this.name,
    this.message,
    this.code,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'messages': message,
        'code': code,
      };
}
