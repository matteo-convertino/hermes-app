import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hermes_app/bloc/login/login_state.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          if (number.phoneNumber != null) {
            context
                .read<LoginBloc>()
                .add(PhoneNumberChanged(phoneNumber: number.phoneNumber!));
          }
        },
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          useBottomSheetSafeArea: true,
          trailingSpace: false,
          setSelectorButtonAsPrefixIcon: true,
          leadingPadding: 15,
        ),
        searchBoxDecoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: "Search",
        ),
        spaceBetweenSelectorAndTextField: 0.0,
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        initialValue: PhoneNumber(isoCode: 'IT'),
        formatInput: true,
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        inputDecoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: 'Phone number',
          suffixIcon: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return IconButton(
                splashRadius: 20,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (!state.isLoading) {
                    context.read<LoginBloc>().add(PhoneNumberSubmit());
                  }
                },
                icon: const Icon(Icons.arrow_forward),
              );
            },
          ),
        ),
      ),
    );
  }
}
