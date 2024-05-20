import 'package:adasae/models/data_api.dart';
// import 'package:adasae/view/fav_page.dart';
// import 'package:adasae/view_model/plants_view_model.dart';
// import 'package:adasae/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Data plantData;

  const DetailScreen({super.key, required this.plantData});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;
  List<int> favoritePlants = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favorite_plants') ?? [];
    setState(() {
      favoritePlants = favoriteIds.map(int.parse).toList();
      isFavorite = favoritePlants.contains(1); // ID tanaman favorit
    });
  }

  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds =
        favoritePlants.map((id) => id.toString()).toList();
    await prefs.setStringList('favorite_plants', favoriteIds);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    String family = widget.plantData.family.toString();
    String genus = widget.plantData.genus.toString();
    String sciName = widget.plantData.scientificName.toString();

    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Adasae',
              style: GoogleFonts.outfit(
                  color: Colors.lightGreen.shade900,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                  if (isFavorite &&
                      !favoritePlants.contains(widget.plantData.id as int)) {
                    favoritePlants.add(widget.plantData.id
                        as int); // Pastikan bahwa id merupakan tipe int
                  } else if (!isFavorite &&
                      favoritePlants.contains(widget.plantData.id as int)) {
                    favoritePlants.remove(widget.plantData.id
                        as int); // Pastikan bahwa id merupakan tipe int
                  }
                  saveFavorites();
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.00,
            ),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      height: height * 0.6,
                      width: width,
                      child: CachedNetworkImage(
                        imageUrl: widget.plantData.imageUrl != null
                            ? widget.plantData.imageUrl.toString()
                            : 'https://via.placeholder.com/1000?text=No+Image+Available',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SpinKitPulse(
                          size: 50,
                          color: Colors.lightGreen.shade600,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error_outline, color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text(
                          widget.plantData.commonName != null
                              ? widget.plantData.commonName.toString()
                              : widget.plantData.scientificName.toString(),
                          style: GoogleFonts.outfit(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )),
                  SizedBox(
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text(
                          '$family  >  $genus  >  $sciName',
                          style: GoogleFonts.outfit(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    width: width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Year',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.025,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ':  ',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.63,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.plantData.year.toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Author',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.025,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ':  ',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.63,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.plantData.author.toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bibliography',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.025,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ':  ',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.63,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.plantData.bibliography.toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rank',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.025,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ':  ',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.63,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.plantData.rank.toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Synonyms',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.025,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ':  ',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.63,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.plantData.synonyms.toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 300,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ));
  }
}
