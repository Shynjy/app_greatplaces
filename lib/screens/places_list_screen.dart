import 'package:app_greatplaces/providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Rotas
import '../utils/app_routes.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lugares'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
          ),
        ],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting 
        ? Center( child: CircularProgressIndicator(),)
        : Consumer<GreatPlaces>(
          child: Center(
            child: Text('Nenhum local cadastrado!'),
          ),
          builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0
              ? ch
              : ListView.builder(
                  itemCount: greatPlaces.itemsCount,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          greatPlaces.itemByIndex(index).image
                        ),
                      ),
                      title: Text(greatPlaces.itemByIndex(index).title),
                      onTap: () {},
                    );
                  },
                ),
        ),
      ),
    );
  }
}
