import 'package:max_cours_shop_app/model/user_model.dart';
import 'package:max_cours_shop_app/providers/auth_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUser extends Mock implements UserModel{}

final MockUser user = MockUser();

class MockAuthProvider extends Mock implements AuthProvider{}

void main() {
  final auth = MockAuthProvider();

  // test('login success',(){
  //   when(auth.authenticate('hamza@gmail.com', '1234567','','','accounts:signInWithPassword')).thenAnswer((realInvocation) => null);
  //   expect(, matcher)
  // });
}

