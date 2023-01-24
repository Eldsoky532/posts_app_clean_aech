import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/entity.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/bloc/add_delete_updata/feature_app_bloc.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/screens/posts_page.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/widget/loading_wiget.dart';

import 'form_widget.dart';


class PostAddUpdateScreen extends StatelessWidget {

  final Post? post;
  final bool isUpdatepost;

   PostAddUpdateScreen({ this.post,required this.isUpdatepost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isUpdatepost?"Edit Post": "Add Post"),),
      body: buildBody(),
    );
  }

  Widget buildBody()
  {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<FeatureAppBloc,FeatureAppState>(
          listener: (context,state){
            if(state is MessageFeatureAppstate)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message,style: TextStyle(
                      color: Colors.white
                  ),),
                    backgroundColor: Colors.green,
                  )
              );
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>PostaPage()), (route) => false);
            }else if(state is FeatureApperror)
            {
              print("error : ${state.message}");
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message,style: TextStyle(
                      color: Colors.white
                  ),),
                    backgroundColor: Colors.red,
                  )
              );
            }

          },
          builder: (context,state){
            if(state is FeatureApploading)
            {
              return LoadingWidget();
            }
            return FormWidget(isUpdatePost:isUpdatepost,post:isUpdatepost?post : null);
          },
        ),

      ),
    );



  }

}
