import 'package:dio/dio.dart';
import 'package:root_lib/infrastructures/api/utils/dio_adapters.dart';
import 'package:fetch_client/fetch_client.dart';

// TODO: Find other way to use fetch api cuz this still fail on web.
HttpClientAdapter get clientAdapter => ConversionLayerAdapter(FetchClient());
