import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/bloc/add_delete_updata/feature_app_bloc.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/bloc/posts_bloc.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/screens/posts_page.dart';
import 'package:posts_app_clean_aech/core/app_theme.dart';

import 'dependancy_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostEvent())),
          BlocProvider(create: (_) => di.sl<FeatureAppBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Posta App',
          theme: appTheme,
          home: PostaPage(),
        ));
  }
}
