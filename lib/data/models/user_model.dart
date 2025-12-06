class UserModel {
  final int id;
  final String email;
  final String location;
  final String name;

  UserModel({
    required this.id,
    required this.email,
    required this.location,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['id'],
      email: jsonData['email'],
      location: jsonData['location'],
      name: jsonData['name'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "id": id,
      "email": email,
      "location": location,
      "name": name,
    };
  }

}
