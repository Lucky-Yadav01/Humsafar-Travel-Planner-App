import 'package:flutter/material.dart';
import '../pages/app_theme.dart';
import 'restaurant_detail_page.dart';

// ─── Model ───────────────────────────────────────────────────────────────
class Restaurant {
  final String img;
  final String name;
  final String area;
  final String price; // e.g. “Very Expensive”
  final double rating;

  const Restaurant({
    required this.img,
    required this.name,
    required this.area,
    required this.price,
    required this.rating,
  });
}

// dummy data
const restaurants = [
  Restaurant(
    img: 'assets/images/rest1.jpg',
    name: 'Smakrik Fusion',
    area: 'Gamla Stan',
    price: '\$\$\$',
    rating: 9.2,
  ),
  Restaurant(
    img: 'assets/images/rest2.jpg',
    name: 'Stadsgrönska',
    area: 'Södermalm',
    price: '\$\$',
    rating: 9.0,
  ),
  Restaurant(
    img: 'assets/images/rest3.jpg',
    name: 'Gastronomisk Oas',
    area: 'Östermalm',
    price: '\$\$\$\$',
    rating: 9.5,
  ),
  Restaurant(
    img: 'assets/images/rest4.jpg',
    name: 'Förenade Smaker',
    area: 'Norrmalm',
    price: '\$\$',
    rating: 8.8,
  ),
  Restaurant(
    img: 'assets/images/rest5.jpg',
    name: 'SNACK!',
    area: 'Gamla Stan',
    price: '\$',
    rating: 8.6,
  ),
];

class RestaurantPlanningPage extends StatelessWidget {
  const RestaurantPlanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Restaurants'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppTheme.primary,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
        itemCount: restaurants.length,
        itemBuilder: (context, i) {
          final r = restaurants[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(r.img, width: 55, height: 55, fit: BoxFit.cover),
              ),
              title: Text(r.name, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(r.area),
              trailing: IconButton(
                style:
                    IconButton.styleFrom(backgroundColor: AppTheme.primary, shape: const CircleBorder()),
                icon: const Icon(Icons.arrow_forward, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RestaurantDetailPage(restaurant: r)),
                  );
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () {},
          child: const Text('Load more'),
        ),
      ),
    );
  }
}
