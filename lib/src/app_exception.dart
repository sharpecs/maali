/// A specialised exception class for application errors allowing for logging
/// and audit purposes.
class AppException implements Exception {
  late int id;
  late String code;
  late String text;

  AppException({
    required this.id,
    required this.code,
    required this.text,
  });

  factory AppException.fromJson(Map<String, dynamic> json) {
    return AppException(
      id: json['i'] as int,
      code: json['n'] as String,
      text: json['e'] as String,
    );
  }

  /// A function to convert the current object to a map for storing as JSON.
  Map<String, dynamic> toJson() => {
        "i": id,
        "c": code,
        "t": text,
      };
}
