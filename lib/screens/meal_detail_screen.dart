import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetail extends StatelessWidget {
  static const routeName = 'meal_detail';
  final Function toggleFavorite;
  final Function isMealFavorite;

  const MealDetail(this.toggleFavorite,this.isMealFavorite,);


  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final MealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeeal = DUMMY_MEALS.firstWhere((meal) => meal.id == MealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Text(selectedMeeal.ingredients[index]),
                  ),
                ),
                itemCount: selectedMeeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, "Steps"),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text("# ${index + 1}"),
                      ),
                      title: Text(selectedMeeal.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedMeeal.ingredients.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() => toggleFavorite(MealId),
        child: Icon(
          isMealFavorite(MealId) ? Icons.star :Icons.star_border,
        ),
      ),
    );
  }
}
