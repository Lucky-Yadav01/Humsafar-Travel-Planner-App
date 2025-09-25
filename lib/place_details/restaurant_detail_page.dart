import 'package:flutter/material.dart';
import '../pages/app_theme.dart';
import 'restaurant_planning_page.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool showReviews = false;

  final List<String> reviews = [
    'Amazing food and cozy ambiance. Must try!',
    'Friendly staff and great service. Will visit again.',
    'Loved the desserts and cocktails!',
  ];

  @override
  Widget build(BuildContext context) {
    final restaurant = widget.restaurant;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // header image
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(20)),
                  child: Image.asset(
                    restaurant.img,
                    width: double.infinity,
                    height: h * 0.35,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            // info section
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.06, vertical: h * 0.025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: TextStyle(
                          fontSize: w * 0.06, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_pin, size: 18),
                            const SizedBox(width: 4),
                            Text(restaurant.area),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.attach_money, size: 18),
                            Text(restaurant.price),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.orange, size: 18),
                            Text('${restaurant.rating}'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Tabs
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => showReviews = false),
                          child: Text(
                            'Details',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: w * 0.045,
                              color: showReviews ? Colors.grey[500] : Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () => setState(() => showReviews = true),
                          child: Row(
                            children: [
                              Text(
                                'Reviews',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: w * 0.045,
                                  color: showReviews ? Colors.black : Colors.grey[500],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text('${reviews.length}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Content
                    Expanded(
                      child: showReviews
                          ? ListView.separated(
                              itemCount: reviews.length,
                              separatorBuilder: (_, __) =>
                                  const Divider(height: 20),
                              itemBuilder: (context, i) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.person, size: 28, color: Colors.grey),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        reviews[i],
                                        style: TextStyle(
                                          fontSize: w * 0.04,
                                          height: 1.5,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : SingleChildScrollView(
                              child: Text(
                                'Indulge in a delectable culinary experience at ${restaurant.name}, nestled in the heart of ${restaurant.area}. '
                                'A haven for food enthusiasts seeking mouth‑watering flavours and fresh creations.\n\n'
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer vel ligula et neque mattis aliquet.',
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  height: 1.45,
                                ),
                              ),
                            ),
                    ),

                    // Save Trip button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          // save trip logic (or show toast)
                          Navigator.pop(context);
                        },
                        child: const Text('Save trip',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
