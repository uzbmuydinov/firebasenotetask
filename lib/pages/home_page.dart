
import 'package:firebasenotetask/main.dart';
import 'package:firebasenotetask/models/post_model.dart';
import 'package:firebasenotetask/pages/detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import '../services/hive_service.dart';
import '../services/rtd_service.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware{
  late String userId;
  List<Post> list = [];

  void apiLoadPost() async {
    String? uid = DBService.loadString(StorageKeys.UID);
    RTDBService.loadPost(uid!).then((value) {
      _getList(value);
    });
  }

  void _getList(List<Post> post) {
    setState(() {
      list = post;
    });
  }




  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiLoadPost();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            AuthService.signOutUser(context);
          }, icon: Icon(Icons.logout)),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
          itemCount: list.length,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                // onTap: (){
                //   Navigator.pushNamed(context, DetailPage.id);
                // },
                textColor: Colors.black,
                leading: list[index].imgUrl != null ? CircleAvatar(
                  backgroundImage: NetworkImage(list[index].imgUrl!),
                ) : const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/img.png"),
                ),
                title: Text(list[index].title),
                subtitle: Text(list[index].content),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, DetailPage.id);
        },
        child: const Icon(CupertinoIcons.plus),
      ),
    );
  }
}