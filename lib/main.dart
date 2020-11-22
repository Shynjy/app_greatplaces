import 'package:app_greatplaces/providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Rotas
import './utils/app_routes.dart';

// Screens
import './screens/places_list_screen.dart';
import './screens/place_form_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        // home: PlacesListScreen(),
        initialRoute: AppRoutes.PLACES_LIST,
        routes: {
          AppRoutes.PLACES_LIST: (ctx) => PlacesListScreen(),
          AppRoutes.PLACE_FORM: (ctx) => PlaceFormScreen(),
        },
      ),
    );
  }
}
