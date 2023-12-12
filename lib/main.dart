import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart' as gestures;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'infrastructures/container/container.dart' as container;
import 'interfaces/providers.dart';
import 'interfaces/router/router.dart';
import 'interfaces/themes/app_themes.dart';

part 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await container.init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider.value(value: AuthCubit()),
      BlocProvider.value(value: FirebaseUserCubit()),
      BlocProvider.value(value: UserCacheCubit()),
      
      //
      BlocProvider(create: (context) => IpaCoursesCubit(context)),
      BlocProvider(create: (context) => IpsCoursesCubit(context)),
      BlocProvider(create: (_) => EventBannersCubit()),

      //
      BlocProvider.value(value: ThemeModeCacheCubit()),
    ],
    child: const MainApp(),
  ));
}
