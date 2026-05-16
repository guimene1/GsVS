import 'dart:convert';

import 'package:frontend/data/auth_service.dart';
import 'package:frontend/data/models/access_profile_model.dart';
import 'package:http/http.dart' as http;

abstract class AccessProfileRepository {
  Future<List<AccessProfileModel>> getAll();
  Future<List<SystemModuleModel>> getAllModules();
  Future<AccessProfileModel> create(AccessProfileModel profile);
  Future<AccessProfileModel> update(AccessProfileModel profile);
  Future<void> delete(int id);
  Future<bool> toggleActive(int id);
}

class AccessProfileRepositoryImpl implements AccessProfileRepository {
  static const String _baseUrl = 'http://localhost:8000/api';
  final _auth = AuthService();

  @override
  Future<List<AccessProfileModel>> getAll() async {
    final headers = await _auth.authHeaders;
    final response = await http.get(
      Uri.parse('$_baseUrl/access-profiles'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((e) => AccessProfileModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load access profiles');
    }
  }

  Future<List<SystemModuleModel>> getAllModules() async {
    final headers = await _auth.authHeaders;
    final response = await http.get(
      Uri.parse('$_baseUrl/access-profiles/modules'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((e) => SystemModuleModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load system modules');
    }
  }

  Future<AccessProfileModel> create(AccessProfileModel profile) async {
    final headers = await _auth.authHeaders;
    final response = await http.post(
      Uri.parse('$_baseUrl/access-profiles'),
      headers: headers,
      body: jsonEncode(profile.toJson()),
    );
    if (response.statusCode == 201) {
      return AccessProfileModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to create access profile');
    }
  }

  Future<AccessProfileModel> update(AccessProfileModel profile) async {
    final headers = await _auth.authHeaders;
    final response = await http.put(
      Uri.parse('$_baseUrl/access-profiles/${profile.id}'),
      headers: headers,
      body: jsonEncode(profile.toJson()),
    );
    if (response.statusCode == 200) {
      return AccessProfileModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to update access profile');
    }
  }

  Future<void> delete(int id) async {
    final headers = await _auth.authHeaders;
    final response = await http.delete(
      Uri.parse('$_baseUrl/access-profiles/$id'),
      headers: headers,
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar perfil de acesso');
    }
  }

  Future<bool> toggleActive(int id) async {
    final headers = await _auth.authHeaders;
    final response = await http.patch(
      Uri.parse('$_baseUrl/access-profiles/$id/toggle-active'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['is_active'] as bool;
    } else {
      throw Exception('Failed to toggle active status');
    }
  }
}
