/// Modelo de usuário — espelha o retorno da API Laravel
/// POST /api/auth/login → { user: UserModel, token: string }
class UserModel {
  final int id;
  final String name;
  final String cpf;
  final String email;
  final String phone;
  final UserRole role;
  final String administrativeUnit;
  final String? avatarUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.cpf,
    required this.email,
    required this.phone,
    required this.role,
    required this.administrativeUnit,
    this.avatarUrl,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first.substring(0, 2).toUpperCase();
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int,
        name: json['name'] as String,
        cpf: json['cpf'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        role: UserRole.fromString(json['role'] as String),
        administrativeUnit: json['administrative_unit'] as String,
        avatarUrl: json['avatar_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cpf': cpf,
        'email': email,
        'phone': phone,
        'role': role.value,
        'administrative_unit': administrativeUnit,
        'avatar_url': avatarUrl,
      };

  /// Stub para desenvolvimento sem backend
  static UserModel get stub => const UserModel(
        id: 1,
        name: 'Administrador',
        cpf: '000.000.000-00',
        email: 'admin@prudentopolis.pr.gov.br',
        phone: '(42) 99999-0000',
        role: UserRole.admin,
        administrativeUnit: 'TI / Sistemas',
      );
}

/// Perfis de acesso — RF02
enum UserRole {
  servidor('servidor', 'Servidor'),
  chefeImediato('chefe_imediato', 'Chefe Imediato'),
  secretario('secretario', 'Secretário'),
  financeiro('financeiro', 'Financeiro'),
  admin('admin', 'Administrador');

  const UserRole(this.value, this.label);
  final String value;
  final String label;

  static UserRole fromString(String value) =>
      UserRole.values.firstWhere((r) => r.value == value,
          orElse: () => UserRole.servidor);
}
