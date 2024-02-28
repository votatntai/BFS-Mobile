import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/LoginScreen.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/constants.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: loading ? CircularProgressIndicator() : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                width: context.width(),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Logout', style: boldTextStyle(color: primaryColor))
                    .center(),
              )
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 32)).onTap(
        () async {
          await setValue(AppConstant.TOKEN_KEY, '');
          setState(() {
            loading = true;
          });
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        },
      ),
    );
  }
}
