import 'package:apay/ui/screens/home/bloc/home_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';
import '../../bloc/home_state.dart';

HomeState readState(BuildContext context) => context.read<HomeBloc>().state;
void addState(BuildContext context, HomeEvent event) { context.read<HomeBloc>().add(event); }
