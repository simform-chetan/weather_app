part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState({required this.unit, required this.frequency});

  final ForecastUnit unit;
  final UpdateInterval frequency;

  @override
  List<Object> get props => [unit, frequency];
}

final class SettingsUpdate extends SettingsState {
  const SettingsUpdate({
    super.unit = ForecastUnit.celsius,
    super.frequency = UpdateInterval.sixty,
  });
}
