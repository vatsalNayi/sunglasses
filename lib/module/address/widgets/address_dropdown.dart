import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/models/state.dart' as st;
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/dimensions.dart';
import '../../../models/country.dart';
import '../location_controller.dart';

class ZoneDropdown extends StatelessWidget {
  final bool isCountry;
  const ZoneDropdown({Key? key, this.isCountry = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_SMALL),
        //margin: isCountry? EdgeInsets.only(right : Dimensions.PADDING_SIZE_EXTRA_SMALL) : EdgeInsets.only(left : Dimensions.PADDING_SIZE_EXTRA_SMALL),
        height: 50,
        width: Dimensions.WEB_MAX_WIDTH,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColorLight.withOpacity(0.20)),
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
        ),

        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            value: isCountry
                ? locationController.selectedCountry
                : locationController.selectedState,
            hint: Text(isCountry
                ? locationController.selectedHintCountry != null
                    ? locationController.selectedHintCountry!.name!
                    : ''
                : locationController.selectedHintState != null
                    ? locationController.selectedHintState!.name!
                    : ''),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: isCountry
                ? locationController.countryList!
                    .map<DropdownMenuItem<Country>>((Country value) {
                    return DropdownMenuItem<Country>(
                      value: value,
                      child: Text(value.name!),
                    );
                  }).toList()
                : locationController.dropdownStateList
                    .map<DropdownMenuItem<st.State>>((st.State value) {
                    return DropdownMenuItem<st.State>(
                      value: value,
                      child: Text(value.name!),
                    );
                  }).toList(),
            //  (isCountry && AppConstants.isCountryFixed) ? null :
            onChanged: (isCountry && AppConstants.isCountryFixed)
                ? null
                : (dynamic newValue) {
                    if (isCountry) {
                      locationController.setSelectedCountry(newValue);
                    } else {
                      locationController.setSelectedState(newValue);
                    }
                  },
          ),
        ),
      );
    });
  }
}
