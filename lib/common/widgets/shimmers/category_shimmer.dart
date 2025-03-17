
import 'package:flutter/material.dart';
import 'package:triple_h/common/widgets/shimmers/shimmer_effect.dart';

import '../../../utils/constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) =>
            const SizedBox(width: TSizes.spaceBtwItems),
        itemBuilder: (_, index) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image
              ShimmerEffect(width: 55, height: 55, radius: 55),

              SizedBox(height: TSizes.spaceBtwItems / 2),

              // Text

              ShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
