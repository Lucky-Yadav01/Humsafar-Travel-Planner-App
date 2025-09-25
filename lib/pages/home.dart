import 'package:flutter/material.dart';
import '../pages/app_theme.dart';
import '../place_details/place_info.dart';
import '../pages/bookmark_page.dart';
import '../pages/my_trips_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = ['Suggested', 'Cities', 'Mountains', 'Beach'];
  int selectedCategory = 0;
  String searchQuery = '';

  final Map<String, List<Place>> placeData = {
    'Suggested': [
      Place(
        imageUrl: 'assets/images/goa.jpg',
        title: 'Hidden Paradise',
        location: 'Goa, India',
        rating: 4.5,
        tags: ['Beach', 'Relax'],
      ),
      Place(
        imageUrl: 'assets/images/mumbai.jpg',
        title: 'Mumbai City',
        location: 'Maharashtra, India',
        rating: 4.2,
        tags: ['Urban', 'Nightlife'],
      ),
      Place(
        imageUrl: 'assets/images/manali.jpg',
        title: 'Snowy Peaks',
        location: 'Manali, India',
        rating: 4.8,
        tags: ['Adventure', 'Snow'],
      ),
      Place(
        imageUrl: 'assets/images/kerala.jpg',
        title: 'Sunny Shores',
        location: 'Kerala, India',
        rating: 4.6,
        tags: ['Sea', 'Sun'],
      ),
    ],
    'Cities': [
      Place(
        imageUrl: 'assets/images/mumbai.jpg',
        title: 'Mumbai City',
        location: 'Maharashtra, India',
        rating: 4.2,
        tags: ['Urban', 'Nightlife'],
      ),
      Place(
        imageUrl: 'assets/images/jaipur.jpg',
        title: 'Pink City',
        location: 'Jaipur, Rajasthan',
        rating: 4.3,
        tags: ['Palaces', 'Tradition'],
      ),
      Place(
        imageUrl: 'assets/images/pune.jpg',
        title: 'Pune City',
        location: 'Maharashtra, India',
        rating: 4.0,
        tags: ['Tech', 'Youthful'],
      ),
    ],
    'Mountains': [
      Place(
        imageUrl: 'assets/images/manali.jpg',
        title: 'Snowy Peaks',
        location: 'Manali, India',
        rating: 4.8,
        tags: ['Adventure', 'Snow'],
      ),
      Place(
        imageUrl: 'assets/images/leh_ladakh.jpg',
        title: 'Leh Ladakh',
        location: 'Ladakh, India',
        rating: 4.9,
        tags: ['Scenic', 'Bike Trips'],
      ),
      Place(
        imageUrl: 'assets/images/shimla.jpg',
        title: 'Queen of Hills',
        location: 'Shimla, Himachal Pradesh',
        rating: 4.5,
        tags: ['Snowfall', 'Toy Train'],
      ),
    ],
    'Beach': [
      Place(
        imageUrl: 'assets/images/goa.jpg',
        title: 'Sunny Shores',
        location: 'Kerala, India',
        rating: 4.6,
        tags: ['Sea', 'Sun'],
      ),
      Place(
        imageUrl: 'assets/images/gokarna.jpg',
        title: 'Serene Sands',
        location: 'Gokarna, Karnataka',
        rating: 4.5,
        tags: ['Peaceful', 'Trekking'],
      ),
      Place(
        imageUrl: 'assets/images/andaman.jpg',
        title: 'Island Escape',
        location: 'Andaman & Nicobar Islands',
        rating: 4.9,
        tags: ['Diving', 'Islands'],
      ),
    ],
  };

  void onTagTap(String tag) {
    setState(() => searchQuery = tag);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final filteredPlaces = placeData[categories[selectedCategory]]!
        .where((place) => place.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover\nnew places',
                    style: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.0000001),
                    child: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (value) {
                        if (value == 'Bookmarks') {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const BookmarkPage()));
                        } else if (value == 'PastTrips') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const MyTripsPage(showPast: true)),
                          );
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'Bookmarks', child: Text('Bookmarks')),
                        const PopupMenuItem(value: 'PastTrips', child: Text('Past Trips')),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.03),

              // Search bar
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.015),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: Offset(0, 4))],
                ),
                child: TextField(
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
                    hintText: 'Search destinations...',
                    hintStyle: TextStyle(fontSize: screenWidth * 0.045, color: Colors.grey[600]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[800]),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.black),
                ),
              ),

              SizedBox(height: screenHeight * 0.025),

              // Category chips
              SizedBox(
                height: screenHeight * 0.05,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = index),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
                        margin: EdgeInsets.only(right: screenWidth * 0.03),
                        decoration: BoxDecoration(
                          color: selectedCategory == index ? AppTheme.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: selectedCategory == index ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: screenHeight * 0.025),

              // Places list
              Expanded(
                child: ListView.builder(
                  itemCount: filteredPlaces.length,
                  itemBuilder: (context, index) {
                    final place = filteredPlaces[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => PlaceInfoPage(place: place)),
                        );
                      },
                      child: PlaceCard(place: place, onTagTap: onTagTap),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final Place place;
  final Function(String tag) onTagTap;

  const PlaceCard({super.key, required this.place, required this.onTagTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              place.imageUrl,
              height: screenHeight * 0.25,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.title, style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(place.location, style: TextStyle(color: Colors.grey[700], fontSize: screenWidth * 0.04)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 18),
                    const SizedBox(width: 4),
                    Text('${place.rating}'),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: place.tags.map((tag) {
                    return GestureDetector(
                      onTap: () => onTagTap(tag),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(tag, style: TextStyle(color: Colors.grey[700], fontSize: screenWidth * 0.04)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
