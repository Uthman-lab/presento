import 'package:presento/modules/auth/domain/domain.dart';

void main() {
  // Test if User class is accessible
  final user = User(
    id: 'test',
    email: 'test@test.com',
    name: 'Test User',
    roles: {},
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  print('User created: ${user.email}');
}
