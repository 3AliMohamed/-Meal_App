import 'package:flutter/material.dart';
import '../screens/category_meals_screens.dart';

class Category_Item extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  Category_Item(
    this.id,
    this.title,
    this.color,
  );

  void selectScreen(BuildContext ctx)
  {
      Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName,
      arguments: {
        'id':id,
        'title':title,
      },
      );
  }
  @override
  Widget build(BuildContext context) {
    return InkWell( 
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).primaryColor,
      onTap: () => selectScreen(context),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(title,style: Theme.of(context).textTheme.title,), 
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.4),
              color,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ), 
          borderRadius: BorderRadius.circular(15)
        ),
      ),
    );
  }
}
