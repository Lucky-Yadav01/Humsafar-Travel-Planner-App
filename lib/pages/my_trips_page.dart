import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'planned_trip_details.dart';
import 'past_trip_details.dart';

// ───────────────────────────────── Trip model
class Trip {
  final String title;
  final String location;
  final String imageUrl;
  final DateTime start;
  final DateTime end;
  final bool isPast;

  Trip({
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.start,
    required this.end,
    required this.isPast,
  });
}

// ───────────────────────────────── Dummy data
final List<Trip> dummyTrips = [
  Trip(
    title: 'Goa Getaway',
    location: 'Goa, India',
    imageUrl: 'assets/images/goa.jpg',
    start: DateTime(2025, 6, 10),
    end: DateTime(2025, 6, 15),
    isPast: false,
  ),
  Trip(
    title: 'Snowy Peaks',
    location: 'Manali, India',
    imageUrl: 'assets/images/manali.jpg',
    start: DateTime(2025, 12, 20),
    end: DateTime(2025, 12, 27),
    isPast: false,
  ),
  Trip(
    title: 'Biking Ladakh',
    location: 'Leh‑Ladakh',
    imageUrl: 'assets/images/leh_ladakh.jpg',
    start: DateTime(2024, 8, 05),
    end: DateTime(2024, 8, 15),
    isPast: true,
  ),
  Trip(
    title: 'Pink City Tour',
    location: 'Jaipur, India',
    imageUrl: 'assets/images/jaipur.jpg',
    start: DateTime(2024, 3, 12),
    end: DateTime(2024, 3, 15),
    isPast: true,
  ),
];

// ───────────────────────────────── MyTripsPage widget
class MyTripsPage extends StatefulWidget {
  final bool showPast;

  const MyTripsPage({super.key, this.showPast = false});

  @override
  State<MyTripsPage> createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> {
  late bool showPast;

  @override
  void initState() {
    super.initState();
    showPast = widget.showPast;
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final trips = dummyTrips.where((t) => t.isPast == showPast).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(showPast ? 'Past Trips' : 'Planned Trips'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // category chips
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.015),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _chip('Planned', !showPast, () => setState(() => showPast = false)),
                SizedBox(width: w * 0.04),
                _chip('Past', showPast, () => setState(() => showPast = true)),
              ],
            ),
          ),
          Expanded(
            child: trips.isEmpty
                ? Center(
                    child: Text(
                      'No trips to show.',
                      style: TextStyle(fontSize: w * 0.045, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.01),
                    itemCount: trips.length,
                    itemBuilder: (context, i) => _TripCard(trip: trips[i]),
                  ),
          ),
        ],
      ),
      floatingActionButton: showPast
          ? null
          : FloatingActionButton(
              onPressed: () {
                // TODO: navigate to "Add Trip" flow
              },
              child: const Icon(Icons.add),
            ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.primary),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppTheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────── Trip card widget
class _TripCard extends StatelessWidget {
  final Trip trip;
  const _TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        if (trip.isPast) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PastTripDetailsPage(
                tripTitle: trip.title,
                location: trip.location,
                imageUrl: trip.imageUrl,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PlannedTripDetailsPage(
                title: trip.title,
                location: trip.location,
                imageUrl: trip.imageUrl,
              ),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: h * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                trip.imageUrl,
                height: h * 0.22,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.title,
                    style: TextStyle(fontSize: w * 0.05, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trip.location,
                    style: TextStyle(fontSize: w * 0.04, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${_fmt(trip.start)} – ${_fmt(trip.end)}',
                        style: TextStyle(fontSize: w * 0.035),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: trip.isPast
                              ? Colors.grey.shade300
                              : AppTheme.primary.withOpacity(.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          trip.isPast ? 'Past' : 'Planned',
                          style: TextStyle(
                            fontSize: w * 0.035,
                            color: trip.isPast ? Colors.black87 : AppTheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fmt(DateTime d) => '${d.day}/${d.month}/${d.year}';
}
