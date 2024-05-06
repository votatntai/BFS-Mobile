import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/repositories/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/TicketComponent.dart';
import '../cubit/ticket/ticket_cubit.dart';
import '../cubit/ticket/ticket_state.dart';
import '../screens/AddTicketScreen.dart';
import '../utils/gap.dart';
import '../widgets/Tab.dart';

class TicketFragment extends StatefulWidget {
  const TicketFragment({super.key});

  @override
  State<TicketFragment> createState() => _TicketFragmentState();
}

class _TicketFragmentState extends State<TicketFragment> {
  TextEditingController searchController = TextEditingController();
  PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<TicketCubit>(
        create: (context) => TicketCubit()..getTickets(),
        child: BlocBuilder<TicketCubit, TicketState>(
          builder: (context, state) {
            if (state is GetTicketLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetTicketSuccessState) {
              var tickets = state.tickets.tickets!
                  .where((t) => t.ticketCategory!.toLowerCase().contains(searchController.text.toLowerCase()) || t.status!.toLowerCase().contains(searchController.text.toLowerCase()))
                  .toList();
              if (_selectedIndex == 1) {
                tickets = tickets.where((t) {
                  if(t.assignee != null){ return t.assignee!.id == UserRepo.user.id;}
                  return false;
                }).toList();
              }
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
                            child: TextField(
                              onChanged: (value) => setState(() {}),
                              controller: searchController,
                              decoration: const InputDecoration(
                                hintText: 'Search by category or status',
                                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
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
                              child: const Text(
                                'Add ticket',
                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )).onTap(() {
                            Navigator.pushNamed(context, AddTicketScreen.routeName);
                          }).expand(),
                        ],
                      ),
                      Gap.k16.height,
                      Row(
                        children: [
                          Expanded(
                              child: CustomTab(title: 'All', index: 0, selectedIndex: _selectedIndex).onTap(() => setState(() {
                                    _selectedIndex = 0;
                                  }))),
                          Gap.k8.width,
                          Expanded(
                              child: CustomTab(title: 'Assigned', index: 1, selectedIndex: _selectedIndex).onTap(() => setState(() {
                                    _selectedIndex = 1;
                                  }))),
                        ],
                      ),
                      Gap.k16.height,
                      tickets.isNotEmpty ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: tickets.length,
                        separatorBuilder: (context, index) => Gap.k16.height,
                        itemBuilder: (context, index) {
                          final ticket = tickets[index];
                          return TicketComponent(ticket: ticket);
                        },
                      ) : const Center(child: Text('No ticket')),
                    ],
                  ).paddingOnly(left: 16, right: 16, bottom: 16, top: 16),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

