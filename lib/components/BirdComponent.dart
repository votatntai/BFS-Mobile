import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../domain/models/birds.dart';
import '../utils/gap.dart';

class BirdComponent extends StatelessWidget {
  final bool isGrid;
  final Bird bird;
  const BirdComponent({
    super.key,
    this.isGrid = false, required this.bird,
  });

  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage.assetNetwork(image: bird.thumbnailUrl!, placeholder: 'assets/images/placeholder.jpg',
                        fit: BoxFit.cover, width: context.width(), height: 120)),
                Gap.k8.height,
                Text(bird.name!, style: boldTextStyle()),
                Gap.k4.height,
                Row(
                  children: [
                    Text('Species: ', style: secondaryTextStyle()),
                    Flexible(child: Text(bird.species!.name!, style: secondaryTextStyle(), overflow: TextOverflow.ellipsis,)),
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
            padding: const EdgeInsets.all(16),
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
                      child: FadeInImage.assetNetwork(image: bird.thumbnailUrl!, placeholder: 'assets/images/placeholder.jpg',
                          fit: BoxFit.cover, width: 80, height: 80)),
                  Gap.k16.width,
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(bird.name!,
                            style: boldTextStyle()),
                        Row(
                          children: [
                            Text('Species: ', style: secondaryTextStyle()),
                            Text(bird.species!.name!, style: secondaryTextStyle()),
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
