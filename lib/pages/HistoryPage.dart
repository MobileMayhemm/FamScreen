import 'package:famscreen/pages/HomePage.dart';
import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../components/filter_jenis.dart';
import '../data/models/film.dart';
import '../data/service/film_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistorypageState();
}

class _HistorypageState extends State<HistoryPage> {
  int currentPageIndex = 3;

  List<Film>? films;
  List<Film>? displayedFilms;
  bool isLoaded = false;
  String selectedCategory = 'All';

  void updateCategory(List<Film> filteredFilms) {
    setState(() {
      displayedFilms = filteredFilms;
    });
  }

  @override
  void initState() {
    super.initState();
    loadFilms();
  }

  Future<void> loadFilms() async {
    final filmService = FilmService();
    films = await filmService.getFilms();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Riwayat',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => route.isFirst,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Cari riwayat',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // filter jenis
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CategoryRow(
                  allFilms: films ?? [],
                  selectedCategory: selectedCategory,
                  onCategorySelected: (String category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  onFilteredFilms: updateCategory,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Today',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: (isLoaded && films != null)
                  ? ListView.builder(
                      itemCount: films!.length,
                      itemBuilder: (context, index) {
                        final film = films![index];
                        return GestureDetector(
                          // onTap: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => DetailPage(
                          //           film: film,
                          //           displayedFilms: displayedFilms!),
                          //     ),
                          //   );
                          // },
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        15), // Set the border radius to 15
                                    child: Image.network(
                                      film.posterPotrait,
                                      width: 70,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          film.judul,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              '${film.tahunRilis}  ·  ${film.durasi}  ·  ',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors
                                                  .yellow, // Yellow star icon
                                              size: 16,
                                            ),
                                            Text(
                                              film.rateImdb,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          film.deskripsi,
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}

// class HistoryItem {
//   final String title;
//   final String image;
//   final String description;

//   HistoryItem(
//       {required this.title, required this.image, required this.description});
// }

// class FilterButton extends StatelessWidget {
//   final String label;

//   const FilterButton({Key? key, required this.label}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.amber,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       onPressed: () {
//       },
//       child: Text(
//         label,
//         style: const TextStyle(color: Colors.black),
//       ),
//     );
//   }
// }
