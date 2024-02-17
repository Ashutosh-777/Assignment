import 'package:assignment/services/api_services.dart';
import 'package:flutter/material.dart';
import '../models/post_model.dart';
class PostProvider extends ChangeNotifier{
  List<Post> post=[];
  int page = 1;
  int postCount = 7;
  bool page_1 = true;
  void add(Post newPost){
    post.add(newPost);
    notifyListeners();
  }
  Future<List<Post>> getPosts() async{
    post.addAll(await ApiServices().fetchPosts(page, postCount));
    print("doing something ${post.length}");
    notifyListeners();
    return post;
  }
}