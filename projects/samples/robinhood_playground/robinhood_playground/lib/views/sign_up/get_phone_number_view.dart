import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robinhood_playground/core/constant/padding.dart';
import 'package:robinhood_playground/core/data/model/user.dart';
import 'package:robinhood_playground/core/data/service/api.service.dart';
import 'package:robinhood_playground/core/widget/button/general_button.dart';
import 'package:robinhood_playground/product/navigator/navigator_routes.dart';
import 'package:robinhood_playground/provider/country_code_provider.dart';
import 'package:robinhood_playground/user_cache/shared_keys.dart';
import 'package:robinhood_playground/user_cache/shared_manager.dart';
import 'package:robinhood_playground/widget/signup/phone_code_sheet.dart';
import 'package:robinhood_playground/widget/signup/sign_up_description.dart';
import 'package:robinhood_playground/widget/signup/sign_up_title.dart';
import 'package:robinhood_playground/widget/signup/phone_number_textfield.dart';

class GetTelephoneNumberView extends StatefulWidget {
  const GetTelephoneNumberView({super.key});

  @override
  State<GetTelephoneNumberView> createState() => _GetTelephoneNumberViewState();
}

class _GetTelephoneNumberViewState extends State<GetTelephoneNumberView> {
  final TextEditingController _telephoneController = TextEditingController();
  bool _isActive = false;

  _isActiveControl() {
    _telephoneController.text.isNotEmpty ? _isActive = true : _isActive = false;
  }

  @override
  void initState() {
    super.initState();
    _telephoneController.addListener(() {
      setState(() {
        _isActiveControl();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _telephoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: GeneralPadding().generalHorizontal,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SignUpTitle(
            title: _TelephoneNumberText.title,
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
            child: const SignUpDescription(
                description: _TelephoneNumberText.description),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: TelephoneNumberTextField(
                telephoneController: _telephoneController),
          ),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return const PhoneCodeSheet();
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                child: Text(
                  _TelephoneNumberText.change,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )),
          Opacity(
            opacity: _isActive ? 1 : 0.2,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.095),
              child: GenerealButton(
                text: _TelephoneNumberText.continueButton,
                backgroundColor: GeneralButtonColor.black.getColor(),
                onPressed: _saveAndNavigate,
              ),
            ),
          )
        ]),
      ),
    );
  }

  void _saveAndNavigate() async {
    String phoneNumber =
        context.read<CountryCodeProvider>().currentCountryCode +
            _telephoneController.text;
    SharedManager.instance.setStringValue(SharedKeys.phoneNumber, phoneNumber);
    UserModel user = getUserInformation();
    await ApiService().postUser(user);
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(NavigateRoutes.homepage.name);
    }
  }

  UserModel getUserInformation() {
    return UserModel(
      email: SharedManager.instance.getStringValue(SharedKeys.email),
      password: SharedManager.instance.getStringValue(SharedKeys.password),
      firstName: SharedManager.instance.getStringValue(SharedKeys.firstName),
      lastName: SharedManager.instance.getStringValue(SharedKeys.lastName),
      telephoneNumber:
          SharedManager.instance.getStringValue(SharedKeys.phoneNumber),
    );
  }
}

class _TelephoneNumberText {
  static const String title = 'What\'s your phone number?';
  static const String description =
      'We\'ll send you six-digit code, It expires 10\nminitues after you request it.';
  static const String change = 'Change country code';
  static const String continueButton = 'Continue';
}
