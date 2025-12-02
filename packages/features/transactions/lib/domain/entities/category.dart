import 'package:equatable/equatable.dart';

enum TransactionType { income, expense }

class Category extends Equatable {
  final String id;
  final String name;
  final String iconKey;
  final int colorValue; // Color 0xFF...
  final TransactionType type;

  const Category({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.colorValue,
    required this.type,
  });

  @override
  List<Object?> get props => [id, name, iconKey, colorValue, type];

  static const empty = Category(
    id: '',
    name: '',
    iconKey: 'help',
    colorValue: 0xFF9E9E9E,
    type: TransactionType.expense,
  );
}
