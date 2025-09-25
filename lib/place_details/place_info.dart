import 'package:flutter/material.dart';
import '../pages/app_theme.dart';
import '../bookmark_manager.dart';
import 'add_plans.dart';

class Place {
  final String imageUrl;
  final String title;
  final String location;
  final double rating;
  final List<String> tags;

  Place({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.rating,
    required this.tags,
  });
}

class PlaceInfoPage extends StatefulWidget {
  final Place place;
  const PlaceInfoPage({super.key, required this.place});

  @override
  State<PlaceInfoPage> createState() => _PlaceInfoPageState();
}

class _PlaceInfoPageState extends State<PlaceInfoPage> {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    isBookmarked = BookmarkManager().isBookmarked(widget.place);
  }

  void toggleBookmark() {
    BookmarkManager().toggleBookmark(widget.place);
    setState(() => isBookmarked = !isBookmarked);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final place = widget.place;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ───── Header Image and Back/Bookmark Buttons ─────
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  child: Image.asset(
                    place.imageUrl,
                    height: h * 0.35,
                    width: double.infinity,
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
                Positioned(
                  top: 16,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: AppTheme.primary,
                      ),
                      onPressed: toggleBookmark,
                    ),
                  ),
                ),
              ],
            ),

            // ───── Content ─────
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title, Location & Rating
                    Text(
                      place.title,
                      style: TextStyle(
                        fontSize: w * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      place.location,
                      style: TextStyle(
                        fontSize: w * 0.045,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange),
                        const SizedBox(width: 6),
                        Text('${place.rating}'),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Tags
                    Wrap(
                      spacing: 8,
                      children: place.tags.map((tag) {
                        return Chip(
                          label: Text(tag),
                          backgroundColor: Colors.yellow.shade100,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Description
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This is a beautiful destination known for its ${place.tags.join(', ').toLowerCase()}. '
                      'Whether you’re into food, nature, culture or adventure, ${place.title} offers something for every traveler.',
                      style: TextStyle(
                        fontSize: w * 0.04,
                        height: 1.5,
                        color: Colors.grey[800],
                      ),
                    ),

                    const Spacer(),

                    // ───── Trip Price & Save Trip Button ─────
                    Padding(
                      padding: EdgeInsets.only(bottom: h * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$428.00',
                            style: TextStyle(
                              fontSize: w * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AddPlansPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.06, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Save Trip',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
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
