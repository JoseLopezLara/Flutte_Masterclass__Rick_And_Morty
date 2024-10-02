import 'package:flutter/material.dart';
import 'package:masterclass_rick_and_morty_app/presentation/screens/home/characters/character_screen.dart';
import 'package:masterclass_rick_and_morty_app/presentation/screens/home/episodies/episodies_screen.dart';
import 'package:masterclass_rick_and_morty_app/presentation/screens/home/locations/locations_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //LOGICA DE WIDGETS
  //-----------------------------
  int page = 0;
  final pageController = PageController();
  final pages = [
    const CharacterScreen(),
    const EpisodiesScreen(),
    const LocationsScreen()
  ];

  void changePage(int index) => setState(() {
        page = index;
        pageController.jumpToPage(page);
      });

  //END LOGICA DE WIDGETS
  //-----------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title:
            const Text(style: TextStyle(color: Colors.white), 'Rick And Morty'),
        iconTheme: const IconThemeData(
          color: Colors.white, // Cambia el color de la flecha de retroceso aquí
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: PageView(
        onPageChanged: changePage,
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade400,
          backgroundColor: Colors.deepPurple,
          onTap: changePage,
          currentIndex: page,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, color: Colors.white),
                label: 'Characters'),
            BottomNavigationBarItem(
                icon: Icon(Icons.tv_rounded, color: Colors.white),
                label: 'Esposidies'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_city_outlined, color: Colors.white),
                label: 'Locations')
          ]),
    );
  }
}
