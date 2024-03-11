import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../cubit/staff/staff_cubit.dart';
import '../cubit/staff/staff_state.dart';
import '../screens/LoginScreen.dart';
import '../utils/app_assets.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/gap.dart';

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
              child: loading
                  ? const CircularProgressIndicator()
                  : BlocProvider<StaffCubit>(
                      create: (context) => StaffCubit()..getStaffInformation(),
                      child: BlocBuilder<StaffCubit, StaffState>(
                          builder: (context, state) {
                        if (state is StaffLoadingState) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (state is StaffSuccessState) {
                          var staff = state.staff;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(borderRadius: BorderRadius.circular(60),child: FadeInImage.assetNetwork(placeholder: AppAssets.placeholder, image: staff.avatarUrl!, height: 120, width: 120, fit: BoxFit.cover,),),
                              Gap.k16.height,
                              Text(staff.name!, style: boldTextStyle(size: 20)),
                              Gap.k16.height,
                              Row(
                                children: [
                                  SvgPicture.asset(AppAssets.phone, height: 20, width: 20),
                                  Gap.k16.width,
                                  Text(staff.phone!, style: secondaryTextStyle(size: 16)),
                                ],
                              ),
                              Gap.k16.height,
                              Row(
                                children: [
                                  SvgPicture.asset(AppAssets.envelope, height: 20, width: 20),
                                  Gap.k16.width,
                                  Text(staff.email!, style: secondaryTextStyle(size: 16)),
                                ],
                              ),
                              Gap.kSection.height,
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                width: context.width(),
                                decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text('Logout',
                                        style:
                                            boldTextStyle(color: primaryColor))
                                    .center(),
                              )
                            ],
                          ).paddingSymmetric(horizontal: 16, vertical: 32);
                        }
                        return const SizedBox.shrink();
                      }),
                    ))
          .onTap(
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
