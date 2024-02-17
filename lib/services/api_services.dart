import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../models/post_model.dart';
class ApiServices{
  static getHeader() {
    return {
      'Content-Type': 'application/json',
    };
  }

  final dio = Dio(
      BaseOptions(
        headers: getHeader(),
      )
  );
  Future<List<Post>> fetchPosts(int pageNo,int postCount) async{
    try{
      print("https://api-stg.together.buzz/mocks/discovery?page=${pageNo.toString()}&limit=${postCount.toString()}");
      print("In APISERVICE: $pageNo $postCount");
      print("_______________________________________");
      final response = await dio.get("https://api-stg.together.buzz/mocks/discovery?page=${pageNo.toString()}&limit=${postCount.toString()}");
      List<Post> posts = [];
      final json = response.data['data'];
      for(var item in json){
        posts.add(Post.fromJson(item));
      }
      print(json);
      return posts;
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }
}