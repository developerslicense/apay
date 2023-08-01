import 'package:apay/data/constants/strings.dart';
import 'package:apay/ui/screens/home/bloc/home_bloc.dart';
import 'package:apay/ui/screens/home/presentation/utils/edit_text_box_decoration.dart';
import 'package:apay/ui/screens/home/presentation/utils/read_state.dart';
import 'package:apay/ui/screens/home/presentation/utils/text_field_decorator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/utils/date_expired_mask_utils.dart';
import '../../../../data/utils/string_utils.dart';
import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class DateExpiredEditTextWidget extends StatelessWidget {
  const DateExpiredEditTextWidget({required this.focusNode, required this.focusNodeCvv, super.key});

  final FocusNode focusNode;
  final FocusNode focusNodeCvv;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: readState(context).dateExpired);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return _initTextContainer(controller, context);
      },
    );
  }

  Container _initTextContainer(TextEditingController controller, BuildContext context) {
    bool hasError = !isBlank(readState(context).dateExpiredState?.error);

    return Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            decoration: initEditTextBoxDecoration(hasError, focusNode),
            child: TextFormField(
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              controller: controller,
              inputFormatters: [
                DateExpiredMaskFormatter()
              ],
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(focusNodeCvv);
              },
              onChanged: (value) {

                addState(context, DateExpiredDataEvent(dateExpired: isBlank(value) ? '' : value));

                if (!isBlank(readState(context).cardNumberState?.error)) {
                  addState(context, const DateExpiredEvent(errorDateExpired: ''));
                }
              },
              cursorColor: ColorsSdk.colorBrandMain,
              style: Fonts.regular(),
              textInputAction: TextInputAction.next,
              decoration: inputTextFieldDecoration(
                  text: dateExpired(),
                  isError: hasError,
                  isFocused: focusNode.hasFocus,
                  afterClearText: () => addState(context, const DateExpiredDataEvent(dateExpired: '')),
                  controller: controller
              )
            ));
  }
}
