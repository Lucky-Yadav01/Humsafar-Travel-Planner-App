import 'package:flutter/material.dart';
import '../pages/app_theme.dart';
import 'restaurant_planning_page.dart';

class AddPlansPage extends StatelessWidget {
  const AddPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Add Plans"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppTheme.primary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            //---------------- Top Category Chips -------------------------------
            // Wrap(
            //   spacing: 10,
            //   runSpacing: 10,
            //   children: [
            //     // _buildChip('Travel Data', Icons.travel_explore),
            //     // _buildChip('Hotel', Icons.hotel),
            //     // _buildChip('Travel Period', Icons.date_range),
            //     // _buildChip('Travelling Way', Icons.directions_bus),
            //   ],
            // ),
            // const SizedBox(height: 24),

            // ---------Section Title-------------------------------------------
            // Text(
            //   'Add activities 🎉',
            //   style: TextStyle(
            //     fontSize: w * 0.05,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 16),

            // Activity Options Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  _activityBox('Restaurants', Icons.restaurant, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RestaurantPlanningPage()),
                    );
                  }),
                  _activityBox('Hotel', Icons.hotel),
                  _activityBox('Travel Period', Icons.date_range),
                  _activityBox('Travelling Way', Icons.directions_bus),
                  _activityBox('Sightseeing', Icons.photo_camera),
                  _activityBox('Nightlife', Icons.celebration),
                  _activityBox('Fun', Icons.sports_esports),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, IconData icon) {
    return Chip(
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      avatar: Icon(icon, color: AppTheme.primary),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: AppTheme.primary),
      ),
    );
  }

  Widget _activityBox(String label, IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.green.shade800),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
