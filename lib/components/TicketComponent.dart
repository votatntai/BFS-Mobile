import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../domain/models/tickets.dart';
import '../screens/TicketDetailScreen.dart';
import '../utils/app_assets.dart';
import '../utils/gap.dart';

class TicketComponent extends StatelessWidget {
  const TicketComponent({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage.assetNetwork(
              image: ticket.image!,
              placeholder: AppAssets.placeholder,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
          Gap.k16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ticket.ticketCategory!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SizedBox(
                  width: context.width() * 0.4,
                  child: Text(
                    ticket.description!,
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          ).expand(),
          Gap.k16.width,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                  color: ticket.status == 'Done'
                      ? forestGreen
                      : ticket.status == 'Rejected'
                          ? redColor
                          : goldenRod),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              ticket.status!,
              style: primaryTextStyle(
                  color: ticket.status == 'Done'
                      ? forestGreen
                      : ticket.status == 'Rejected'
                          ? redColor
                          : goldenRod),
            ),
          )
        ],
      ),
    ).onTap((){
      Navigator.pushNamed(context, TicketDetailScreen.routeName, arguments: ticket.id);
    });
  }
}
