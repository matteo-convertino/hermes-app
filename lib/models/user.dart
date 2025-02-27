import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id = 0;

  int userId;
  String firstName;
  String? lastName;
  String phoneNumber;
  String? photo;
  String jwt;

  User({
    required this.userId,
    required this.firstName,
    this.lastName,
    required this.phoneNumber,
    this.photo,
    required this.jwt,
  });

  @override
  String toString() {
    return '{'
        'id: $id, '
        'userId: $userId, '
        'firstName: $firstName, '
        'lastName: $lastName, '
        'phoneNumber: $phoneNumber, '
        'photo: $photo, '
        'jwt: $jwt'
        '}';
  }
}
