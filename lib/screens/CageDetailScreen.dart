import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/app_assets.dart';
import '../utils/gap.dart';
import '../widgets/AppBar.dart';
import '../widgets/Background.dart';

class CageDetailScreen extends StatelessWidget {
  static const routeName = '/cage-detail';
  const CageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
            title: 'Cage Detail', leadingIcon: AppAssets.angle_left_svg),
        body: Background(
          widget: SingleChildScrollView(
            child: Column(
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
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset('assets/images/cage.webp',
                          fit: BoxFit.cover,
                          width: context.width(),
                          height: context.width() * 0.8),
                    )),
                Gap.kSection.height,
                Text('C001', style: boldTextStyle(size: 20)),
                Gap.k8.height,
                Text('Chào mào - Má đỏ', style: secondaryTextStyle(size: 16)),
                Gap.k8.height,
                Text('Chăm sóc đặc biệt', style: secondaryTextStyle(size: 16)),
                Gap.k16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('Material', style: secondaryTextStyle(size: 12)),
                        Gap.k8.width,
                        Text('Metal', style: secondaryTextStyle(size: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Width', style: secondaryTextStyle(size: 12)),
                        Gap.k8.width,
                        Text('40 cm', style: secondaryTextStyle(size: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Height', style: secondaryTextStyle(size: 12)),
                        Gap.k8.width,
                        Text('40 cm', style: secondaryTextStyle(size: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Depth', style: secondaryTextStyle(size: 12)),
                        Gap.k8.width,
                        Text('60 cm', style: secondaryTextStyle(size: 16)),
                      ],
                    ),
                  ],
                ),
                Gap.k16.height,
                Text(
                    'Cage is a secure and comfortable home for your pet bird. It is made of high-quality metal and is designed to be durable and long-lasting. The cage is easy to assemble and comes with a removable tray for easy cleaning. The cage also has a large door for easy access and a secure lock to keep your pet safe. The cage is suitable for small to medium-sized birds and is perfect for use in your home or aviary. It is also available in a range of sizes and colors to suit your needs. The cage is a great choice for anyone looking for a secure and comfortable home for their pet bird.',
                    textAlign: TextAlign.justify,
                    style: secondaryTextStyle(size: 16)),
              ],
            ).paddingSymmetric(horizontal: 16, vertical: 16),
          ),
        ));
  }
}
