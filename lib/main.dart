import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import './dummy_data.dart';
import 'package:meal_app/models/category.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tab_screen.dart';
import 'package:meal_app/widgets/meal_item.dart';
import './screens/category_meals_screens.dart';
import './screens/category_screen.dart';
import './screens/meal_detail_screen.dart';
void main() =>  runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool>_filters={
    'gluten':false,
    'lactose': false,
    'vegan':false,
    'vegetarian':false,
  };
  List <Meal> _availableMeals=DUMMY_MEALS;
  List <Meal> _favoriteMeals=[];
  void setfilter(Map<String,bool>_filterDta){
    setState(() {
      _filters=_filterDta;
      _availableMeals=DUMMY_MEALS.where((meal){
        if(_filters['gluten'] && ! meal.isGlutenFree){
          return false ;
        }
        if(_filters['lactose'] && ! meal.isLactoseFree){
          return false ;
        }
        if(_filters['vegan'] && ! meal.isVegan){
          return false ;
        }
        if(_filters['vegetarian'] && ! meal.isVegetarian){
          return false ;
        }
        return true;
      }).toList();
    });
  }
  void _toggleFavorite(String id){
    final existingindex = _favoriteMeals.indexWhere((meal) => meal.id==id);

    if(existingindex>=0){
      setState(() {
        _favoriteMeals.removeAt(existingindex);
      });
    }
    else
      {
        setState(() {
          _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==id));
        });
      }
  }
  bool _isMealFavorite(String id)
  {
    return _favoriteMeals.any((meal) => meal.id==id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255,254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            color: Color.fromRGBO(20, 50, 50, 1),
          ),
          body2: TextStyle(
            color: Color.fromRGBO(20, 50, 50, 1),
          ),
          title: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed' ,
            fontWeight: FontWeight.bold,
          )
        )
      ),
      //home:Category_Screen(),
      //MyHomePage(),
      routes: {
        '/':(context)=> TabScreen(_favoriteMeals),
        CategoryMealsScreen.routeName:(context) => CategoryMealsScreen(_availableMeals),
        MealDetail.routeName:(context)=>MealDetail(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName:(context) => FiltersScreen(setfilter,_filters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal App"),
      ),
      body: null
      );
  }
}
