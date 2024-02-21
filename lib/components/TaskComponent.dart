import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/app_assets.dart';
import '../utils/colors.dart';
import '../utils/gap.dart';

class TaskComponent extends StatelessWidget {
  const TaskComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            const Text('Food and water',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textGrayColor)),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: peru.withOpacity(0.4),
                  borderRadius:
                      BorderRadius.circular(10)),
              child: SvgPicture.asset(AppAssets.food_svg,
                  width: 16, height: 16, color: peru),
            ),
          ],
        ),
        Gap.k4.height,
        const Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Text('Fill food and water',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        Gap.k8.height,
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppAssets.clock_svg,
                    width: 16, height: 16, color: primaryColor.withOpacity(0.5)),
                    Gap.k8.width,
                Text('10:00 AM',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor.withOpacity(0.5))),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: greenColor.withOpacity(0.3),
                  borderRadius:
                      BorderRadius.circular(10)),
              child: Text('Done', style: TextStyle(
                color: greenColor,
                fontWeight: FontWeight.w500,
              )),
            ),
          ],
        ),
        
      ]),
    );
  }
}
