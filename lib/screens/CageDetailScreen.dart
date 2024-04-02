import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../cubit/cage/cage_cubit.dart';
import '../cubit/cage/cage_state.dart';
import '../utils/app_assets.dart';
import '../utils/gap.dart';
import '../widgets/AppBar.dart';
import '../widgets/Background.dart';

class CageDetailScreen extends StatelessWidget {
  static const routeName = '/cage-detail';
  final String cageId;
  const CageDetailScreen({super.key, required this.cageId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
            title: 'Cage Detail', leadingIcon: AppAssets.angle_left_svg),
        body: Background(
          child: SingleChildScrollView(
            child: BlocProvider<CageCubit>(
              create: (context) => CageCubit()..getCageDetail(cageId),
              child: BlocBuilder<CageCubit, CageState>(
                builder: (context, state) {
                  if (state is CageDetailLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CageDetailSuccessState) {
                    var cage = state.cage;
                  return Column(
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
                            child: FadeInImage.assetNetwork(placeholder: AppAssets.placeholder, image: cage.thumbnailUrl!,
                                fit: BoxFit.cover,
                                width: context.width(),
                                height: context.width() * 0.8),
                          )),
                      Gap.kSection.height,
                      Text(cage.name!, style: boldTextStyle(size: 20)),
                      Gap.k8.height,
                      Text(cage.code!, style: secondaryTextStyle(size: 16)),
                      Gap.k16.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Material', style: secondaryTextStyle(size: 12)),
                              Gap.k8.width,
                              Text(cage.material!, style: secondaryTextStyle(size: 16)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Width', style: secondaryTextStyle(size: 12)),
                              Gap.k8.width,
                              Text('${cage.width} cm', style: secondaryTextStyle(size: 16)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Height', style: secondaryTextStyle(size: 12)),
                              Gap.k8.width,
                              Text('${cage.height} cm', style: secondaryTextStyle(size: 16)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Depth', style: secondaryTextStyle(size: 12)),
                              Gap.k8.width,
                              Text('${cage.depth} cm', style: secondaryTextStyle(size: 16)),
                            ],
                          ),
                        ],
                      ),
                      Gap.k16.height,
                      Text(
                          cage.description!,
                          textAlign: TextAlign.justify,
                          style: secondaryTextStyle(size: 16)),
                    ],
                  ).paddingSymmetric(horizontal: 16, vertical: 16);
                    
                  }
                  return const SizedBox.shrink();
                }
              ),
            ),
          ),
        ));
  }
}
