import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import '../../../domain/entities/category.dart';

class CategorySelector extends StatelessWidget {
  final List<Category> categories;
  final Category? selectedCategory;
  final ValueChanged<Category> onSelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Center(child: Text('Cargando categorías...'));
    }

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory?.id == category.id;

          final iconData = _mapIconData(category.iconKey);

          return GestureDetector(
            onTap: () => onSelected(category),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? Color(category.colorValue)
                            : context.theme.cardColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          isSelected
                              ? Colors.transparent
                              : context.theme.dividerColor,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    iconData,
                    color:
                        isSelected
                            ? Colors.white
                            : context.theme.iconTheme.color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color:
                        isSelected
                            ? context.theme.colorScheme.onSurface
                            : context.theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _mapIconData(String key) {
    switch (key) {
      case 'fastfood':
        return Icons.fastfood;
      case 'work':
        return Icons.work;
      case 'directions_car':
        return Icons.directions_car;
      case 'home':
        return Icons.home;
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'movie':
        return Icons.movie;
      case 'health_and_safety':
        return Icons.health_and_safety;
      default:
        return Icons.category;
    }
  }
}
