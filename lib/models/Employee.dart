class Employee {
  String id = '';
  String name = '';
  String lastName = '';
  String type = '';
  DateTime? birth;
  String cpf = '';
  String email = '';
  String? pass = '';

  Employee(this.id, this.name, this.lastName, this.type, this.birth, this.cpf, this.email);

  factory Employee.fromJson(dynamic json) {
    DateTime birth = DateTime.parse(json['birth']);
    
    return Employee(
      json['id'] as String,
      json['name'] as String,
      json['lastName'] as String,
      json['type'] as String,
      birth,
      json['cpf'] as String,
      json['email'] as String,
    );
  }
}