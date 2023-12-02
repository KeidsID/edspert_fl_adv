import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:edspert_fl_adv/common/assets_paths.dart';
import 'package:edspert_fl_adv/common/constants.dart';
import 'package:edspert_fl_adv/core/entities/course/course.dart';
import 'package:edspert_fl_adv/core/entities/event/event_banner.dart';
import 'package:edspert_fl_adv/infrastructures/api/errors/common_response_exception.dart';
import 'package:edspert_fl_adv/interfaces/providers/auth/user_cache_provider.dart';
import 'package:edspert_fl_adv/interfaces/providers/courses/courses_provider.dart';
import 'package:edspert_fl_adv/interfaces/providers/events/event_banners_provider.dart';
import 'package:edspert_fl_adv/interfaces/router/routes.dart';
import 'package:edspert_fl_adv/interfaces/widgets.dart';

part '_sections/_app_bar_section.dart';
part '_sections/_courses_section.dart';
part '_sections/_event_banners_section.dart';
part '_sections/_headline_section.dart';

const _kHorizPadding = EdgeInsets.symmetric(horizontal: kPaddingValue);

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
