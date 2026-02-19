import 'package:flutter/material.dart';

import 'package:dot_cast/dot_cast.dart';
import 'package:provider/provider.dart';

import 'package:elastic_dashboard/widgets/nt_widgets/nt_widget.dart';

class ToggleSwitch extends NTWidget {
  static const String widgetType = 'Toggle Switch';

  const ToggleSwitch({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    SingleTopicNTWidgetModel model = cast(context.watch<NTWidgetModel>());

    return ValueListenableBuilder(
      valueListenable: model.subscription!,
      builder: (context, data, child) {
        bool value = tryCast(data) ?? false;

        return Switch(
          value: value,
          onChanged: (bool value) {
            if (model.ntStructMeta != null) return;

            bool publishTopic =
                model.ntTopic == null ||
                !model.ntConnection.isTopicPublished(model.ntTopic);

            model.createTopicIfNull();

            if (model.ntTopic == null) {
              return;
            }

            if (publishTopic) {
              model.ntConnection.publishTopic(model.ntTopic!);
            }

            model.ntConnection.updateDataFromTopic(model.ntTopic!, value);
          },
        );
      },
    );
  }
}
/*
class ToggleSwitchModel extends SingleTopicNTWidgetModel {
  static const String modelType = ToggleSwitch.widgetType;

  bool defaultValue = false;

  ToggleSwitchModel({bool? defaultValue, 
    required super.ntConnection, 
    required super.preferences, 
    required super.topic,
    super.ntStructMeta,
    super.dataType,
    super.period,
    }) {
    this.defaultValue = defaultValue ?? false;
  }

  ToggleSwitchModel.fromJson({
    required super.ntConnection,
    required super.preferences,
    required Map<String, dynamic> jsonData,
  }) : super.fromJson(jsonData: jsonData) {
    defaultValue = tryCast(jsonData['default_value']) ??
        tryCast(jsonData['default']) ??
        defaultValue;
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'default_value': defaultValue,
      };
}*/