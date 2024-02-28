import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/app_assets.dart';
import '../utils/colors.dart';
import '../utils/gap.dart';

class BirdComponent extends StatelessWidget {
  final bool isGrid;
  const BirdComponent({
    super.key,
    this.isGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/images/bird1.jpeg',
                        fit: BoxFit.cover, width: context.width(), height: 120)),
                Gap.k8.height,
                Text('Chào mào má đỏ Đông Nam Á', style: boldTextStyle()),
                Gap.k4.height,
                Row(
                  children: [
                    Text('Species: ', style: secondaryTextStyle()),
                    Flexible(child: Text('Chào mào má đỏ', style: secondaryTextStyle(), overflow: TextOverflow.ellipsis,)),
                  ],
                ),
                Gap.k4.height,
                Row(
                  children: [
                    Text('Category: ', style: secondaryTextStyle()),
                    Flexible(child: Text('Chào mào', style: secondaryTextStyle(), overflow: TextOverflow.ellipsis,)),
                  ],
                ),
              ],
            ));
    } else {
      return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/bird1.jpeg',
                          fit: BoxFit.cover, width: 80, height: 80)),
                  Gap.k16.width,
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Chào mào má đỏ Đông Nam Á',
                            style: boldTextStyle()),
                        Row(
                          children: [
                            Text('Species: ', style: secondaryTextStyle()),
                            Text('Chào mào má đỏ', style: secondaryTextStyle()),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Category: ', style: secondaryTextStyle()),
                            Text('Chào mào', style: secondaryTextStyle()),
                          ],
                        ),
                      ]).expand(),
                ],
              ),
            ),
          );
    }
  }
}
