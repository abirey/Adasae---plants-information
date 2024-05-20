import 'package:adasae/models/data_api.dart';
import 'package:adasae/view/search_plant_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adasae/view/detail_page.dart';
import 'package:adasae/view/fav_page.dart';
import 'package:adasae/view_model/plants_view_model.dart';
import 'package:adasae/widgets/custom_navbar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlantsViewModel plantsViewModel = PlantsViewModel();
  int _currentIndex = 0;
  int _currentPage = 1;
  // int _totalPages = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        break; // Do nothing, already on the HomeScreen
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SearchPlantScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoritePage()),
        );
        break;
      // Add cases for other menu items
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final page = _currentPage;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topCenter,
          child: Text(
            '    Adasae',
            style: GoogleFonts.outfit(
                color: Colors.lightGreen.shade900, fontWeight: FontWeight.bold),
          ),
        ),
         
        leading: const Icon(Icons.line_axis, color: Color.fromARGB(0, 255, 214, 64),),

        actions: [
          Builder(
            builder: (context) => TextButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Text(
                ' $page',
                style: GoogleFonts.outfit(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      // endDrawerEnableOpenDragGesture: true,
      endDrawer: Drawer(
        width: width * .5,
        child: ListView.builder(
          itemCount: 21863, // Total pages + header
          itemBuilder: (context, index) {
            if (index == 0) {
              return SizedBox(
                height: 65,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen.shade800,
                  ),
                  child: Text(
                    'Pages',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
            return ListTile(
              title: Text('Page $index'),
              onTap: () {
                setState(() {
                  _currentPage = index;
                });
                Navigator.pop(context); // Tutup sidebar
                _fetchNewPlantTitleApi();
              },
            );
          },
        ),
      ),
      body: FutureBuilder<List<Data>>(
        future: plantsViewModel.fetchNewPlantTitleApi(_currentPage),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitPulse(
                size: 50,
                color: Colors.lightGreen.shade600,
              ),
            );
          } else {
            return PageView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.00,
                  ),
                  child: SizedBox(
                    height: height * 0.8,
                    width: width * 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            height: height * 0.6,
                            width: width,
                            child: CachedNetworkImage(
                              imageUrl:
                                  snapshot.data![index].imageUrl != null ? snapshot.data![index].imageUrl.toString() : 'https://via.placeholder.com/1000?text=No+Image+Available',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => SpinKitPulse(
                                size: 50,
                                color: Colors.lightGreen.shade600,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                  Icons.error_outline,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: width * 3 / 5,
                                  child: Text(
                                    snapshot.data![index].commonName != null
                                        ? snapshot.data![index].commonName
                                            .toString()
                                        : snapshot.data![index].scientificName
                                            .toString(),
                                    style: GoogleFonts.outfit(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 3 / 5,
                                  child: Text(
                                    snapshot.data![index].scientificName
                                        .toString(),
                                    style: GoogleFonts.outfit(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            plantData: snapshot.data![index],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.info,
                                      color: Colors.black,
                                    ),
                                    label: const Text(
                                      'Details',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.lightGreen.shade50),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * .010,
                        ),
                      ],
                    ),
                  ),
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

  Future<void> _fetchNewPlantTitleApi() async {
    try {
      await plantsViewModel.fetchNewPlantTitleApi(_currentPage);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching new plant titles: $e');
      }
    }
  }
}
