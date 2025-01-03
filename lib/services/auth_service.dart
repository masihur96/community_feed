class AuthService {
  Future<void> login(String email, String password) async {
    // Mock login implementation
    await Future.delayed(Duration(seconds: 1));
    if (email == 'test@test.com' && password == 'password') {
      return;
    } else {
      throw Exception('Invalid credentials');
    }
  }
}
