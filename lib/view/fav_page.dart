import 'package:adasae/models/data_api.dart';
import 'package:adasae/view/home_screen.dart';
import 'package:adasae/view/search_plant_screen.dart';
import 'package:adasae/view_model/plants_view_model.dart';
import 'package:adasae/widgets/custom_navbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  PlantsViewModel plantsViewModel = PlantsViewModel();
  int _currentIndex = 2;
  late Future<List<int>> _favoritePlantsFuture;

  @override
  void initState() {
    super.initState();
    _favoritePlantsFuture = getFavoritePlants();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SearchPlantScreen()),
        );
        break;
      case 2:
        break;
      // Tambahkan case untuk setiap menu navbar lainnya
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Adasae',
            style: GoogleFonts.outfit(
                color: Colors.lightGreen.shade900, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder<List<int>>(
        future: _favoritePlantsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<int> favoritePlants = snapshot.data ?? [];

            // Tampilkan daftar tanaman favorit
            return ListView.builder(
              itemCount: favoritePlants.length,
              itemBuilder: (context, index) {
                // Ambil data tanaman berdasarkan ID dan tampilkan
                return FutureBuilder<Data>(
                  future: plantsViewModel.idPlant(favoritePlants[index]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text('Loading...'),
                      );
                    } else if (snapshot.hasError) {
                      return ListTile(
                        title: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      Data plantData = snapshot.data!;

                      // Tampilkan informasi tanaman favorit berdasarkan ID
                      return ListTile(
                        title: Text(plantData.commonName != null
                            ? plantData.commonName.toString()
                            : plantData.scientificName.toString()),
                        onLongPress: () {
                          setState(() {
                            favoritePlants.remove(favoritePlants[index]);
                            saveFavorites(favoritePlants); // ID tanaman favorit
                          });
                        },
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }

  Future<List<int>> getFavoritePlants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favorite_plants') ?? [];
    return favoriteIds.map(int.parse).toList();
  }

  Future<void> saveFavorites(List<int> favoriteIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIdStrings =
        favoriteIds.map((id) => id.toString()).toList();
    await prefs.setStringList('favorite_plants', favoriteIdStrings);
  }
}
