import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/enumerations.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsUpdate()) {
    on<ChangeSettings>(_handleSettingsChange);
  }

  void _handleSettingsChange(
    ChangeSettings event,
    Emitter<SettingsState> emit,
  ) {
    final unitPosition = event.unit?.position;
    final frequencyPosition = event.frequency?.position;
    emit(
      SettingsUpdate(
        unit: unitPosition == null
            ? state.unit
            : ForecastUnit.fromPosition(unitPosition + 1),
        frequency: frequencyPosition == null
            ? state.frequency
            : UpdateInterval.fromPosition(frequencyPosition + 1),
      ),
    );
  }
}
