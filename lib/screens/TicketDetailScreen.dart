import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/cubit/ticket/ticket_cubit.dart';
import 'package:flutter_application_1/cubit/ticket/ticket_state.dart';
import 'package:flutter_application_1/utils/app_assets.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/gap.dart';
import 'package:flutter_application_1/widgets/AppBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class TicketDetailScreen extends StatefulWidget {
  const TicketDetailScreen({super.key, required this.ticketId});
  static const String routeName = '/ticket-detail';
  final String ticketId;

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  PageController _pageController = PageController();
  XFile? imageFile;
  TextEditingController resultDescriptionController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Future imageSelector(BuildContext context, String pickerType) async {
    final ImagePicker picker = ImagePicker();
    switch (pickerType) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        imageFile = (await picker.pickImage(source: ImageSource.gallery, imageQuality: 90))!;
        break;

      case "camera": // CAMERA CAPTURE CODE
        imageFile = (await picker.pickImage(source: ImageSource.camera, imageQuality: 90))!;
        break;
    }

    if (imageFile != null) {
      print("You selected  image : ${imageFile!.path}");
      setState(() {
        debugPrint("SELECTED IMAGE PICK   $imageFile");
      });
    } else {
      print("You have not taken image");
    }
  }

  void _imageModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  title: const Text('Gallery'),
                  onTap: () => {
                        imageSelector(context, "gallery"),
                        Navigator.pop(context),
                      }),
              ListTile(
                title: const Text('Camera'),
                onTap: () => {imageSelector(context, "camera"), Navigator.pop(context)},
              ),
            ],
          );
        });
  }

  void showLoader(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void hideLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: 'Ticket Detail',
        ),
        body: BlocProvider<TicketCubit>(
          create: (context) => TicketCubit()..getTicketById(ticketId: widget.ticketId),
          child: BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
            if (state is GetTicketByIdLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GetTicketByIdSuccessState) {
              final ticket = state.ticket;
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                        width: context.width(),
                        height: context.width() * 9 / 16,
                        child: ClipRRect(borderRadius: BorderRadius.circular(16), child: FadeInImage.assetNetwork(placeholder: AppAssets.placeholder, image: ticket.image!, fit: BoxFit.cover))),
                    Gap.k16.height,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              'Information',
                              style: secondaryTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            AnimatedContainer(
                              width: _tabIndex == 0 ? context.width() / 2 : 0,
                              height: 2,
                              duration: const Duration(milliseconds: 300), // Tùy chỉnh thời gian chuyển đổi
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1),
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ).onTap(() {
                          _onItemTapped(0);
                          setState(() {
                            _tabIndex = 0;
                          });
                          // _animationController!.forward();
                        })),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Result',
                                style: secondaryTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                              AnimatedContainer(
                                width: _tabIndex == 1 ? context.width() / 2 : 0,
                                height: 2,
                                duration: const Duration(milliseconds: 300), // Tùy chỉnh thời gian chuyển đổi
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1),
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ).onTap(() {
                            _onItemTapped(1);
                            setState(() {
                              _tabIndex = 1;
                            });
                            // _animationController!.forward();
                          }),
                        ),
                      ],
                    ),
                    Gap.k16.height,
                    Container(
                      constraints: BoxConstraints(maxHeight: context.height() * 0.55),
                      child: PageView(
                        controller: _pageController,
                        // onPageChanged: (index) {
                        //   setState(() {
                        //     _tabIndex = index;
                        //   });
                        // },
                        children: <Widget>[
                          SizedBox(
                            width: context.width(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Title: ', style: secondaryTextStyle()),
                                  TextSpan(text: ticket.title!, style: primaryTextStyle()),
                                ])),
                                Gap.k8.height,
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Category: ', style: secondaryTextStyle()),
                                  TextSpan(text: ticket.ticketCategory!, style: primaryTextStyle()),
                                ])),
                                Gap.k8.height,
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Creator: ', style: secondaryTextStyle()),
                                  TextSpan(text: ticket.creator!.name, style: primaryTextStyle()),
                                ])),
                                Gap.k8.height,
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Priority: ', style: secondaryTextStyle()),
                                  TextSpan(text: ticket.priority!, style: primaryTextStyle()),
                                ])),
                                Gap.k8.height,
                                if(ticket.assignee != null)... [RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Assignee: ', style: secondaryTextStyle()),
                                  TextSpan(text: ticket.assignee!.name, style: primaryTextStyle()),
                                ])),
                                Gap.k8.height],
                                if(ticket.cage != null)...[RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Cage: ', style: secondaryTextStyle()),
                                  TextSpan(text: ticket.cage!.name, style: primaryTextStyle()),
                                ])),
                                Gap.k8.height],
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Status: ', style: secondaryTextStyle()),
                                  TextSpan(text: ticket.status!, style: primaryTextStyle()),
                                ])),
                                Gap.k8.height,
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: 'Description: ', style: secondaryTextStyle()),
                                  TextSpan(text: ticket.description!, style: primaryTextStyle()),
                                ])),
                              ],
                            ),
                          ),
                          BlocProvider<TicketCubit>(
                            create: (context) => TicketCubit(),
                            child: BlocConsumer<TicketCubit, TicketState>(listener: (context, state) {
                              if (state is UpdateTicketLoadingState) {
                                showLoader(context);
                              }
                              if (state is UpdateTicketSuccessState) {
                                Fluttertoast.showToast(msg: 'Update ticket success');
                                hideLoader(context);
                                Navigator.pop(context);
                                Navigator.pushNamed(context, TicketDetailScreen.routeName, arguments: widget.ticketId);
                              }
                              if (state is UpdateTicketFailedState) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message.replaceAll('Exception: ', ''))));
                                hideLoader(context);
                              }
                            }, builder: (context, state) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      // Text('Result Description: ', style: secondaryTextStyle()),
                                      ticket.resultDescription != null
                                          ? Text(ticket.resultDescription!, style: primaryTextStyle())
                                          : Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: gray.withOpacity(0.2),
                                                ),
                                                child: TextField(
                                                  controller: resultDescriptionController,
                                                  onChanged: (value) => setState(() {}),
                                                  decoration:
                                                      InputDecoration(hintText: 'Result description', contentPadding: const EdgeInsets.all(8), border: InputBorder.none, hintStyle: secondaryTextStyle()),
                                                  maxLines: 5,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                  Gap.k8.height,
                                  ticket.resultImage != null
                                      ? SizedBox(
                                          width: context.width(),
                                          height: context.width() * 9 / 16,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(16),
                                              child: FadeInImage.assetNetwork(placeholder: AppAssets.placeholder, image: ticket.resultImage!, fit: BoxFit.cover)))
                                      : imageFile == null
                                          ? Container(
                                              width: context.width(),
                                              height: context.width() * 9 / 16,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: gray.withOpacity(0.2)),
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    AppAssets.camera,
                                                    width: 24,
                                                    height: 24,
                                                    color: gray,
                                                  ),
                                                  Gap.k8.width,
                                                  Text('Add result image', style: secondaryTextStyle())
                                                ],
                                              )),
                                            ).onTap(() {
                                              _imageModalBottomSheet(context);
                                            })
                                          : SizedBox(
                                              width: context.width(),
                                              height: context.width() * 9 / 16,
                                              child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.file(File(imageFile!.path), fit: BoxFit.cover))),
                                  const Spacer(),
                                  (ticket.resultDescription == null && ticket.resultImage == null) ? Container(
                                    width: context.width(),
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: (resultDescriptionController.text.isNotEmpty && imageFile != null) ? primaryColor : gray.withOpacity(0.2),
                                    ),
                                    child: Center(
                                      child: Text('Save', style: primaryTextStyle(color: white)),
                                    ),
                                  ).onTap(() {
                                    if (resultDescriptionController.text.isNotEmpty && imageFile != null) {
                                      showConfirmDialog(context, 'The action cannot be undone or edited', onAccept: () {
                                        context.read<TicketCubit>().updateTicket(ticketId: ticket.id!, status: 'Work finished', resultDescription: resultDescriptionController.text, resultImage: imageFile);
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields'), backgroundColor: tomato,));
                                    }
                                  }) : const SizedBox.shrink(),

                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingSymmetric(horizontal: 16),
              );
            }
            return const SizedBox.shrink();
          }),
        ));
  }
}
