import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';

import '../screens/add_place_screen.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Great Places'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlacesProvider>(
                // child: Center(
                //   child: Text('Add some places bsdk'),
                // ),
                builder: (ctx, places, child) => places.items.length <= 0
                    ? Text('Add some places bsdk')
                    : ListView.builder(
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            maxRadius: 20,
                            backgroundImage: FileImage(places.items[i].image),
                          ),
                          title: Text(places.items[i].title),
                          onTap: () {
                            //GO to detail Page
                          },
                        ),
                        itemCount: places.items.length,
                      ),
              ),
      ),
    );
  }
}
