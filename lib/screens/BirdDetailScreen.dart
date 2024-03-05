import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/app_assets.dart';
import '../utils/gap.dart';
import '../widgets/AppBar.dart';
import '../widgets/Background.dart';

class BirdDetailScreen extends StatelessWidget {
  static const routeName = '/bird-detail';
  const BirdDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            title: 'Bird Detail', leadingIcon: AppAssets.angle_left_svg),
        body: Background(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset('assets/images/bird1.jpeg',
                        fit: BoxFit.cover,
                        width: context.width(),
                        height: context.width() * 0.8),
                  )),
              Gap.kSection.height,
              Text('Chào mào má đỏ Đông Nam Á', style: boldTextStyle(size: 20)),
              Gap.k8.height,
              Text('Chào mào - Má đỏ', style: secondaryTextStyle(size: 16)),
              Gap.k8.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.gender_svg,
                        color: Colors.grey,
                        height: 24,
                      ),
                      Gap.k8.width,
                      Text('Male', style: secondaryTextStyle(size: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.cake_candles_svg,
                        color: Colors.grey,
                        height: 24,
                      ),
                      Gap.k8.width,
                      Text('01/11/2023', style: secondaryTextStyle(size: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/cage.svg',
                        color: Colors.grey,
                        height: 32,
                      ).paddingTop(8),
                      Gap.k8.width,
                      Text('XXXX', style: secondaryTextStyle(size: 16)),
                    ],
                  ),
                ],
              ),
              Gap.k8.height,
              Text(
                  'Chào mào má đỏ Đông Nam Á là một loài chim thuộc họ Muscicapidae. Loài này phân bố ở Brunei, Indonesia, Malaysia, Singapore, và Thái Lan. Môi trường sống tự nhiên của chúng là rừng ẩm ướt đất thấp nhiệt đới hoặc cận nhiệt đới. Chúng bị đe dọa do mất môi trường sống.',
                  textAlign: TextAlign.justify,
                  style: secondaryTextStyle(size: 16)),
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 16),
        ));
  }
}
