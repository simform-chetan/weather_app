part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();
}

final class ChangeSettings extends SettingsEvent {
  const ChangeSettings({this.unit, this.frequency});

  final ForecastUnit? unit;
  final UpdateInterval? frequency;

  @override
  List<Object> get props => [
        if (unit != null) unit!,
        if (frequency != null) frequency!,
      ];
}
