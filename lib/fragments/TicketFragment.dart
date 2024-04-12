import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../cubit/ticket/ticket_cubit.dart';
import '../cubit/ticket/ticket_state.dart';
import '../screens/AddTicketScreen.dart';
import '../utils/app_assets.dart';
import '../utils/gap.dart';

class TicketFragment extends StatefulWidget {
  const TicketFragment({super.key});

  @override
  State<TicketFragment> createState() => _TicketFragmentState();
}

class _TicketFragmentState extends State<TicketFragment> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocProvider<TicketCubit>(create: (context) => TicketCubit()..getTickets(),
        child: BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
          if (state is GetTicketLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetTicketSuccessState) {
            var tickets = state.tickets.tickets!.where((t) => t.ticketCategory!.toLowerCase().contains(searchController.text.toLowerCase()) || t.status!.toLowerCase().contains(searchController.text.toLowerCase())).toList();
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TicketCubit>().getTickets();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: context.width() * 0.65,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  TextField(
                            onChanged: (value) => setState(() {}),
                            controller: searchController,
                            decoration: const InputDecoration(
                              hintText: 'Search by category or status',
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                            ), 
                          ),
                        ),
                        Gap.k8.width,
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text('Add ticket', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                        ).onTap(() {
                          Navigator.pushNamed(context, AddTicketScreen.routeName);
                        }).expand(),
                      ],
                    ),
                    Gap.k16.height, 
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tickets.length,
                      separatorBuilder: (context, index) => Gap.k16.height,
                      itemBuilder: (context, index) {
                        final ticket = tickets[index];
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
                                  SizedBox(width: context.width() * 0.4, child: Text(ticket.description!, style: const TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis,)),
                                ],
                              ).expand(),
                              Gap.k16.width,
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: ticket.status == 'Done' ? forestGreen : ticket.status == 'Rejected' ? redColor : goldenRod),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(ticket.status!, style: primaryTextStyle(color: ticket.status == 'Done' ? forestGreen : ticket.status == 'Rejected' ? redColor : goldenRod),),)
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ).paddingOnly(left: 16, right: 16, bottom: 16, top: 16),
              ),
            );
          } 
          return const SizedBox.shrink();
        },),),);
  }
}