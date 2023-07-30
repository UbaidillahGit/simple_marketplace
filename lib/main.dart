import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:path_provider_ios/path_provider_ios.dart';
import 'package:simple_marketplace/utils/injection/http_overrides.dart';
import 'package:simple_marketplace/features/explore/model/model_products.dart';
import 'package:simple_marketplace/features/orders/model/model_cart.dart' as model_cart;
import 'package:simple_marketplace/features/orders/model/model_orders.dart';
import 'package:simple_marketplace/navigator_tab.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  _initConfig();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}


void _initConfig() async {
  ///_________ To handle Certificate Verify Failed Error
  HttpOverrides.global = HttpOverride();

  final directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(ProductsAdapter()) //__typeId : 0
    ..registerAdapter(model_cart.ModelCartsAdapter()) //__typeId : 1
    ..registerAdapter(model_cart.ProductCheckOutAdapter()) //__typeId : 2
    ..registerAdapter(ModelOrdersAdapter()) //__typeId : 3
    ..registerAdapter(OrdersAdapter()); //__typeId : 4
    
  // HiveHelper().init();
  if (Platform.isAndroid) PathProviderAndroid.registerWith();
  if (Platform.isIOS) PathProviderIOS.registerWith();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Market Place',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NavigatorTab(),
    );
  }
}




