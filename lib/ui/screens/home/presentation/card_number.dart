import 'package:apay/data/constants/strings.dart';
import 'package:apay/ui/screens/home/bloc/home_bloc.dart';
import 'package:apay/ui/screens/home/presentation/utils/edit_text_box_decoration.dart';
import 'package:apay/ui/screens/home/presentation/utils/read_state.dart';
import 'package:apay/ui/screens/home/presentation/utils/text_field_decorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/utils/card_utils/cart_utils.dart';
import '../../../../data/utils/mask_utils.dart';
import '../../../../data/utils/string_utils.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class CardNumberEditTextWidget extends StatelessWidget {
   CardNumberEditTextWidget({required this.focusNode, required this.focusNodeNameHolder, super.key});

  final FocusNode focusNode;
  final FocusNode focusNodeNameHolder;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return _initCardNumberContainer(context, controller);
      },
    );
  }

  Container _initCardNumberContainer(BuildContext context, TextEditingController controller) {

    bool hasError = !isBlank(readState(context).cardNumberState?.error);
    String? iconPaymentSystem = readState(context).iconPaymentSystem;

    return Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            margin: const EdgeInsets.only(right: 16, left: 16),
            decoration: initEditTextBoxDecoration(hasError, focusNode),
            child: TextFormField(
              inputFormatters: [
                MaskFormatter('AAAA AAAA AAAA AAAA')
              ],
              controller: controller,
              onFieldSubmitted: (v){
                FocusScope.of(context).requestFocus(focusNodeNameHolder);
              },
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                addState(context, CardNumberDataEvent(
                    cardNumber: isBlank(value) ? '' : value,
                    iconPaymentSystem: getCardTypeFromNumber(value).icon
                ));

                if (!isBlank(readState(context).cardNumberState?.error)) {
                  addState(context, const CardNumberEvent(errorCardNumber: ''));
                }
              },
              cursorColor: ColorsSdk.mainBrand,
              style: Fonts.regular(),
              textInputAction: TextInputAction.next,
              decoration: inputTextFieldDecoration(
                  text: cardNumber(),
                  iconPaymentSystem: iconPaymentSystem,
                  isFocused: focusNode.hasFocus,
                  controller: controller,
                  isError: hasError,
                  afterClearText: () => addState(context, const CardNumberDataEvent(cardNumber: '')),
                  needSuffixExtended: true
              )
            ));
  }
}
