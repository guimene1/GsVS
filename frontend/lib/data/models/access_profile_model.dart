class SystemModuleModel {
    final int id;
    final String key;
    final String label;
    final String route;
    final String? icon;
    final int order;

    const SystemModuleModel({
      required this.id,
      required this.key,
      required this.label,
      required this.route,
      this.icon,
      required this.order,
    });

    factory SystemModuleModel.fromJson(Map<String, dynamic> json) => SystemModuleModel(
          id: json['id'] as int,
          key: json['key'] as String,
          label: json['label'] as String,
          route: json['route'] as String,
          icon: json['icon'] as String?,
          order: json['order'] as int,
        );

    Map<String, dynamic> toJson() => {
          'id': id,
          'key': key,
          'label': label,
          'route': route,
          'icon': icon,
          'order': order,
        };
}

class AccessProfileModel {
    final int id;
    final String name;
    final String? description;
    final bool isActive;
    final List<SystemModuleModel> modules;

    const AccessProfileModel({
      required this.id,
      required this.name,
      this.description,
      required this.isActive,
      required this.modules,
    });

    factory AccessProfileModel.fromJson(Map<String, dynamic> json) => AccessProfileModel(
          id: json['id'] as int,
          name: json['name'] as String,
          description: json['description'] as String?,
          isActive: json['is_active'] as bool,
          modules: (json['modules'] as List<dynamic>? ?? []) 
              .map((e) => SystemModuleModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

    Map<String, dynamic> toJson() => {
          'id': id,
          'name': name,
          'description': description,
          'is_active': isActive,
          'modules': modules.map((e) => e.toJson()).toList(),
        };

        AccessProfileModel copyWith({
          int? id,
          String? name,
          String? description,
          bool? isActive,
          List<SystemModuleModel>? modules,
        }) {
          return AccessProfileModel(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            isActive: isActive ?? this.isActive,
            modules: modules ?? this.modules,
          );
        }

}