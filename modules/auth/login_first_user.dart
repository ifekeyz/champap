import 'package:champ_app/modules/auth/view_model/auth_vm.dart';
import 'package:champ_app/modules/auth/widgets/auth_options.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/widgets/custom_button.dart';
import 'package:champ_app/shared/widgets/custom_text_form_field.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../core/service_injector/service_injector.dart';
import '../../router/main_router.dart';
import '../../router/route_paths.dart';
import '../../shared/models/login_model.dart';
import '../../shared/utils/validator.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/loading_overlay.dart';

class LoginFirstUser extends StatefulWidget {
  const LoginFirstUser({Key? key}) : super(key: key);

  @override
  _LoginFirstUserState createState() => _LoginFirstUserState();
}

class _LoginFirstUserState extends State<LoginFirstUser> {
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
        text: "Authenticating ...",
      ),
      overlayOpacity: 0.8,
      child: Scaffold(
        backgroundColor: black,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              VSpace(24.h),
                              Image.asset(
                                logoImg,
                                height: 76.h,
                                width: 80.57.w,
                              ),
                              VSpace(36.h),
                              Styles.bold("Sign In",
                                  fontSize: 25.sp, color: white),
                              VSpace(5.h),
                              Styles.regular(
                                  "Please sign in with your email address or username",
                                  fontSize: 12.sp,
                                  color: champTextGrey),
                            ],
                          ),
                          VSpace(44.h),
                          CustomTextFormField(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(userIcon,
                                  height: 14.h, width: 14.w),
                            ),
                            hintText: 'Enter email address ',
                            validator: EmailValidator.validateEmail,
                            controller: viewModel.emailCrt,
                          ),
                          VSpace(20.h),
                          CustomTextFormField(
                            obscureText: viewModel.isVisible,
                            maxLines: 1,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(lockIcon,
                                  height: 14.h, width: 14.w),
                            ),
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
                            hintText: 'Enter password',
                            validator: PasswordValidator.validateLoginPassword,
                            controller: viewModel.passwordCrt,
                          ),
                          VSpace(10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: champIconGrey),
                                child: Checkbox(
                                  activeColor: primaryColor,
                                  value: viewModel.saveCredentials,
                                  onChanged: (bool? value) {
                                    viewModel.toggleSaveCredentials(value);
                                  },
                                ),
                              ),
                              HSpace(4.w),
                              Styles.semiBold("Remember login",
                                  color: primaryColor, fontSize: 12.sp),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Styles.semiBold("Forgot Password?",
                          //         color: primaryColor, fontSize: 12.sp),
                          //   ],
                          // ),
                          VSpace(40.h),
                          CustomButton(
                              title: "Log In",
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
                          VSpace(25.h),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                  margin:
                                      EdgeInsets.only(left: 0.0, right: 20.0.w),
                                  child: Divider(
                                    color: champTextGrey,
                                    thickness: 1.sp,
                                    height: 36.h,
                                  )),
                            ),
                            Styles.regular('Or login with',
                                fontSize: 12.sp, color: champTextGrey),
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 0.0),
                                  child: const Divider(
                                    color: champTextGrey,
                                    thickness: 1,
                                    height: 36,
                                  )),
                            ),
                          ]),
                          VSpace(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AuthOptions(
                                routeText: 'Facebook',
                                imageURL: facebook,
                                onTap: () {
                                  viewModel.initiateFacebookLogin(context);
                                },
                              ),
                              AuthOptions(
                                routeText: 'Google',
                                imageURL: google,
                                onTap: () async {
                                  await Firebase.initializeApp();
                                  viewModel.initiateGoogleLogin(context);
                                },
                              )
                            ],
                          ),
                          VSpace(60.h),
                          SizedBox(
                            width: deviceWidth(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Styles.semiBold(
                                  "Don’t have an account? ",
                                  color: champTextGrey,
                                  fontSize: 14.sp,
                                ),
                                HSpace(3.w),
                                GestureDetector(
                                  onTap: (() => Navigator.push(
                                        context,
                                        MainRouter.generateRoute(
                                          const RouteSettings(
                                              name: RoutePaths.signUp),
                                        ),
                                      )),
                                  child: Styles.semiBold(
                                    "Create One",
                                    color: primaryColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
