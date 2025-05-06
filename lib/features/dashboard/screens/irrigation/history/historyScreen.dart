import 'package:flutter/material.dart';
import '../../../../../utils/constants/image_strings.dart';
import 'widget/historyCard.dart';
import 'package:intl/intl.dart';


class HistoryScreen extends StatelessWidget {
  final DateTime date; // Accepts date as a parameter

  const HistoryScreen({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the date to display "Month, Day, Year"
    String formattedDate = DateFormat('MMMM, dd, yyyy').format(date);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with formatted date
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Expanded ListView for history items
            Expanded(
              child: ListView.builder(
                itemCount: 2, // Adjust this count based on your data source
                itemBuilder: (context, index) {
                  return HistoryCard(
                    time: "12:00 PM",
                    date: "April, 08", // Example date, you can make it dynamic
                    imageUrl: TImages.industryCategory,
                    scheduleName: "Mango schedule",
                    wateringCycle: "1 days",
                    wateringTime: "4 minutes",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
