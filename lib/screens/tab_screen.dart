import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import 'category_screen.dart';
import 'favorites_screen.dart';
class TabScreen extends StatefulWidget {
  List <Meal> _favoriteMeals=[];
  TabScreen(this._favoriteMeals);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

   List<Map<String, Object>>_pages;
  int _selectpageindex=0;
  @override
  void initState() {
    _pages=[
      {
        'page' :Category_Screen(),
        'title' :"Categories"
      } ,
      {
        'page' : FavoriteScreen(widget._favoriteMeals),
        'title' : "Your Favorites"
      }
    ];
    super.initState();
  }
  void _selectPge(int value) {
    setState(() {
      _selectpageindex=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectpageindex]['title']),
    ),
    body: _pages[_selectpageindex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPge,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectpageindex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("Categories")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text("Favorites")
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
