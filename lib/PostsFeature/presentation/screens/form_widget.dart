import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app_clean_aech/PostsFeature/domain/entity.dart';
import 'package:posts_app_clean_aech/PostsFeature/presentation/bloc/add_delete_updata/feature_app_bloc.dart';

class FormWidget extends StatefulWidget {

  final bool isUpdatePost;
  final Post? post;


   FormWidget({this.post,required this.isUpdatePost});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {

  final formkey=GlobalKey<FormState>();

  TextEditingController title=TextEditingController();

  TextEditingController body=TextEditingController();


  @override
  void initState() {
    if(widget.isUpdatePost)
      {
        title.text=widget.post!.title;
        body.text=widget.post!.body;
      }
    super.initState();
  }
  
  void addorupdate()
  {
    final isVaild=formkey.currentState!.validate();
    
    if(isVaild)
      {
        final post=Post(
            id: widget.isUpdatePost?widget.post!.id:null,
            title: title.text,
            body: body.text);
        if(widget.isUpdatePost)
          {
            BlocProvider.of<FeatureAppBloc>(context).add(UpdatePostEvent(post: post));
          }
        else
          {
            BlocProvider.of<FeatureAppBloc>(context).add(AddPostEvent(post: post));

          }
      }
    
    
  }
  
  
  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.edit_calendar_outlined,size: 100,color: Color(0xff082659),),
              Padding(
                padding:EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: TextFormField(
                  controller: title,
                  validator: (value)=>value!.isEmpty?"Title Cant be Empty" : null,
                  decoration: InputDecoration(
                      hintText: "Title"
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: TextFormField(
                  controller: body,
                  validator: (value)=>value!.isEmpty?"Body Cant be Empty" : null,
                  decoration: InputDecoration(
                    hintText: "Body",

                  ),
                  maxLines: 6,
                  minLines: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: addorupdate,
                    icon: widget.isUpdatePost?Icon(Icons.edit):Icon(Icons.add),
                    label: Text(widget.isUpdatePost?"Update":"Add"),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
