import 'dart:io';

import 'package:app_android_b_0145_24/logic/bloc/main_cubit/main_cubit.dart';
import 'package:app_android_b_0145_24/logic/bloc/settings_cubit/settings_cubit.dart';
import 'package:app_android_b_0145_24/logic/models/game_model.dart';
import 'package:app_android_b_0145_24/logic/models/round_model.dart';
import 'package:app_android_b_0145_24/logic/models/team_model.dart';
import 'package:app_android_b_0145_24/logic/models/user_model.dart';
import 'package:app_android_b_0145_24/ui/screens/loading_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/constants.dart';
import 'package:app_android_b_0145_24/utils/enums/categories_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

//First run app
ValueNotifier<bool> isFirstRun = ValueNotifier(true);

//Notifications
ValueNotifier<bool> isNotificationsNeed = ValueNotifier(true);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TeamModelAdapter());
  Hive.registerAdapter(GameModelAdapter());
  Hive.registerAdapter(CategoriesEnumAdapter());
  Hive.registerAdapter(RoundModelAdapter());

  await Hive.openBox(kAppStorage).then((value) {
    isFirstRun.value = value.get(kIsFirstRun, defaultValue: true);
    isNotificationsNeed.value = value.get(kNeedNotify, defaultValue: true);
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .whenComplete(() => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => SettingsCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.accentPrimary1,
            primary: AppColors.accentPrimary1,
            outline: AppColors.layer3,
            surface: AppColors.accentPrimary1,
            onSurface: AppColors.textWhite,
            onSurfaceVariant: AppColors.layer3,
          ),
          useMaterial3: true,
        ),
        home: const LoadingScreen(),
      ),
    );
  }
}
