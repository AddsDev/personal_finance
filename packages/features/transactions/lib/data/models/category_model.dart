import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.iconKey,
    required super.colorValue,
    required super.type,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json, String id) {
    return CategoryModel(
      id: id,
      name: json['name'] as String,
      iconKey: json['iconKey'] as String,
      colorValue: json['colorValue'] as int,
      type: TransactionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TransactionType.expense,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'iconKey': iconKey,
      'colorValue': colorValue,
      'type': type.name,
    };
  }
}
