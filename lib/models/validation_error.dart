import 'dart:convert';

class ValidationError {
  String? key;
  String? message;
  String? code;

  ValidationError({
    this.key,
    this.message,
    this.code,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'key': key,
        'messages': message,
        'code': code,
      };

  factory ValidationError.fromMap(Map<String, dynamic> map) {
    return ValidationError(
      key: map['key'],
      message: map['message'],
      code: map['code'],
    );
  }

  factory ValidationError.fromJson(String source) => ValidationError.fromMap(json.decode(source));
}
