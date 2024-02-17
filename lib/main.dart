import 'package:assignment/store/post_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/post_model.dart';
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PostProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];
  List<Post> loadedPosts = [];
  final scrollController  = ScrollController();
  @override
  void initState(){
    scrollController.addListener(_scrolllistener);
    _loadPosts();
    super.initState();
  }
  Future<void> _loadPosts() async {
    try {
      List<Post> loadedPosts = await context.read<PostProvider>().getPosts();
      setState(() {
        posts = loadedPosts;
      });
    } catch (error) {
      // Handle error as needed
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(child: Text('Mock API Data')),
      ),
      body: FutureBuilder<List<Post>>(
          future: context.read<PostProvider>().getPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator(),);
            }
            print("______00000");
            print(snapshot.data!.length);
            return ListView.builder(
              controller: scrollController,
              itemCount: snapshot.data!.length+1,
                itemBuilder: (context,index){
              return index< snapshot.data!.length ?
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.redAccent
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(14),topRight: Radius.circular(14)),
                        child: Image.network(snapshot.data?[index].image_url,fit: BoxFit.contain,)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                      child: Text(snapshot.data?[index].title,style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                      child: Text(snapshot.data?[index].description,
                        style: const TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                  ],
                ),
              ):
              const Center(child: CircularProgressIndicator());
            });
          }
      )
    );
  }
  void _scrolllistener(){
    if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
          context.read<PostProvider>().page++;
        if(context.read<PostProvider>().page==5){
            context.read<PostProvider>().page++;
        }
        setState(() {
          if (kDebugMode) {
            print(context.read<PostProvider>().postCount);
          }
        });

    }
  }
}


