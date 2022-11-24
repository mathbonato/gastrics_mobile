class Employee {
  String id = '';
  String name = '';
  String lastName = '';
  String type = '';
  String birth = '';
  String cpf = '';
  String email = '';

  Employee(this.id, this.name, this.lastName, this.type, this.birth, this.cpf, this.email);

  factory Employee.fromJson(dynamic json) {
    return Employee(
      json['id'] as String,
      json['name'] as String,
      json['lastName'] as String,
      json['type'] as String,
      json['birth'] as String,
      json['cpf'] as String,
      json['email'] as String,
    );
  }
}