/***
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dashboard_stats_model.dart';
import '../services/auth_service.dart';

abstract class DashboardRepository {
  Future<DashboardStatsModel> getStats({required int year});
}

class DashboardRepositoryImpl implements DashboardRepository {
  static const _baseUrl = 'http://10.0.2.2:8000/api';
  final _auth = AuthService();

  @override
  Future<DashboardStatsModel> getStats({required int year}) async {
    final headers = await _auth.authHeaders;
    final response = await http.get(
      Uri.parse('$_baseUrl/dashboard/stats?year=$year'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return DashboardStatsModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    // Fallback para stub durante desenvolvimento
    return DashboardStatsModel.stub;
  }
}
**/