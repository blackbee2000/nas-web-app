import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nasmobile/core/configs/easy_loading_config.dart';
import 'package:nasmobile/core/flavor/app_flavor.dart';
import 'package:nasmobile/core/utils/log_util.dart';
import 'package:nasmobile/feature/app/app/app.dart';
import 'package:nasmobile/firebase_options.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppFlavor.setDevelopmentEnvironment();

    if (kIsWeb) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else {
      await Firebase.initializeApp();
    }

    EasyLoadingConfig.config();
    runApp(const MyApp());
  }, (error, stack) {
    LogUtil.logError('ERROR ===> $error');
  });
}
