import 'package:flutter/material.dart';
import 'package:humsafar_p1/place_details/place_info.dart';
import 'app_theme.dart';

class FeaturedTripsPage extends StatelessWidget {
  FeaturedTripsPage({super.key});

  final List<Place> featuredTrips = [
    Place(
      imageUrl: 'assets/images/vespa.jpg',
      title: 'Vespa Tour',
      location: 'Rome, Italy',
      rating: 4.7,
      tags: ['Scooter', 'City'],
    ),
    Place(
      imageUrl: 'assets/images/yoga.jpg',
      title: 'Yoga Retreat',
      location: 'Bali, Indonesia',
      rating: 4.9,
      tags: ['Wellness', 'Relax'],
    ),
    Place(
      imageUrl: 'assets/images/oktoberfest.jpg',
      title: 'Oktoberfest',
      location: 'Munich, Germany',
      rating: 4.8,
      tags: ['Festival', 'Beer'],
    ),
    Place(
      imageUrl: 'assets/images/brooklyn.jpg',
      title: 'Brooklyn Bridge',
      location: 'New York City, USA',
      rating: 4.6,
      tags: ['Landmark', 'Photography'],
    ),
    Place(
      imageUrl: 'assets/images/santorini.jpg',
      title: 'Santorini Sunset',
      location: 'Santorini, Greece',
      rating: 4.9,
      tags: ['Island', 'Romantic'],
    ),
    Place(
      imageUrl: 'assets/images/tokyo.jpg',
      title: 'Tokyo Lights',
      location: 'Tokyo, Japan',
      rating: 4.8,
      tags: ['Cityscape', 'Culture'],
    ),
    Place(
      imageUrl: 'assets/images/paris.jpg',
      title: 'Eiffel Night',
      location: 'Paris, France',
      rating: 4.7,
      tags: ['Romance', 'Iconic'],
    ),
    Place(
      imageUrl: 'assets/images/banff.jpg',
      title: 'Banff Trails',
      location: 'Alberta, Canada',
      rating: 4.9,
      tags: ['Nature', 'Hiking'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Featured Trips'),
        backgroundColor: AppTheme.primary,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.02),
        itemCount: featuredTrips.length,
        itemBuilder: (context, index) {
          final trip = featuredTrips[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PlaceInfoPage(place: trip)),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(16),
                    ),
                    child: Image.asset(
                      trip.imageUrl,
                      width: w * 0.25,
                      height: h * 0.12,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: w * 0.04),

                  // Title & Location
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: w * 0.045,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          trip.location,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: w * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Arrow Icon
                  Container(
                    margin: EdgeInsets.only(right: w * 0.03),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlaceInfoPage(place: trip),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
