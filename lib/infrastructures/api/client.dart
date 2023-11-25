import 'package:dio/dio.dart';

import 'package:edspert_fl_adv/common/env.dart';

final clientOptions = BaseOptions(
  baseUrl: 'https://edspert.widyaedu.com',
  headers: {'x-api-key': Env.apiKey},
);
