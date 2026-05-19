class SubcategoryModel {
  final String id;
  final String name;
  final String? image;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SubcategoryModel({
    required this.id,
    required this.name,
    this.image,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'image': image,
    'isActive': isActive,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}

class CategoryModel {
  final String id;
  final String name;
  final String? image;
  final bool isActive;
  final List<SubcategoryModel> subcategories;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryModel({
    required this.id,
    required this.name,
    this.image,
    required this.isActive,
    required this.subcategories,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final rawSubs = json['subcategories'] as List<dynamic>? ?? [];
    return CategoryModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      subcategories: rawSubs
          .map((e) => SubcategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'image': image,
    'isActive': isActive,
    'subcategories': subcategories.map((s) => s.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
