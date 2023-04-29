import 'package:champ_app/modules/auth/view_model/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pinput/pinput.dart';

import '../../core/service_injector/service_injector.dart';
import '../../router/main_router.dart';
import '../../router/route_paths.dart';
import '../../shared/utils/color.dart';
import '../../shared/utils/images.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/base_view.dart';
import '../../shared/widgets/custom_button.dart';

import '../../shared/widgets/space.dart';

class CreatePin extends StatelessWidget {
  CreatePin({Key? key}) : super(key: key);

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _pin = TextEditingController();
  final TextEditingController _confirmPin = TextEditingController();

  String? _pinValidator(_pin) {
    if (_pin == null || _pin.isEmpty) {
      return "Pin Is Required";
    }
    if (_pin.length != 4) {
      return "Pin is Invalid";
    }

    return null;
  }

  String? _confirmPinValidator(_confirmPin) {
    if (_confirmPin == null || _confirmPin.isEmpty) {
      return "Confirm pin Is Required";
    }
    if (_confirmPin.length != 4) {
      return "Confirm pin is Invalid";
    }
    print("xpin: ${_pin.text} confirm pin: $_confirmPin");
    if (_pin.text != _confirmPin) {
      return "Pins doesn't match";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      vmBuilder: (context) => AuthViewModel(authService: si.authService),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, AuthViewModel viewModel) {
    return Scaffold(
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
              padding: EdgeInsets.symmetric(horizontal: 17.5.w, vertical: 24.h),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        VSpace(44.h),
                        Image.asset(
                          pinLock,
                          height: 140.h,
                          width: 140.w,
                        ),
                        VSpace(36.h),
                        Styles.bold("Create PIN",
                            fontSize: 25.sp, color: white),
                        VSpace(11.h),
                        Styles.regular(
                            "Create a four (4) digit  PIN  for coin transfers",
                            fontSize: 12.sp,
                            color: champTextGrey),
                      ],
                    ),
                    VSpace(40.h),
                    Styles.regular("Enter PIN",
                        fontSize: 16.sp, color: champTextGrey),
                    VSpace(10.h),
                    buildPinPut(_pin, _pinValidator),
                    VSpace(40.h),
                    Styles.regular("Confirm PIN",
                        fontSize: 16.sp, color: champTextGrey),
                    VSpace(10.h),
                    buildPinPut(_confirmPin, _confirmPinValidator),
                    VSpace(60.h),
                    CustomButton(
                        title: "Save and Proceed",
                        isActive: true,
                        onPress: () async {
                          print(
                              "pin: ${_pin.text} confirm pin: ${_confirmPin.text}");
                          bool isValid = _form.currentState!.validate();
                          if (isValid) {
                            context.loaderOverlay.show();
                            bool? logged = await viewModel.createPin(context,
                                pin: _pin.text, pinConfirmed: _confirmPin.text);
                            if (logged!) {
                              context.loaderOverlay.hide();
                            } else {
                              context.loaderOverlay.hide();
                            }
                          }
                          // Navigator.push(
                          //   context,
                          //   MainRouter.generateRoute(
                          //     const RouteSettings(
                          //         name: RoutePaths.fundWallet),
                          //   ),
                          // );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPinPut(
      TextEditingController controller, String? Function(String?)? validator) {
    final defaultPinTheme = PinTheme(
      width: 70.w,
      height: 70.h,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: champTextGrey, width: 1),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: champTextGrey),
      borderRadius: BorderRadius.circular(2.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: champTextGrey,
      ),
    );

    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      controller: controller,
      validator: validator,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => debugPrint(pin),
    );
  }
}
