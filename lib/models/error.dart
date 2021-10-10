import 'dart:convert';

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

  factory Error.fromMap(Map<String, dynamic> map) {
    return Error(
      name: map['name'],
      message: map['message'],
      code: map['code'],
    );
  }

  factory Error.fromJson(String source) => Error.fromMap(json.decode(source));
}
