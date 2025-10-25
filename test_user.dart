
import 'package:presento/modules/auth/domain/domain.dart';

void main() {
  // Test if User class is accessible
  final user = User(
    uid: 'test',
    email: 'test@test.com',
    name: 'Test User',
    roles: {},
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  // Verify user creation
  assert(user.uid == 'test');
  assert(user.email == 'test@test.com');
  assert(user.name == 'Test User');
}
