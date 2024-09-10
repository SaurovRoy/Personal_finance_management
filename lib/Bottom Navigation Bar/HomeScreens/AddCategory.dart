import 'package:flutter/material.dart';
import 'package:personal_finance_management/Const/AppIcon.dart';

class AddCategory extends StatelessWidget {
  String? categoryType;
  // final ValueChanged<String> onChanged;
  final ValueChanged<Map<String, dynamic>> onChanged;
  AddCategory({super.key,required this.categoryType,required this.onChanged});

  @override
  Widget build(BuildContext context) {

    final incomeCategories = AppCIcon().Categories;

    return DropdownButtonFormField(
      items: incomeCategories.map((category) {
        return DropdownMenuItem(
          value: category['name'],
          child: Row(
            children: [
              Icon(category['icon']),
              SizedBox(width: 10),
              Text(category['name']),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          final selectedCategory = incomeCategories.firstWhere(
                  (category) => category['name'] == value);
          onChanged({
            'name': selectedCategory['name'],
            'icon': selectedCategory['icon'].codePoint,
          });
        }
        print(value);  // Selected category
      },
      decoration: InputDecoration(
        labelText: 'Select Income Category',
      ),
    );
  }
}
