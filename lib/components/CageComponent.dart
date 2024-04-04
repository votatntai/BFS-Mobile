import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/TasksScreen.dart';
import 'package:flutter_application_1/screens/TicketsScreen.dart';
import 'package:flutter_application_1/utils/colors.dart';
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
              Column(
                children: [
                  Container(
                    width: 60,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: primaryColor),
                    ),
                    child: Text('Ticket', style: primaryTextStyle(size: 14, color: primaryColor), textAlign: TextAlign.center,),
                  ).onTap(() {
                    Navigator.pushNamed(context, TicketsScreen.routeName, arguments: cage.id);
                  }),
                  Spacer(),
                  Container(
                    width: 60,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: primaryColor),
                    ),
                    child: Text('Task', style: primaryTextStyle(size: 14, color: primaryColor), textAlign: TextAlign.center,),
                  ).onTap(() {
                    Navigator.pushNamed(context, TasksScreen.routeName, arguments: cage.id);
                  }),
                ],
              ),
            ],
          ),
        ),
      ).onTap(() {
        Navigator.pushNamed(context, '/cage-detail', arguments: cage.id);
      });
    }
  }
}
