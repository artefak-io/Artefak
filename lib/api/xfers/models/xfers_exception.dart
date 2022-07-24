import 'package:json_annotation/json_annotation.dart';

part 'xfers_exception.g.dart';

@JsonSerializable(createToJson: false, createFactory: true)
class XfersException implements Exception {
  final String code;
  final String title;
  final String detail;

  const XfersException({
    required this.code,
    required this.title,
    required this.detail,
  });

  factory XfersException.fromJson(Map<String, dynamic> json) =>
      _$XfersExceptionFromJson(json);

  @override
  String toString() {
    return "code: $code, title: $title, detail: $detail";
  }
}
