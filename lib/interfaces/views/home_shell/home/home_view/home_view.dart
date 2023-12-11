import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:root_lib/common/assets_paths.dart';
import 'package:root_lib/common/constants.dart';
import 'package:root_lib/core/entities/course/course.dart';
import 'package:root_lib/core/entities/event/event_banner.dart';
import 'package:root_lib/interfaces/providers.dart';
import 'package:root_lib/interfaces/providers/utils/future_cubit.dart';
import 'package:root_lib/interfaces/router/routes/routes.dart';
import 'package:root_lib/interfaces/widgets.dart';

part '_sections/_app_bar_section.dart';
part '_sections/_courses_section.dart';
part '_sections/_event_banners_section.dart';
part '_sections/_headline_section.dart';

const _kHorizPadding = EdgeInsets.symmetric(horizontal: kPaddingValue);

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SizedBox.expand(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: kPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: _kHorizPadding,
                child: _AppBarSection(),
              ),

              // headline
              SizedBox(height: kSpacerValue),
              Padding(
                padding: _kHorizPadding,
                child: _HeadlineSection(),
              ),

              // courses
              SizedBox(height: kSpacerValue),
              Padding(
                padding: _kHorizPadding,
                child: _CoursesSection(),
              ),

              // events
              SizedBox(height: kSpacerValue),
              _EventBannersSection(),
            ],
          ),
        ),
      ),
    );
  }
}
