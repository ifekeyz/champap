import 'package:champ_app/modules/auth/view_model/auth_vm.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/custom_button.dart';
import 'package:champ_app/shared/widgets/custom_text_form_field.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../core/service_injector/service_injector.dart';
import '../../shared/models/login_model.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/loading_overlay.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      vmBuilder: (context) => AuthViewModel(authService: si.authService),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, AuthViewModel viewModel) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const LoadingOverlay(
        image: logoImg,
        text: "Sending ...",
      ),
      overlayOpacity: 0.8,
      child: Scaffold(
        backgroundColor: black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: white,
                size: 20.sp,
              )),
          title: Styles.bold('', fontSize: 20.sp, color: white),
        ),
        body: Container(
            width: deviceWidth(context),
            height: deviceHeight(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      bckgroundImg,
                    ),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 17.5.w,
                  ),
                  child: Form(
                    key: _form,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // VSpace(24.h),
                          Image.asset(
                            support,
                            height: 126.h,
                            // width: 80.57.w,
                          ),
                          // VSpace(36.h),
                          Center(
                            child: Styles.bold("Contact Support",
                                fontSize: 20.sp, color: white),
                          ),
                          VSpace(5.h),
                          Center(
                            child: Styles.regular(
                                "Drop us a message and we will get back to you as soon as we can",
                                fontSize: 14.sp,
                                align: TextAlign.center,
                                color: white),
                          ),
                          VSpace(36.h),
                          CustomTextFormField(
                            hintText: 'Subject',
                            controller: viewModel.refEmailCrt,
                          ),
                          VSpace(20.h),
                          Container(
                            height: 150.h,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.sp),
                                border: Border.all(
                                    width: 0.5,
                                    color: white.withOpacity(0.21))),
                            child: TextField(
                                // controller: viewModel.descriptionController,
                                keyboardType: TextInputType.multiline,
                                maxLength: null,
                                maxLines: null,
                                decoration: InputDecoration(
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      height: 2.h,
                                      color: champTextGrey,
                                      fontSize: 12.sp,
                                    ),
                                    hintText: "Type here ..."),
                                style: TextStyle(
                                  height: 2.h,
                                  color: white,
                                )),
                            // Styles.regular(
                            //     "Passionate Designer in translate problem to design solution through human-centered design. I have 1+ years experience in this field.",
                            //     color: black, height: 2.h, fontSize: 14.sp),
                          ),
                          VSpace(40.h),
                          CustomButton(
                              title: "Send",
                              isActive: true,
                              onPress: () async {
                                bool isValid = _form.currentState!.validate();
                                if (isValid) {
                                  context.loaderOverlay.show();
                                  // await Firebase.initializeApp();
                                  bool? logged = await viewModel.login(
                                      context: context,
                                      cred: LoginModel(
                                          email: viewModel.emailCrt.text,
                                          password:
                                              viewModel.passwordCrt.text));
                                }
                                // Navigator.push(
                                //   context,
                                //   MainRouter.generateRoute(
                                //     const RouteSettings(
                                //         name: RoutePaths.bottomNav),
                                //   ),
                                // );
                              }),
                        ]),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
