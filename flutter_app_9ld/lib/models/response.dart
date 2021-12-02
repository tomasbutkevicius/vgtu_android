class ResponseModel {
  final String original;
  final String md5;

  ResponseModel({
    required this.original,
    required this.md5,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      original: json['original'],
      md5: json['md5'],
    );
  }

  Map<String, dynamic> toJson() => {
    'original': original,
    'md5': md5,
  };
}