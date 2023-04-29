import 'package:champ_app/modules/auth/view_model/auth_vm.dart';
import 'package:champ_app/modules/auth/widgets/auth_options.dart';
import 'package:champ_app/modules/home_module/widgets/explore_champ_app.dart';
import 'package:champ_app/shared/utils/color.dart';
import 'package:champ_app/shared/utils/images.dart';
import 'package:champ_app/shared/utils/utils.dart';
import 'package:champ_app/shared/utils/validator.dart';
import 'package:champ_app/shared/widgets/custom_button.dart';
import 'package:champ_app/shared/widgets/custom_text_form_field.dart';
import 'package:champ_app/shared/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:video_player/video_player.dart';

import '../../core/service_injector/service_injector.dart';
import '../../router/main_router.dart';
import '../../router/route_paths.dart';
import '../../shared/models/registration_model.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/loading_overlay.dart';



class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser>{
  @override
VideoPlayerController _controller = VideoPlayerController.network('');
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      vmBuilder: (context) => AuthViewModel(authService: si.authService),
      builder: _buildScreen,
    );
  }
  bool avatar_visibility = true;
  Widget _buildScreen(BuildContext context, AuthViewModel viewModel) {
    return
      LoaderOverlay(
      useDefaultLoading: true,
      overlayWidget: const LoadingOverlay(
        image: logoImg,
        text: "Signing up ...",
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
                  child: Container(
                    child: Form(
                      key: viewModel.form,
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
                                Styles.bold("Register",
                                    fontSize: 25.sp, color: white),
                                VSpace(5.h),
                                Styles.regular(
                                    "Fill in your details below to register",
                                    fontSize: 12.sp,
                                    color: white),
                              ],
                            ),
                            VSpace(44.h),
                            CustomTextFormField(
                              hintText: 'Full Name (eg: Firstname   Lastname)',
                              controller: viewModel.fullNameCrt,
                              validator: FieldValidator.validate,
                            ),
                            VSpace(20.h),
                            CustomTextFormField(
                              hintText: 'Email Address',
                              validator: EmailValidator.validateEmail,
                              controller: viewModel.emailCrt,
                            ),
                            VSpace(20.h),
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
                              hintText: 'Password',
                              validator: PasswordValidator.validatePassword,
                              controller: viewModel.passwordCrt,
                            ),


                            VSpace(20.h),
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
                              hintText: 'Confirm Password',
                              validator: PasswordValidator.validatePassword,
                              controller: viewModel.confirmPasswordCrt,
                            ),
                            VSpace(20.h),
                            CustomTextFormField(
                              hintText: 'Pick A Unique Nickname',
                              controller: viewModel.usernameCrt,
                              validator: UsernameValidator.validateUsername,
                            ),
                            VSpace(20.h),
                            CustomTextFormField(
                              hintText: 'Referral (optional)',
                              controller: viewModel.refEmailCrt,
                            ),

                            VSpace(20.h),
                            ElevatedButton(
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    backgroundColor: Color(0x33010101),
                                    actions: <Widget>[
                                      exploreChampApp(context: context, videoPlayerController: _controller, initializeVideoPlayerFuture: _controller.initialize(), onPressed: (){})
                                    ],
                                  ),
                                ),

                                // onPressed: (){
                                //     // avatar_visibility = ! avatar_visibility;
                                //    //8914245341 sterling bank
                                //   Navigator.pushReplacement(
                                //     context,
                                //     MainRouter.generateRoute(
                                //       const RouteSettings(name: RoutePaths.welcome),
                                //     ),
                                //   );
                                // },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.all(6)),
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        Color(0x1f2E94BF)
                                    )),

                                child: Text('Choose Avatar', style:TextStyle(
                                    color: Color(0xFFffffff),
                                    fontSize: 16.sp, fontWeight: FontWeight.bold),)
                            ),
                            VSpace(10.h),
                            Visibility(

                              child: Container(
                                width: deviceWidth(context),
                                height: 180.h,

                                decoration: BoxDecoration( color: Color(0x27010101),borderRadius: BorderRadius.circular(4)),

                                child:
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              c1,
                                              height: 76.h,
                                              width: 80.57.w,
                                            ),
                                            Image.asset(
                                              c1f,
                                              height: 76.h,
                                              width: 80.57.w,
                                            ),
                                            Image.asset(
                                              c2,
                                              height: 76.h,
                                              width: 80.57.w,
                                            ),
                                            Image.asset(
                                              c2f,
                                              height: 76.h,
                                              width: 80.57.w,
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              c3,
                                              height: 76.h,
                                              width: 80.57.w,
                                            ),
                                            Image.asset(
                                              c3f,
                                              height: 76.h,
                                              width: 80.57.w,
                                            ),
                                            Image.asset(
                                              c4,
                                              height: 76.h,
                                              width: 80.57.w,
                                            ),
                                            Image.asset(
                                              c4f,
                                              height: 76.h,
                                              width: 80.57.w,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                              ),
                              maintainSize: false,
                              maintainAnimation: true,
                              maintainState: true,
                              visible: true,//avatar_visibility,

                            ),

                            VSpace(60.h),
                            CustomButton(
                                title: "Create Account",
                                isActive: true,
                                onPress: () async {
                                  bool isValid =
                                      viewModel.form.currentState!.validate();
                                  if (isValid) {
                                    context.loaderOverlay.show();
                                    bool? registered = await viewModel.register(
                                        context,
                                        cred: RegModel(
                                            email:
                                                viewModel.emailCrt.text.trim(),
                                            password:
                                                viewModel.passwordCrt.text,
                                            username:
                                                viewModel.usernameCrt.text,
                                            fullname:
                                                viewModel.fullNameCrt.text,
                                            referrer_username: viewModel
                                                .refEmailCrt.text
                                                .trim(),
                                            avatar:'',
                                            password_confirmation: viewModel
                                                .confirmPasswordCrt.text));


                                    // if (registered!) {
                                    //   context.loaderOverlay.hide();
                                    // } else {
                                    //   context.loaderOverlay.hide();
                                    // }
                                  }
                                }),
                            VSpace(25.h),
                            Row(children: <Widget>[
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: 0.0, right: 20.0.w),
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
                                      context.loaderOverlay.show();
                                      viewModel.initiateFacebookLogin(context);
                                    }),
                                AuthOptions(
                                    routeText: 'Google',
                                    imageURL: google,
                                    onTap: () {
                                      context.loaderOverlay.show();
                                      viewModel.initiateGoogleLogin(context);
                                    })
                              ],
                            ),
                            VSpace(60.h),
                            SizedBox(
                              width: deviceWidth(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Styles.semiBold(
                                    "Already have an account?",
                                    color: champTextGrey,
                                    fontSize: 14.sp,
                                  ),
                                  HSpace(3.w),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MainRouter.generateRoute(
                                        const RouteSettings(
                                            name: RoutePaths.login),
                                      ),
                                    ),
                                    child: Styles.semiBold(
                                      "Sign In",
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
              ),
            )),
      ),
    );
  }
}
