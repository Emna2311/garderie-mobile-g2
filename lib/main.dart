
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ma Garderie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// Ecran de bienvenue
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Passage a la page d'accueil apres 3 secondes
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image de la garderie
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/garderie.png',
                width: 220,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.child_care,
                    size: 100,
                    color: Colors.pink,
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Ma Garderie',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Bienvenue dans notre garderie',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// Page d'accueil
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menus = [
      {
        'titre': 'Petit déjeuner',
        'description': 'Lait, céréales et fruits',
        'emoji': '🥣',
      },
      {
        'titre': 'Déjeuner',
        'description': 'Poulet, riz et légumes',
        'emoji': '🍲',
      },
      {
        'titre': 'Goûter',
        'description': 'Biscuit et compote de pomme',
        'emoji': '🍪',
      },
      {
        'titre': 'Jus de fruits',
        'description': "Jus d'orange naturel",
        'emoji': '🍊',
      },
      {
        'titre': 'Fruits frais',
        'description': 'Une sélection de fruits de saison',
        'emoji': '🍎',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Garderie'),
        backgroundColor: Colors.pink.shade100,
        actions: [
          // Bouton de recherche
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showMessage(context, 'Rechercher un menu');
            },
          ),

          // Bouton de notifications
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              showMessage(context, 'Aucune notification');
            },
          ),
        ],
      ),

      // Menu lateral
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              child: Center(
                child: Text(
                  'Ma Garderie',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text('Menus'),
              onTap: () {
                Navigator.pop(context);
                showMessage(context, 'Menus du jour');
              },
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('À propos'),
              onTap: () {
                Navigator.pop(context);
                showMessage(context, 'Ma Garderie');
              },
            ),
          ],
        ),
      ),

      // Liste des menus
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Menus du jour',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          for (final menu in menus)
            Card(
              child: ListTile(
                leading: Text(
                  menu['emoji']!,
                  style: const TextStyle(fontSize: 30),
                ),
                title: Text(menu['titre']!),
                subtitle: Text(menu['description']!),
                onTap: () {
                  showMessage(context, menu['titre']!);
                },
              ),
            ),
        ],
      ),

      // Bouton d'ajout
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMessage(context, 'Ajouter un menu');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

