import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/bloc/posts_bloc.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/screens/posts_add_update.dart';

import '../widget/loading_wiget.dart';
import '../widget/message_error.dart';
import '../widget/post_list_widget.dart';

class PostaPage extends StatelessWidget {
  const PostaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts App'),
      ),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (_)=>PostAddUpdateScreen(isUpdatepost: false)));
        },
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocConsumer<PostsBloc, PostsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PostsLoading) {
            return LoadingWidget();
          } else if (state is PostsLoaded) {
            return RefreshIndicator(
                onRefresh:()=> onrefresh(context), child: PostListWidget(posts: state.posts));
          } else if (state is Postserror) {
            return MessageDisplay(message: state.error);
          }
          return LoadingWidget();
        },
      ),
    );
  }
  Future<void> onrefresh(BuildContext context)
  async{
    BlocProvider.of<PostsBloc>(context).add(RefreshPostEvent());

  }
}
