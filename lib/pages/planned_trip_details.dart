import 'package:flutter/material.dart';
import '../pages/app_theme.dart';

class PlannedTripDetailsPage extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;

  const PlannedTripDetailsPage({
    super.key,
    required this.title,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Planned Trip'),
        centerTitle: true,
        leading: BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Open plan edit flow (future implementation)
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(imageUrl,
                  height: h * 0.3, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),

            Text(title,
                style: TextStyle(fontSize: w * 0.06, fontWeight: FontWeight.bold)),
            Text(location,
                style: TextStyle(fontSize: w * 0.04, color: Colors.grey[700])),

            const SizedBox(height: 20),
            Text('Planned Activities',
                style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w600)),

            const SizedBox(height: 10),
            _activityTile(Icons.photo_camera, 'Sightseeing tour'),
            _activityTile(Icons.restaurant, 'Dinner at Café Roma'),
            _activityTile(Icons.spa, 'Relaxation spa session'),
            _activityTile(Icons.hotel, 'Check-in at Grand Hotel'),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit_calendar),
                label: const Text('Edit Plan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  // Navigate to add/edit plan page
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _activityTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.primary.withOpacity(0.2),
            child: Icon(icon, color: AppTheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
