import 'dart:convert';

class ValidationError {
  String? name;
  String? message;
  String? code;

  ValidationError({
    this.name,
    this.message,
    this.code,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'messages': message,
        'code': code,
      };

  factory ValidationError.fromMap(Map<String, dynamic> map) {
    return ValidationError(
      name: map['name'],
      message: map['message'],
      code: map['code'],
    );
  }

  factory ValidationError.fromJson(String source) => ValidationError.fromMap(json.decode(source));
}
