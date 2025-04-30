import 'package:flutter/material.dart';


import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';

class HistoryCard extends StatelessWidget {
  final String time;
  final String date;
  final String imageUrl;
  final String scheduleName;
  final String wateringCycle;
  final String wateringTime;

  const HistoryCard({
    Key? key,
    required this.time,
    required this.date,
    required this.imageUrl,
    required this.scheduleName,
    required this.wateringCycle,
    required this.wateringTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: TColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Time and Date Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: TSizes.fontSizeMd,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: TSizes.fontSizeSm,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),

            // Vertical Divider
            Container(
              height: 50,
              width: 2,
              color: TColors.accent,
            ),
            const SizedBox(width: 16),

            // Image and Information Column
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(width: 16),

            // Schedule Information Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scheduleName,
                    style: TextStyle(
                      fontSize: TSizes.fontSizeMd,
                      fontWeight: FontWeight.bold,
                      color: TColors.accent,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '[Watering cycle] ',
                          style: TextStyle(
                            fontSize: TSizes.fontSizeSm,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: '$wateringCycle, ',
                          style: TextStyle(
                            fontSize: TSizes.fontSizeSm,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '[Watering time] ',
                          style: TextStyle(
                            fontSize: TSizes.fontSizeSm,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: wateringTime,
                          style: TextStyle(
                            fontSize: TSizes.fontSizeSm,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
