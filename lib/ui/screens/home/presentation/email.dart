import 'package:apay/data/constants/strings.dart';
import 'package:apay/ui/screens/home/bloc/home_bloc.dart';
import 'package:apay/ui/screens/home/presentation/utils/edit_text_box_decoration.dart';
import 'package:apay/ui/screens/home/presentation/utils/read_state.dart';
import 'package:apay/ui/screens/home/presentation/utils/text_field_decorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_holder.dart';
import '../../../../data/utils/string_utils.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

bool _isFirstInit = true;

class EmailEditTextWidget extends StatelessWidget {
  const EmailEditTextWidget({required this.focusNode, super.key});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(
        text: _isFirstInit ? DataHolder.userEmail : readState(context).email
    );

    if (_isFirstInit) {
      _isFirstInit = false;
      addState(context, EmailDataEvent(email: DataHolder.userEmail));
    }

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return _initTextContainer(controller, state, context);
      },
    );
  }

  Container _initTextContainer(
      TextEditingController controller,
      HomeState state,
      BuildContext context) {

    bool hasError = !isBlank(readState(context).emailState?.error);

    return Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          margin: const EdgeInsets.only(right: 16, left: 16),
          decoration: initEditTextBoxDecoration(hasError, focusNode),
          child: TextField(
            focusNode: focusNode,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              addState(context, EmailDataEvent(email: isBlank(value) ? '' : value));

              if (!isBlank(readState(context).cardNumberState?.error)) {
                addState(context, const EmailEvent(errorEmail: '', switched: true));
              }
            },
            controller: controller,
            cursorColor: ColorsSdk.colorBrandMain,
            style: Fonts.regular(),
            textInputAction: TextInputAction.done,
            decoration: inputTextFieldDecoration(
                text: email(),
                isError: hasError,
                isFocused: focusNode.hasFocus,
                afterClearText: () => addState(context, const EmailDataEvent(email: '')),
                controller: controller
            )
          ));
  }
}
