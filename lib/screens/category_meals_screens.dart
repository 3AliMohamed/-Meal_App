import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meals';
  final List<Meal> availablemeal;
  CategoryMealsScreen(this.availablemeal);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List <Meal> desplayedMeals;
  @override
  void didChangeDependencies() {
    final routArg =
    ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryId = routArg['id'];
     categoryTitle = routArg['title'];
    desplayedMeals =  widget.availablemeal.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }
  void removeItem(String mealId){
    setState(() {
      desplayedMeals.removeWhere((meal) =>
      meal.id==mealId
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: desplayedMeals[index].id,
            imageUrl: desplayedMeals[index].imageUrl,
            title: desplayedMeals[index].title,
            duration: desplayedMeals[index].duration,
            complexity: desplayedMeals[index].complexity,
            affordability: desplayedMeals[index].affordability,
          );
        },
        itemCount: desplayedMeals.length,
      ),
    );
  }
}
