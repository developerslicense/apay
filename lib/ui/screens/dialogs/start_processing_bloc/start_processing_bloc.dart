import 'package:bloc/bloc.dart';

import 'start_processing_event.dart';
import 'start_processing_state.dart';

class StartProcessingBloc extends Bloc<StartProcessingEvent, StartProcessingState> {
  StartProcessingBloc() : super(const StartProcessingState()) {
    on<ChangedStartProcessingEvent>(_onLoaded);
  }

  void _onLoaded(ChangedStartProcessingEvent event,
      Emitter<StartProcessingState> emit) async {
    emit(state.copyWith(
        isLoading: event.isLoaded,
        savedCards: event.savedCards,
        isErrorState: event.isErrorState,
        isAuthenticated: event.isAuthenticated));
  }
}
