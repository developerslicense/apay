import 'package:apay/data/utils/string_utils.dart';
import 'package:apay/ui/screens/home/presentation/cvv.dart';
import 'package:apay/ui/screens/home/presentation/date_expired.dart';
import 'package:apay/ui/screens/home/presentation/switcher_send_check_to_email.dart';
import 'package:apay/ui/screens/home/presentation/swithed_save_card_data.dart';
import 'package:apay/data/constants/strings.dart';
import 'package:apay/ui/screens/home/presentation/utils/error_info.dart';
import 'package:apay/ui/screens/home/presentation/utils/read_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes/colors.dart';
import '../../themes/fonts.dart';
import '../../ui_components/circular_progress_bar.dart';
import '../dialogs/dialog_exit.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';
import 'presentation/card_number.dart';
import 'presentation/confirm_button.dart';
import 'presentation/bottom_images.dart';
import 'presentation/email.dart';
import 'presentation/name_holder.dart';
import 'presentation/top_info_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  final _emailFocusNode = FocusNode();
  final _cardNumberFocusNode = FocusNode();
  final _dateExpiredFocusNode = FocusNode();
  final _cvvFocusNode = FocusNode();

  bool _snackBarShowed = false;
  bool _isLoading = false;

  Widget? _emailTextField;
  Widget? _cvvAndDateExpired;

  Widget? _cardNumberError;
  Widget? _emailError;
  Widget? _cvvAndDateExpiredError;
  Widget? _cvvError;
  Widget? _dateExpiredError;

  final List<Widget> _widgets = [];

  @override
  void initState() {
    super.initState();

    _cvvAndDateExpired = Row(
      children: [
        Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: DateExpiredEditTextWidget(
                  focusNode: _dateExpiredFocusNode,
                  focusNodeCvv: _cvvFocusNode),
            )),
        Flexible(child: CVVEditTextWidget(
            focusNode: _cvvFocusNode,
            focusNodeEmail: _emailFocusNode)),
      ],
    );

    var tempWidgets = [
      AppBar(
        backgroundColor: ColorsSdk.bgBlock,
        leading: BackButton(
          color: ColorsSdk.iconMain,
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (_) => initDialogExit(context),
            );
          },
        ),
        title: Text(paymentOfPurchase(), style: const TextStyle(color: ColorsSdk.textMain)),
      ),
      const TopInfoWidget(),
      CardNumberEditTextWidget(
          focusNode: _cardNumberFocusNode,
          focusNodeNameHolder: _dateExpiredFocusNode),
      const SizedBox(height: 16),
      _cvvAndDateExpired!,
      const SizedBox(height: 37.0),
      Row(
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  saveCardData(),
                  style: Fonts.regular(),
            ),
          )),
          const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: SwitchedSaveCardDataWidget())
        ],
      ),
      const SizedBox(height: 24.0),
      Row(
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  sendCheckToEmail(),
                  style: Fonts.regular(),
            ),
          )),
          const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: SwitchedSendCheckToEmailWidget())
        ],
      ),
      const HomeBottomImages(),
    ];

    _widgets.addAll(tempWidgets);

    _cardNumberFocusNode.addListener(() {
      addState(context, CardNumberEvent(errorCardNumber: readState(context).cardNumberState?.error));
    });

    _dateExpiredFocusNode.addListener(() {
      addState(context, DateExpiredEvent(errorDateExpired: readState(context).dateExpiredState?.error));
    });

    _cvvFocusNode.addListener(() {
      addState(context, CvvEvent(errorCvv: readState(context).cvvState?.error));
    });

    _emailFocusNode.addListener(() {
      addState(context, EmailEvent(switched: true, errorEmail: readState(context).emailState?.error));
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _cardNumberFocusNode.dispose();
    _dateExpiredFocusNode.dispose();
    _cvvFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeBloc(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          showDialog<void>(
            context: context,
            builder: (_) => initDialogExit(context),
          );

          return Future.value(false);
        },
        child: BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {

              if (state.saveCardData && !_snackBarShowed) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(cardDataSaved())),
                  );
                _snackBarShowed = true;

              } else if (!state.saveCardData) {
                _snackBarShowed = false;
              }

              if (state.isPaymentProcessing && !_isLoading) {
                _isLoading = true;
              } else if (!state.isPaymentProcessing && _isLoading) {
                _isLoading = false;
              }

              setState(() {
                _initWidgetCardNumber(state);
                _initWidgetDateExpiredAndCvvError(state);
                _initWidgetDateExpiredError(state);
                _initWidgetCvvError(state);
                _initWidgetEmail(state);

              });

            },
            child: _initStack(context)));
  }

  Widget _initStack(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsSdk.bgBlock,
        body: Stack(children: [
          ListView.builder(
                 controller: _controller,
                 itemCount: _widgets.length,
                 itemBuilder: (context, index) {
                   return _widgets[index];
                 }),
           initConfirmButton(context),
           _isLoading ? const Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: ProgressDialogPrimary()) : const SizedBox()
    ]));
  }

  void _initWidgetCardNumber(HomeState state) {
    if (!isBlank(state.cardNumberState?.error)
        && _cardNumberError == null) {
      _cardNumberError = initErrorInfoField(state.cardNumberState!.error!);
      _widgets.insert(4, _cardNumberError!);

    } else if (isBlank(state.cardNumberState?.error)
        && _cardNumberError != null) {
      _widgets.remove(_cardNumberError);
      _cardNumberError = null;

    }
  }

  void _initWidgetDateExpiredAndCvvError(HomeState state) {
    if (!isBlank(state.cvvState?.error)
        && !isBlank(state.dateExpiredState?.error)
        && _cvvAndDateExpiredError == null) {

      int position = _calculateDateExpiredAndCvvErrorPosition();

      _widgets.remove(_cvvError);
      _widgets.remove(_dateExpiredError);
      _cvvError = null;
      _dateExpiredError = null;
      _cvvAndDateExpiredError = _initCvvAndDateExpiredErrors(
        cvvError: state.cvvState?.error,
        dateExpiredError: state.dateExpiredState?.error,
      );
      _widgets.insert(position, _cvvAndDateExpiredError!);

    } else if (isBlank(state.cvvState?.error)
        && isBlank(state.dateExpiredState?.error)
        && _cvvAndDateExpiredError != null) {
      _widgets.remove(_cvvAndDateExpiredError);
      _cvvAndDateExpiredError = null;
    }
  }

  void _initWidgetDateExpiredError(HomeState state) {
    if (!isBlank(state.dateExpiredState?.error)
        && isBlank(state.cvvState?.error)
        && _dateExpiredError == null) {

      int position = _calculateDateExpiredAndCvvErrorPosition();

      _widgets.remove(_cvvError);
      _widgets.remove(_cvvAndDateExpiredError);
      _cvvError = null;
      _cvvAndDateExpiredError = null;
      _dateExpiredError = _initCvvAndDateExpiredErrors(
        dateExpiredError: state.dateExpiredState?.error,
      );
      _widgets.insert(position, _dateExpiredError!);

    } else if (isBlank(state.dateExpiredState?.error)
        && isBlank(state.cvvState?.error)
        && _dateExpiredError != null) {
      _widgets.remove(_dateExpiredError);
      _dateExpiredError = null;
    }
  }

  void _initWidgetCvvError(HomeState state) {
    if (!isBlank(state.cvvState?.error)
        && isBlank(state.dateExpiredState?.error)
        && _cvvError == null) {

      int position = _calculateDateExpiredAndCvvErrorPosition();

      _widgets.remove(_cvvAndDateExpiredError);
      _widgets.remove(_dateExpiredError);
      _cvvAndDateExpiredError = null;
      _dateExpiredError = null;
      _cvvError = _initCvvAndDateExpiredErrors(
        cvvError: state.cvvState?.error,
      );
      _widgets.insert(position, _cvvError!);

    } else if (isBlank(state.cvvState?.error)
        && isBlank(state.dateExpiredState?.error)
        && _cvvError != null) {
      _widgets.remove(_cvvError);
      _cvvError = null;
    }
  }

  Row _initCvvAndDateExpiredErrors({
      String? cvvError,
      String? dateExpiredError}
  ) {
    return Row(
        children: [
          Flexible(child: initErrorInfoField(dateExpiredError)),
          Flexible(child: initErrorInfoField(cvvError)),
        ]);
  }

  int _calculateDateExpiredAndCvvErrorPosition() {
    int position = 6;
    if (_cardNumberError != null) {
      position+=1;
    }
    return position;
  }

  void _initWidgetEmail(HomeState state) {
    if (state.emailState?.switched == true) {
      _initEmailField();

      if (!isBlank(state.emailState?.error)
          && _emailError == null) {
        _emailError = initErrorInfoField(wrongEmail());
        _widgets.insert(_widgets.length-1, _emailError!);

      } else if (isBlank(state.emailState?.error)
          && _emailError != null) {
        _widgets.remove(_emailError);
        _emailError = null;
      }

    } else if (state.emailState?.switched == false) {
      _widgets.remove(_emailError);
      _removeEmailField();
      _emailError = null;
    }
  }

  void _initEmailField() {
    if (_emailTextField == null) {
      _emailTextField = Column(
          children: [
            const SizedBox(height: 41.0),
            EmailEditTextWidget(focusNode: _emailFocusNode)
          ]);

      var email = Column(
        children: [
          _emailTextField!
        ],
      );

      _widgets.insert(_widgets.length-1, email);

      wait(Function() requestFocusOperation) async {
        await Future.delayed(const Duration(milliseconds: 250));
        requestFocusOperation();
      }
      wait(
          () => FocusScope.of(context).requestFocus(_emailFocusNode)
      );
    }
  }

  void _removeEmailField() {
    if (_emailTextField != null) {
      _widgets.removeAt(_widgets.length-2);
      _emailTextField = null;
    }
  }
}
