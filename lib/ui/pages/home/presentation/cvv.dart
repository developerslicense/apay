import 'package:apay/data/constants/strings.dart';
import 'package:apay/ui/pages/home/bloc/home_bloc.dart';
import 'package:apay/ui/pages/home/presentation/utils/edit_text_box_decoration.dart';
import 'package:apay/ui/pages/home/presentation/utils/read_state.dart';
import 'package:apay/ui/pages/home/presentation/utils/text_field_decorator.dart';
import 'package:apay/ui/ui_components/bottom_sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/utils/string_utils.dart';
import '../../../resources/colors_sdk.dart';
import '../../../resources/fonts.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class CVVEditTextWidget extends StatelessWidget {
  const CVVEditTextWidget({required this.focusNode, required this.focusNodeEmail, super.key});

  final FocusNode focusNode;
  final FocusNode focusNodeEmail;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: readState(context).cvv);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return _initTextContainer(controller, context);
      },
    );
  }

  Container _initTextContainer(
      TextEditingController controller,
      BuildContext context) {
    bool hasError = !isBlank(readState(context).cvvState?.error);

    return Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              margin: const EdgeInsets.only(right: 16, left: 16),
              decoration: initEditTextBoxDecoration(hasError, focusNode),
              child: TextFormField(
                focusNode: focusNode,
                keyboardType: TextInputType.number,
                controller: controller,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                maxLength: 3,
                onFieldSubmitted: (v){
                  FocusScope.of(context).requestFocus(focusNodeEmail);
                },
                onChanged: (value) {

                  addState(context, CvvDataEvent(cvv: isBlank(value) ? '' : value));

                  if (!isBlank(readState(context).cardNumberState?.error)) {
                    addState(context, const CvvEvent(errorCvv: ''));
                  }
                },
                cursorColor: ColorsSdk.colorBrandMain,
                style: Fonts.regular(),
                textInputAction: TextInputAction.next,
                decoration: inputTextFieldDecoration(
                    text: cvv(),
                    isFocused: focusNode.hasFocus,
                    controller: controller,
                    isError: hasError,
                    afterClearText: () => addState(context, const CvvDataEvent(cvv: '')),
                    prefix: InkWell(
                        onTap: () {
                          _onClickShowCvvInfo(context);
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(top: 13, bottom: 13, right: 10),
                            child: SvgPicture.asset('assets/images/hint.svg')
                        )),
                )));
  }

  void _onClickShowCvvInfo(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: ColorsSdk.bgBlock,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      initHeader(
                          title: cvv(),
                          actionClose: () => {
                            Navigator.of(context).pop()
                          }
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22, bottom: 32, right: 16, left: 16),
                        child: Text(
                            cvvInfo(),
                            style: Fonts.regular(),
                          )
                      )
                    ]
                ),
              )
            ]
          );
        });
  }
}
