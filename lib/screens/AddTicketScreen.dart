import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/ticket/ticket_cubit.dart';
import 'package:flutter_application_1/utils/app_assets.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/gap.dart';
import 'package:flutter_application_1/widgets/AppBar.dart';
import 'package:flutter_application_1/widgets/Background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class AddTicketScreen extends StatefulWidget {
  const AddTicketScreen({super.key});
  static const String routeName = '/add-ticket';

  @override
  State<AddTicketScreen> createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  XFile? imageFile;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Add Ticket'),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: Text('Submit', style: boldTextStyle(color: white),), backgroundColor: primaryColor,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Background(
        child: BlocProvider<TicketCubit>(
          create: (context) => TicketCubit(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: context.width(),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),),
                    child: imageFile != null ? ClipRRect(borderRadius: BorderRadius.circular(24), child: Image.file(File(imageFile!.path), width: context.width(), height: context.width(), fit: BoxFit.cover,)) : ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(AppAssets.placeholder, fit: BoxFit.cover, height: context.width(), width: context.width(),),
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
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              Gap.k16.height,
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                child: const TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}