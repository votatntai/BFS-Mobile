import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../cubit/ticket/ticket_cubit.dart';
import '../cubit/ticket/ticket_state.dart';
import '../domain/repositories/user_repo.dart';
import '../utils/app_assets.dart';
import '../utils/colors.dart';
import '../utils/enum.dart';
import '../utils/gap.dart';
import '../widgets/AppBar.dart';
import '../widgets/Background.dart';
import 'DashboardScreen.dart';

class AddTicketScreen extends StatefulWidget {
  const AddTicketScreen({super.key});
  static const String routeName = '/add-ticket';

  @override
  State<AddTicketScreen> createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  XFile? imageFile;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? ticketCategory;
  String? priority;

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

  void _settingModalBottomSheet(context) {
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
    return BlocProvider<TicketCubit>(
      create: (context) => TicketCubit(),
      child: BlocConsumer<TicketCubit, TicketState>(listener: (context, state) {
        if (state is CreateTicketLoadingState) {
          showLoader(context);
        }
        if (state is CreateTicketSuccessState) {
          hideLoader(context);
          Fluttertoast.showToast(msg: 'Ticket created successfully');
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, DashboardScreen.routeName, arguments: 1);
        } else if (state is CreateTicketFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message.replaceFirst('Exception: ', '')),
            backgroundColor: tomato,
          ));
          hideLoader(context);
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: const MyAppBar(title: 'Add Ticket'),
          body: Background(
            child: BlocProvider<TicketCubit>(
              create: (context) => TicketCubit(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: context.width(),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: imageFile != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.file(
                                    File(imageFile!.path),
                                    width: context.width(),
                                    height: context.width(),
                                    fit: BoxFit.cover,
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.asset(
                                    AppAssets.placeholder,
                                    fit: BoxFit.cover,
                                    height: context.width(),
                                    width: context.width(),
                                  ),
                                ),
                        ),
                        Positioned(
                            bottom: 16,
                            right: 16,
                            child: SvgPicture.asset(AppAssets.camera, color: white.withOpacity(0.5), height: 32, width: 32).onTap(() {
                              _settingModalBottomSheet(context);
                            })),
                      ],
                    ),
                    Gap.k16.height,
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintStyle: primaryTextStyle(color: gray),
                          hintText: 'Title',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    Gap.k16.height,
                    Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: 'Category',
                            hintStyle: primaryTextStyle(color: gray),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'Food', child: Text('Food')),
                            DropdownMenuItem(value: 'Bird', child: Text('Bird')),
                            DropdownMenuItem(value: 'Personnel', child: Text('Personnel')),
                            DropdownMenuItem(value: 'Cage', child: Text('Cage')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              ticketCategory = value.toString();
                            });
                          },
                        )),
                    Gap.k16.height,
                    Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: 'Priority',
                            hintStyle: primaryTextStyle(color: gray),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                          // items: const [
                          //   DropdownMenuItem(value: '1', child: Text('Food')),
                          //   DropdownMenuItem(value: '2', child: Text('Bird')),
                          //   DropdownMenuItem(value: '3', child: Text('Personnel')),
                          //   // DropdownMenuItem(value: 'Cage', child: Text('Cage')),
                          // ],
                          items: Priority.values.map((Priority priority) {
                            return DropdownMenuItem<String>(
                              value: priority.name,
                              child: Text(priority.toString().split('.').last),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              priority = value.toString();
                            });
                          },
                        )),
                    Gap.k16.height,
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                      child: TextField(
                        controller: descriptionController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          hintStyle: primaryTextStyle(color: gray),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    Gap.k16.height,
                    Container(
                      width: context.width(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && imageFile != null && ticketCategory != null && priority != null)
                              ? primaryColor
                              : gray.withOpacity(0.2)),
                      child: Text(
                        'Submit',
                        style: boldTextStyle(color: white),
                        textAlign: TextAlign.center,
                      ),
                    ).onTap(() {
                      showConfirmDialog(context, 'This action is irreversible', onAccept: () {
                        if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && imageFile != null && ticketCategory != null && priority != null) {
                          context.read<TicketCubit>().addTicket(
                              title: titleController.text,
                              description: descriptionController.text,
                              // cageId: widget.cageId,
                              image: imageFile!,
                              ticketCategory: ticketCategory,
                              priority: priority,
                              creatorId: UserRepo.user.id!);
                        }

                      });
                    })
                  ],
                ).paddingSymmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
        );
      }),
    );
  }
}
