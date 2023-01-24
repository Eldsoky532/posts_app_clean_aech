import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app_clean_aech/PostsFeature/data/datasource/localdatasource.dart';
import 'package:posts_app_clean_aech/PostsFeature/data/datasource/remote_datasource.dart';
import 'package:posts_app_clean_aech/PostsFeature/data/repositories.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/repositories.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/usecases/add_posts.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/usecases/delet_post.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/usecases/get_all_posts.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/usecases/update_posts.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/bloc/add_delete_updata/feature_app_bloc.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/bloc/posts_bloc.dart';
import 'package:posts_app_clean_aech/core/network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;



final sl=GetIt.instance;

Future<void> init() async
{
  //bloc
  
  sl.registerFactory(() => PostsBloc(getallPosts: sl()));
  sl.registerFactory(() => FeatureAppBloc(addpost: sl(), updatepost: sl(), deletePost: sl()));



  //usecase


  sl.registerLazySingleton(() => GetAllPost(sl()));
  sl.registerLazySingleton(() => CreatePost(sl()));
  sl.registerLazySingleton(() => UpDatePost(sl()));
  sl.registerLazySingleton(() => DeletePost(sl()));



  //repositery


  sl.registerLazySingleton<PostRepositery>(() => MainRepository(
      remoteDataSource: sl(),
      LocalDataSource: sl(),
      networkInfo: sl()
  ));




  //datasource
  
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));


  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImol(sharedPreferences: sl()));


  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImple(sl()));

  final shared=await  SharedPreferences.getInstance();

  sl.registerLazySingleton(() =>shared);


  sl.registerLazySingleton(() =>http.Client());

  sl.registerLazySingleton(() =>InternetConnectionChecker());

}


