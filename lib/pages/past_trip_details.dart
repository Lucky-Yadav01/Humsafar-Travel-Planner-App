import 'package:flutter/material.dart';
import '../pages/app_theme.dart';

class PastTripDetailsPage extends StatefulWidget {
  final String tripTitle;
  final String location;
  final String imageUrl;

  const PastTripDetailsPage({
    super.key,
    required this.tripTitle,
    required this.location,
    required this.imageUrl,
  });

  @override
  State<PastTripDetailsPage> createState() => _PastTripDetailsPageState();
}

class _PastTripDetailsPageState extends State<PastTripDetailsPage> {
  double rating = 0;
  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Past Trip'),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trip Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(widget.imageUrl, height: h * 0.3, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),

            Text(widget.tripTitle,
                style: TextStyle(fontSize: w * 0.06, fontWeight: FontWeight.bold)),
            Text(widget.location,
                style: TextStyle(fontSize: w * 0.04, color: Colors.grey[700])),

            const SizedBox(height: 20),
            Text('How was your experience?',
                style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w600)),

            const SizedBox(height: 12),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () => setState(() => rating = index + 1.0),
                  icon: Icon(
                    Icons.star,
                    color: index < rating ? Colors.orange : Colors.grey[400],
                  ),
                );
              }),
            ),

            const SizedBox(height: 16),
            Text('Leave a review:',
                style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w600)),

            const SizedBox(height: 8),
            TextField(
              controller: reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write something...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: () {
                  // Submit logic (store or send review)
                  Navigator.pop(context);
                },
                child: const Text('Submit Review', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
