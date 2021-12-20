import 'package:astro_talk/data/bloc/provider/astrologer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'data/bloc/provider/location_bloc.dart';
import 'data/bloc/provider/panchang_bloc.dart';
import 'ui/dashboard/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: MultiBlocProvider(providers: [
            BlocProvider(
              create: (_) => PanchangBloc(),
            ),
            BlocProvider(
              create: (_) => LocationBloc(),
            ),
            BlocProvider(
              create: (_) => AstrologerBloc(),
            ),
          ], child: const Dashboard()),
        );
      },
    );
  }
}
