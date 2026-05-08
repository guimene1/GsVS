import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'models/user_model.dart';

class AuthService {
  static const _baseUrl = 'http://localhost:8000/api';
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'jwt_token';

  Future<UserModel> login(String credential, String password) async {
  final response = await http.post(
    Uri.parse('$_baseUrl/auth/login'),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    body: jsonEncode({'credential': credential, 'password': password}),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode (response.body) as Map<String, dynamic>;
    await _storage.write(key: _tokenKey, value: data['token'] as String);
    return UserModel.fromJson(data['user'] as Map<String, dynamic>);
  }
  final error = jsonDecode(response.body)['message'] ?? 'Erro ao fazer login';
  throw Exception(error);

  }

  Future<void> logout() async{
    final token = await _storage.read(key: _tokenKey);
    if (token != null) {
      await http.post(
        Uri.parse('$_baseUrl/auth/logout'),
        headers: _authHeaders(token),);

    }
    await _storage.delete(key: _tokenKey);
  }

  Future<bool> get isLoggedIn async =>
  (await _storage.read(key: _tokenKey)) != null;
  Future <String?> get token async => _storage.read(key: _tokenKey);

  static Map <String, String> _authHeaders(String token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  Future <Map<String, String>> get authHeaders async {
    final t = await token;
    if (t == null) throw Exception('Usuário não autenticado.');
    return _authHeaders(t);
  }
}
