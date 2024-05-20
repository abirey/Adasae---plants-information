import 'package:adasae/view/fav_page.dart';
import 'package:adasae/view/home_screen.dart';
import 'package:adasae/widgets/custom_navbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adasae/models/data_api.dart';
import 'package:adasae/view/detail_page.dart';
import 'package:adasae/view_model/plants_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchPlantScreen extends StatefulWidget {
  const SearchPlantScreen({super.key});

  @override
  State<SearchPlantScreen> createState() => _SearchPlantScreenState();
}

class _SearchPlantScreenState extends State<SearchPlantScreen> {
  PlantsViewModel plantsViewModel = PlantsViewModel();
  final TextEditingController _searchController = TextEditingController();
  List<Data> _searchResult = [];
  bool _isLoading = false;
  int _currentIndex = 1;

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
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoritePage()),
        );
        break;
      // Tambahkan case untuk setiap menu navbar lainnya
    }
  }

  void _searchPlant(String query) async {
    setState(() {
      _isLoading = true;
      _searchResult.clear();
    });

    try {
      List<Data> result = await plantsViewModel.searchPlant(query);
      setState(() {
        _searchResult = result;
        _isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error searching plant: $e');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Plant',
          style: GoogleFonts.outfit(
              color: Colors.lightGreen.shade900, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox( width: width * .97,child:
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              // cursorColor: Colors.lightGreen.shade600,
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search plant...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    String query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      _searchPlant(query);
                    }
                  },
                ),
              ),
            ),
          ),),
          _isLoading
              ? Center(
                  child: SpinKitPulse(
                    size: 50,
                    color: Colors.lightGreen.shade600,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: _searchResult[index].imageUrl != null ? _searchResult[index].imageUrl.toString() :
                              'https://via.placeholder.com/150?text=No+Image+Available', // URL gambar dari API atau placeholder jika tidak ada URL
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(), // Widget placeholder ketika gambar sedang dimuat
                          errorWidget: (context, url, error) => const Icon(Icons
                              .error), // Widget yang ditampilkan jika ada error dalam memuat gambar
                          width: 40, // Set lebar gambar
                          height: 40, // Set tinggi gambar
                          fit:
                              BoxFit.cover, // Atur bagaimana gambar ditampilkan
                        ),
                        title: Text(
                          _searchResult[index].commonName ??
                              _searchResult[index].scientificName.toString(),
                          style: GoogleFonts.outfit(
                            // fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          _searchResult[index].scientificName.toString(),
                          style: GoogleFonts.outfit(),
                        ),

                        // subtitle: Text(_searchResult[index].synonyms != null &&
                        //         _searchResult[index].synonyms!.isNotEmpty
                        //     ? _searchResult[index].synonyms![0]
                        //     : 'No synonyms'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                plantData: _searchResult[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }
}
