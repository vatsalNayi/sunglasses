import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/values/colors.dart';
import 'package:sunglasses/custom_widgets/custom_appbar.dart';
import 'package:sunglasses/custom_widgets/custom_button_comp.dart';
import 'package:sunglasses/module/checkout/widgets/address_input_field.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';
import '../../models/address_model.dart';
import '../auth/controller/auth_controller.dart';
import 'location_controller.dart';
import 'widgets/address_dropdown.dart';
//import 'package:flutter_woocommerce/view/screens/cart/model/country.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressModel? address;
  final int? index;
  final bool fromEdit;
  AddAddressScreen({this.address, this.index, this.fromEdit = false});
  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  //final TextEditingController _countryController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _phoneCodeController = TextEditingController();
  final TextEditingController _emailCodeController = TextEditingController();
  // Country? _country;
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastnameFocus = FocusNode();
  final FocusNode _streetAddressFocus = FocusNode();
  final FocusNode _streetAddress2Focus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _zipCodeFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    Get.find<LocationController>().clearCountryState();
    //Get.find<LocationController>().getUserAddress();

    print('add_address_screen_Index-->${widget.index}');

    if (widget.address != null) {
      _firstNameController.text = widget.address!.firstName ?? '';
      _lastNameController.text = widget.address!.lastName ?? '';
      _companyController.text = widget.address!.company ?? '';
      //_countryController.text = widget.address.country ?? '';
      //_country = widget.address!.country;
      _address1Controller.text = widget.address!.address1 ?? '';
      _address2Controller.text = widget.address!.address2 ?? '';
      _cityController.text = widget.address!.city ?? '';
      _zipCodeController.text = widget.address!.postcode ?? '';
      _phoneCodeController.text = widget.address!.phone ?? '';
      _emailCodeController.text = widget.address!.email ?? '';
      _address1Controller.text = widget.address!.address1 ?? '';
      _address2Controller.text = widget.address!.address2 ?? '';
      if (widget.fromEdit) {
        Get.find<LocationController>()
            .setSelectedHintCountry(widget.address!.country);
        Get.find<LocationController>()
            .setSelectedHintState(widget.address!.state);
      }
    } else if (widget.index == -1) {
      Get.find<LocationController>().setDefaultCountry();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: CustomAppBar(
            title: widget.fromEdit ? 'update_address'.tr : 'add_address'.tr),
        body: GetBuilder<LocationController>(builder: (locationController) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Center(
                        child: SizedBox(
                  width: Dimensions.WEB_MAX_WIDTH,
                  child: GetBuilder<LocationController>(
                      builder: (locationController) {
                    return Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AddressInputField(
                                title: 'first_name'.tr,
                                controller: _firstNameController,
                                focusNode: _firstNameFocus,
                                nextNode: _lastnameFocus,
                                require: true,
                                inputType: TextInputType.name,
                                validator: (value) {
                                  if (value == '') {
                                    return 'please_enter_first_name'.tr;
                                  }
                                  return null;
                                }),
                            const SizedBox(
                                width: Dimensions.PADDING_SIZE_SMALL),

                            AddressInputField(
                                title: 'last_name'.tr,
                                controller: _lastNameController,
                                focusNode: _lastnameFocus,
                                nextNode: _streetAddressFocus,
                                require: true,
                                inputType: TextInputType.name,
                                validator: (value) {
                                  if (value == '') {
                                    return 'please_enter_last_name'.tr;
                                  }
                                  return null;
                                }),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_DEFAULT),

                            Text('country'.tr,
                                style: poppinsBold.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: AppColors.primaryColor,
                                )),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_SMALL),
                            const SizedBox(
                                height: 50,
                                width: Dimensions.WEB_MAX_WIDTH,
                                child: ZoneDropdown(isCountry: true)),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_LARGE),

                            //State
                            Text('state'.tr,
                                style: poppinsBold.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: AppColors.primaryColor,
                                )),
                            const SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            const SizedBox(
                                height: 50,
                                width: Dimensions.WEB_MAX_WIDTH,
                                child: ZoneDropdown(isCountry: false)),
                            const SizedBox(
                                width: Dimensions.PADDING_SIZE_LARGE),

                            // (locationController.selectedCountry != null && locationController.stateList != null && locationController.selectedState == null) ?
                            //   Text('select_your_state'.tr, style: poppinsRegular.copyWith(color: Colors.red))
                            // : SizedBox(),

                            AddressInputField(
                                title: 'street_address'.tr,
                                controller: _address1Controller,
                                focusNode: _streetAddressFocus,
                                nextNode: _streetAddress2Focus,
                                require: true,
                                inputType: TextInputType.name,
                                validator: (value) {
                                  if (value == '') {
                                    return 'please_enter_street_address'.tr;
                                  }
                                  return null;
                                }),
                            const SizedBox(
                                width: Dimensions.PADDING_SIZE_SMALL),

                            AddressInputField(
                              title: 'street_address2'.tr,
                              controller: _address2Controller,
                              focusNode: _streetAddress2Focus,
                              nextNode: _cityFocus,
                              require: true,
                              inputType: TextInputType.name,
                            ),
                            const SizedBox(
                                width: Dimensions.PADDING_SIZE_SMALL),

                            AddressInputField(
                                title: 'city'.tr,
                                controller: _cityController,
                                focusNode: _cityFocus,
                                nextNode: _zipCodeFocus,
                                require: true,
                                inputType: TextInputType.name,
                                validator: (value) {
                                  if (value == '') {
                                    return 'please_enter_your_city_name'.tr;
                                  }
                                  return null;
                                }),
                            const SizedBox(
                                width: Dimensions.PADDING_SIZE_SMALL),

                            AddressInputField(
                                title: 'zip_code'.tr,
                                controller: _zipCodeController,
                                focusNode: _zipCodeFocus,
                                nextNode: _phoneFocus,
                                require: true,
                                inputType: TextInputType.number,
                                validator: (value) {
                                  if (value == '') {
                                    return 'please_enter_your_zip_code'.tr;
                                  }
                                  return null;
                                }),
                            const SizedBox(
                                width: Dimensions.PADDING_SIZE_SMALL),

                            AddressInputField(
                                title: 'phone_number'.tr,
                                controller: _phoneCodeController,
                                focusNode: _phoneFocus,
                                nextNode: null,
                                require: true,
                                inputType: TextInputType.phone,
                                validator: (value) {
                                  if (value == '') {
                                    return 'enter_phone_number'.tr;
                                  }
                                  return null;
                                }),
                            const SizedBox(
                                width: Dimensions.PADDING_SIZE_SMALL),

                            AddressInputField(
                                title: 'email'.tr,
                                controller: _emailCodeController,
                                focusNode: _emailFocus,
                                nextNode: null,
                                require: true,
                                inputType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.contains('@') &&
                                      !GetUtils.isEmail(value)) {
                                    return 'invalid_email_address'.tr;
                                  } else if (!value.contains('@')) {
                                    return 'invalid_email_address'.tr;
                                  } else if (value == '') {
                                    return 'enter_email_address'.tr;
                                  } else {
                                    return null;
                                  }
                                }),
                            const SizedBox(
                                width: Dimensions.PADDING_SIZE_SMALL),
                          ],
                        ),
                      ),
                    );
                  }),
                ))),
              ),
              Container(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                height: 72,
                width: Dimensions.WEB_MAX_WIDTH,
                child: CustomButtonSec(
                  radius: 50,
                  buttonText:
                      widget.fromEdit ? 'update_address'.tr : 'add_address'.tr,
                  onPressed: () {
                    bool validate = _formKey.currentState!.validate();
                    String _firstName;
                    String _lastName;
                    //String _country;
                    String _address1;
                    String _address2;
                    String _city;
                    String _postCode;
                    String _phone;
                    String _email;

                    if (validate) {
                      _firstName = _firstNameController.text.trim();
                      _lastName = _lastNameController.text.trim();
                      //_country = _countryController.text.trim();
                      _address1 = _address1Controller.text.trim();
                      _address2 = _address2Controller.text.trim();
                      _city = _cityController.text.trim();
                      _postCode = _zipCodeController.text.trim();
                      _phone = _phoneCodeController.text.trim();
                      _email = _emailCodeController.text.trim();
                      locationController.addToAddressList(
                          AddressModel(
                            id: _isLoggedIn
                                ? Get.find<AuthController>().getSavedUserId()
                                : 0,
                            firstName: _firstName,
                            lastName: _lastName,
                            address1: _address1,
                            address2: _address2,
                            city: _city,
                            postcode: _postCode,
                            phone: _phone,
                            email: _email,
                            country: widget.fromEdit
                                ? locationController.selectedCountry ??
                                    locationController.selectedHintCountry
                                : locationController.selectedCountry,
                            state: locationController.selectedState ??
                                (locationController.selectedHintState),
                          ),
                          index: widget.index);
                    }
                    // else if (locationController.selectedCountry == null) {
                    //     showCustomSnackBar('');
                    // } else if (locationController.selectedCountry != null && locationController.stateList != null && locationController.selectedState == null) {
                    //   showCustomSnackBar('select_your_state'.tr);
                    // }
                    // else {
                    //   locationController.addToAddressList( AddressModel(
                    //     firstName: _firstName, lastName: _lastName, address1: _address1, address2: _address2,
                    //     city: _city, postcode: _postCode, phone: _phone, email: _email,
                    //     country: locationController.selectedCountry ,
                    //     state: locationController.selectedState != null ? locationController.selectedState : null,
                    //   ), index: widget.index);
                    // }
                  },
                ),
              )
            ],
          );
        }));
  }
}
