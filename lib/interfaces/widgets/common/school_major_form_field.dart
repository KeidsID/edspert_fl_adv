import 'package:flutter/material.dart';

import 'package:edspert_fl_adv/common/constants.dart';
import 'package:edspert_fl_adv/core/entities/course/course.dart';

class SchoolMajorFormField extends FormField<SchoolMajor?> {
  SchoolMajorFormField({
    super.key,
    super.enabled,
    super.initialValue,
    super.onSaved,
  }) : super(
          builder: (state) {
            final major = state.value;
            final isIpaSelected = major == SchoolMajor.ipa;
            final isIpsSelected = major == SchoolMajor.ips;

            final isNotValid = state.hasError;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InputChip(
                      label: Text('${SchoolMajor.ipa}'),
                      selected: isIpaSelected,
                      isEnabled: enabled ? !(isIpaSelected) : enabled,
                      onSelected: (_) {
                        state.didChange(SchoolMajor.ipa);
                        state.save();
                      },
                    ),
                    const SizedBox(width: kSpacerValue),
                    InputChip(
                      label: Text('${SchoolMajor.ips}'),
                      selected: isIpsSelected,
                      isEnabled: enabled ? !(isIpsSelected) : enabled,
                      onSelected: (_) {
                        state.didChange(SchoolMajor.ips);
                        state.save();
                      },
                    ),
                  ],
                ),
                ...isNotValid
                    ? [
                        const SizedBox(height: 8.0),
                        Builder(builder: (context) {
                          final theme = Theme.of(context);
                          final textTheme = Theme.of(context).textTheme;

                          return Text(
                            state.errorText!,
                            style: textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          );
                        }),
                      ]
                    : [const SizedBox()]
              ],
            );
          },
        );
}
