import 'package:apay/data/constants/strings.dart';
import 'package:apay/ui/pages/home/bloc/home_bloc.dart';
import 'package:apay/ui/pages/home/presentation/utils/edit_text_box_decoration.dart';
import 'package:apay/ui/pages/home/presentation/utils/read_state.dart';
import 'package:apay/ui/pages/home/presentation/utils/text_field_decorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/utils/string_utils.dart';
import '../../../resources/colors_sdk.dart';
import '../../../resources/fonts.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class NameHolderEditTextWidget extends StatelessWidget {
  const NameHolderEditTextWidget({required this.focusNode, required this.focusNodeDateExpired, super.key});

  final FocusNode focusNode;
  final FocusNode focusNodeDateExpired;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: readState(context).nameHolder);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return _initTextContainer(controller, context);
      },
    );
  }

  Container _initTextContainer(
      TextEditingController controller,
      BuildContext context) {

    bool hasError = !isBlank(readState(context).nameHolderState?.error);

    return Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          margin: const EdgeInsets.only(right: 16, left: 16),
          decoration: initEditTextBoxDecoration(hasError, focusNode),
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            textCapitalization: TextCapitalization.characters,
            keyboardType: TextInputType.text,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z -]")),
            ],
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(focusNodeDateExpired);
            },
            onChanged: (value) {

              addState(context, NameHolderDataEvent(nameHolder: isBlank(value) ? '' : value));

              if (!isBlank(readState(context).cardNumberState?.error)) {
                addState(context, const NameHolderEvent(errorNameHolder: ''));
              }
            },
            cursorColor: ColorsSdk.colorBrandMain,
            style: Fonts.regular(),
            textInputAction: TextInputAction.next,
            decoration: inputTextFieldDecoration(
                isError: hasError,
                text: holderName(),
                isFocused: focusNode.hasFocus,
                afterClearText: () => addState(context, const NameHolderDataEvent(nameHolder: '')),
                controller: controller),
          )
      );
  }
}
