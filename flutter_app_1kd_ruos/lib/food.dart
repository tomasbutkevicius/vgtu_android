class Food{
    final String name;

  Food({required this.name});

  static Food fromJson(Map<String, dynamic> json) => Food(
    name: json['name'],
  );

}