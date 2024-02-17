// class Post{
//   final id;
//   final title;
//   final image_url;
//   final description;
//   Post({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.image_url,
//   });
//   Map<String,dynamic> toJson(){
//     return{
//       'id':id,
//       'title':title,
//       'description':description,
//       'image_url':image_url
//     };
//   }
//   factory Post.fromJson(Map<String,dynamic> json){
//     return Post(id: json['id'], title: json['title'], description: json['description'], image_url: json['image_url']);
//   }
// }
