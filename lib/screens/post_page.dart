import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procamera/globals/global.dart';
import 'package:procamera/helpers/api_helpers.dart';
import 'package:procamera/model/models.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {


  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage("https://images.pexels.com/photos/3697816/pexels-photo-3697816.jpeg"),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                controller: searchController,
                onSubmitted: (val) {
                  setState(() {
                    Global.searchData = val;
                  });
                },
                placeholder: "Search Id",
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(8),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xff25262c),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "popular words",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: size.height * 0.18,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          word(text: "mustang car"),
                          word(text: "classical music"),
                          word(text: "dark"),
                          word(text: "coffee"),
                          word(text: "tea"),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                        const SizedBox(width: 20,),
                          word(text: "Wine"),
                          word(text: "Motel"),
                          word(text: "whiskey"),
                          word(text: "laptop"),
                          word(text: "iphone wallpaper"),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          word(text: "Black Car"),
                          word(text: "nature"),
                          word(text: "wallpaper"),
                          word(text: "christmas tree"),
                          word(text: "money"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Best Photos",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder(
                future: ApiHelpers.apiHelpers.getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error is : ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    List<Provider>? data = snapshot.data;
                    return (data != null)
                        ? GridView.builder(
                            itemCount: data.length,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 300,
                                    childAspectRatio: 1 / 4),
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: (){
                                  print(data[i].image);
                                  Navigator.of(context).pushNamed("details",arguments: data[i].image);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.3),
                                          Colors.white.withOpacity(0.6)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(data[i].image),
                                        fit: BoxFit.cover),
                                    border:
                                        Border.all(color: Colors.black, width: 2),
                                  ),
                                ),
                              );
                            })
                        : const Center(
                            child: Text("Data is Not Founds ...."),
                          );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  word({required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            Global.searchData = text;
            searchController.clear();
            searchController.text = text;
          });
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
