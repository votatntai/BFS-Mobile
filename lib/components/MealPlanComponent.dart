import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../domain/models/mealplans.dart';
import '../utils/app_assets.dart';
import '../utils/colors.dart';
import '../utils/gap.dart';

class MealPlanComponent extends StatelessWidget {
  const MealPlanComponent({
    super.key,
    required this.mealPlan,
    required this.thumbnailUrls,
  });

  final MealPlan mealPlan;
  final List<String> thumbnailUrls;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: primaryColor.withOpacity(0.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mealPlan.title!,
            style: boldTextStyle(color: gray, weight: FontWeight.w500),
          ),
          Gap.k8.height,
          Row(
            children: [
              Text(
                '${DateFormat("dd/MM/yyyy").format(DateTime.parse(mealPlan.from!))} - ${DateFormat("dd/MM/yyyy").format(DateTime.parse(mealPlan.to!))}',
                style: secondaryTextStyle(color: gray),
              ),
              const Spacer(),
              HorizontalList(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FadeInImage.assetNetwork(placeholder: AppAssets.food_placeholder, image: thumbnailUrls[index], width: 30, height: 30, fit: BoxFit.cover),
                  );
                }, itemCount: thumbnailUrls.length > 3 ? 3 : thumbnailUrls.length,),
              thumbnailUrls.length > 3
                  ? Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: primaryColor.withOpacity(0.1)),
                      child: Text(
                        '+${thumbnailUrls.length - 2}',
                        style: secondaryTextStyle(color: gray),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
