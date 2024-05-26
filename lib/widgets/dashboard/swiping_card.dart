import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mismatchh/constants/colors.dart';
import 'package:mismatchh/constants/miscellaneous.dart';
import 'package:mismatchh/constants/textstyles.dart';

class SwipingCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String age;
  final List<String> interests;
  final String distance;
  final Function() onTap;

  const SwipingCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.age,
    required this.interests,
    required this.distance, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  fadeInCurve: Curves.easeIn,
                  fadeOutCurve: Curves.easeOut,
                  fadeInDuration: kAnimationDuration,
                  fadeOutDuration: kAnimationDuration,
                ),
              ),
            ),
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
            // Text content
            Positioned(
              left: 16,
              bottom: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and age
                  Row(
                    children: [
                      Text(
                        '$name, $age',
                        style: text24Bold.copyWith(color: kWhite),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: interests.map((interest) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: kYellow.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: kYellow.withOpacity(0.5)),
                        ),
                        child: Text(
                          interest,
                          style: text14Medium.copyWith(color: kWhite),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  // Distance
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: kWhite,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        distance,
                        style: text16Medium.copyWith(color: kWhite),
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
}
