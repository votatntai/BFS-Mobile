import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../domain/models/cages.dart';
import '../utils/gap.dart';

class CageComponent extends StatelessWidget {
  final bool isGrid;
  final Cage cage;
  const CageComponent({
    super.key,
    this.isGrid = false,
    required this.cage,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage.assetNetwork(image: cage.thumbnailUrl!, placeholder: 'assets/images/placeholder.jpg', fit: BoxFit.cover, width: context.width(), height: 120)),
              Spacer(),
              Text(cage.name!, style: boldTextStyle()),
              Gap.k4.height,
              // Text('Species: ' + cage.species!.name!, style: secondaryTextStyle()),
              // Text(cage.species!.name!, style: secondaryTextStyle()),
              // Gap.k4.height,
              // Text('Category: ' + cage.name!, style: secondaryTextStyle()),
            ],
          )).onTap(() {
        Navigator.pushNamed(context, '/cage-detail', arguments: cage.id);
      });
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
                  child: FadeInImage.assetNetwork(image: cage.thumbnailUrl!, placeholder: 'assets/images/placeholder.jpg', fit: BoxFit.cover, width: 80, height: 80)),
              Gap.k16.width,
              Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text(cage.name!, style: boldTextStyle()),
                Text(cage.code!, style: secondaryTextStyle()),
                // Row(
                //   children: [
                //     Text('Category: ', style: secondaryTextStyle()),
                //     Text(cage.category!.name!, style: secondaryTextStyle()),
                //   ],
                // ),
              ]).expand(),
            ],
          ),
        ),
      ).onTap(() {
        Navigator.pushNamed(context, '/cage-detail', arguments: cage.id);
      });
    }
  }
}
