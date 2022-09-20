class User {
  final int id;
  final String name;
  final String phone;
  final String type;

  User(
    this.id,
    this.name,
    this.phone,
    this.type,
  );

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        phone = json['phone'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'type': type,
      };
}
