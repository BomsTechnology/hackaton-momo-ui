class User {
  final int id;
  final String name;
  final String phone;
  final String type;
  final String amountNoPin;
  final bool noPin;
  final bool withBiomrtric;

  User(
    this.id,
    this.name,
    this.phone,
    this.type,
    this.amountNoPin,
    this.noPin,
    this.withBiomrtric,
  );

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        phone = json['phone'],
        type = json['type'],
        amountNoPin = json['amountNoPin'],
        noPin = json['noPin'],
        withBiomrtric = json['withBiomrtric'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'type': type,
        'withBiomrtric': withBiomrtric,
        'noPin': noPin,
        'amountNoPin': amountNoPin,
      };
}
