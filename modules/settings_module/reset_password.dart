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
import '../../shared/models/change_password_model.dart';
import '../../shared/utils/validator.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/loading_overlay.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isVisible = true;
  GlobalKey<FormState> _form = GlobalKey<FormState>();

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
        text: "Resetting ...",
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
          title: Styles.bold('CHANGE PASSWORD', fontSize: 20.sp, color: white),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 17.5.w, vertical: 24.h),
                  child: Form(
                    key: _form,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextFormField(
                            obscureText: viewModel.isVisible,
                            maxLines: 1,
                            suffixIcon: InkWell(
                              onTap: () {
                                if (viewModel.isVisible == false) {
                                  viewModel.setVisibleState(true);
                                } else {
                                  viewModel.setVisibleState(false);
                                }
                              },
                              child: Icon(
                                viewModel.isVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: champIconGrey,
                                size: 20.sp,
                              ),
                            ),
                            hintText: 'Enter old password',
                            validator: FieldValidator.validate,
                            controller: viewModel.passwordCrt,
                          ),
                          VSpace(20.h),
                          CustomTextFormField(
                            obscureText: viewModel.isNewPassVisible,
                            maxLines: 1,
                            suffixIcon: InkWell(
                              onTap: () {
                                if (viewModel.isNewPassVisible == false) {
                                  viewModel.setNewPassVisibleState(true);
                                } else {
                                  viewModel.setNewPassVisibleState(false);
                                }
                              },
                              child: Icon(
                                viewModel.isNewPassVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: champIconGrey,
                                size: 20.sp,
                              ),
                            ),
                            hintText: 'Enter new password',
                            validator: PasswordValidator.validatePassword,
                            controller: viewModel.newPasswordCrt,
                          ),
                          VSpace(20.h),
                          CustomTextFormField(
                            obscureText: viewModel.isConfirmPassVisible,
                            maxLines: 1,
                            suffixIcon: InkWell(
                              onTap: () {
                                if (viewModel.isConfirmPassVisible == false) {
                                  viewModel.setConfirmPassVisibleState(true);
                                } else {
                                  viewModel.setConfirmPassVisibleState(false);
                                }
                              },
                              child: Icon(
                                viewModel.isConfirmPassVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: champIconGrey,
                                size: 20.sp,
                              ),
                            ),
                            hintText: 'Confirm new password',
                            validator: PasswordValidator.validatePassword,
                            controller: viewModel.confirmPasswordCrt,
                          ),
                          VSpace(40.h),
                          CustomButton(
                              title: "Change Password",
                              isActive: true,
                              onPress: () async {
                                bool isValid = _form.currentState!.validate();
                                if (isValid) {
                                  context.loaderOverlay.show();
                                  // await Firebase.initializeApp();
                                  bool? logged = await viewModel.changePassword(
                                      context: context,
                                      cred: ChangePasswordModel(
                                          newPassword:
                                              viewModel.newPasswordCrt.text,
                                          confirmPassword:
                                              viewModel.confirmPasswordCrt.text,
                                          oldPassword:
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
