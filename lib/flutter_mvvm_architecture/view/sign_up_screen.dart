import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../resources/componnets/custom_button.dart';
import '../resources/componnets/custom_field.dart';
import '../resources/componnets/custom_sizebox.dart';
import '../resources/componnets/custom_snackbar.dart';
import '../resources/componnets/custom_text.dart';
import '../resources/componnets/validators.dart';
import '../resources/utils/routes_name.dart';
import '../resources/utils/styles.dart';
import '../resources/utils/utils.dart';
import '../view_model/auth_viewmodel.dart';

class SignUpScreenMvvm extends StatefulWidget {
  const SignUpScreenMvvm({super.key});

  @override
  State<SignUpScreenMvvm> createState() => _SignUpScreenMvvmState();
}

class _SignUpScreenMvvmState extends State<SignUpScreenMvvm> {
  //use of provider here
  final ValueNotifier _obsecureText = ValueNotifier<bool>(true);

  FocusNode email = FocusNode();
  FocusNode pass = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.kdarkBlueColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Space(height: MediaQuery.of(context).size.height / 4),
                const CustomText(
                  text: 'Welcome',
                  color: Colors.white,
                  weight: FontWeight.w700,
                  size: 22,
                ),
                const Space(height: 10),
                const CustomText(
                  text: 'Please sign up your account',
                  color: AppColors.kgreyColor,
                  weight: FontWeight.w600,
                  size: 14,
                ),
                const Space(height: 60),
                CustomTextField(
                  fillColor: AppColors.ktextFieldColor,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 25.0,
                    horizontal: 10.0,
                  ),
                  enabledBorder: AppStyles.border,
                  border: AppStyles.border,
                  focusedBorder: AppStyles.border,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  hintStyle: const TextStyle(
                    color: AppColors.kgreyColor,
                    fontSize: 12,
                  ),
                  controller: emailController,
                  validator: AppValidators.validator,
                  focusNode: email,
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(context, email, pass);
                  },
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                ),
                const Space(height: 10),

                ///use of provider
                ValueListenableBuilder(
                  valueListenable: _obsecureText,
                  builder: (context, value, child) {
                    return CustomTextField(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 25.0,
                        horizontal: 10.0,
                      ),
                      fillColor: AppColors.ktextFieldColor,
                      filled: true,
                      enabledBorder: AppStyles.border,
                      border: AppStyles.border,
                      focusedBorder: AppStyles.border,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      hintStyle: const TextStyle(
                        color: AppColors.kgreyColor,
                        fontSize: 12,
                      ),
                      validator: AppValidators.validator,
                      focusNode: pass,
                      controller: passwordController,
                      obscureText: _obsecureText.value,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _obsecureText.value = !_obsecureText.value;
                        },
                        child: Icon(
                          _obsecureText.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.kbuttonColor,
                        ),
                      ),
                      hintText: 'Pasword',
                    );
                  },
                ),
                const Space(height: 16),
                CustomButton(
                  color: AppColors.kbuttonColor,
                  loading: authViewModel.isLoading,
                  text: 'Sign Up',
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        Map data = {
                          "email": emailController.text,
                          "password": passwordController.text
                        };
                        authViewModel.signUpApi(context, data);
                      } else {
                        showSnackBar(context, 'Fields are required');
                      }
                    }
                  },
                ),
                Space(height: MediaQuery.of(context).size.height * 0.22),
                GestureDetector(
                  onTap: () => context.go(RoutesName.login),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Already have an account ?',
                        color: Colors.white,
                      ),
                      CustomText(
                        text: ' Sign In',
                        color: AppColors.kbuttonColor,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
