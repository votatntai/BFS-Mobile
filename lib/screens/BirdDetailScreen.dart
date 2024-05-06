import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../cubit/bird/bird_cubit.dart';
import '../cubit/bird/bird_state.dart';
import '../utils/app_assets.dart';
import '../utils/gap.dart';
import '../widgets/AppBar.dart';
import '../widgets/Background.dart';

class BirdDetailScreen extends StatelessWidget {
  static const routeName = '/bird-detail';
  final String birdId;
  const BirdDetailScreen({super.key, required this.birdId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: 'Bird Detail', leadingIcon: AppAssets.angle_left_svg),
        body: Background(
          child: SingleChildScrollView(
            child: BlocProvider<BirdCubit>(
              create: (context) => BirdCubit()..getBirdDetail(birdId),
              child: BlocBuilder<BirdCubit, BirdState>(builder: (context, state) {
                if (state is BirdDetailLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is BirdDetailSuccessState) {
                  var bird = state.bird;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: FadeInImage.assetNetwork(placeholder: AppAssets.placeholder, image: bird.thumbnailUrl!, fit: BoxFit.cover, width: context.width(), height: context.width() * 0.8),
                          )),
                      Gap.kSection.height,
                      Text(bird.name!, style: boldTextStyle(size: 20)),
                      Gap.k8.height,
                      Text('${bird.species!.name!} - ${bird.category!.name!}', style: secondaryTextStyle(size: 16)),
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
                              Text(bird.gender! ? 'Male' : 'Female', style: secondaryTextStyle(size: 16)),
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
                              Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(bird.dayOfBirth!)), style: secondaryTextStyle(size: 16)),
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
                              Text('Xxxx', style: secondaryTextStyle(size: 16)),
                            ],
                          ),
                        ],
                      ),
                      if (bird.characteristic != null) ...[
                        Gap.k8.height,
                        Text(bird.characteristic!, textAlign: TextAlign.justify, style: secondaryTextStyle(size: 16)),
                      ],
                    ],
                  ).paddingSymmetric(horizontal: 16, vertical: 16);
                }
                return const SizedBox.shrink();
              }),
            ),
          ),
        ));
  }
}
