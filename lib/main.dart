import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:janky_list/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dataUrl =
      'https://rest.apizza.net/mock/71aea1b8ad31a9c8000d1e09231017ad/list';

  ListData data;

  @override
  void initState() {
    super.initState();

    _getData();
  }

  void _getData() async {
    Response res = await get(Uri.parse(dataUrl));

    setState(() {
      data = listDataRawFromJson(res.body).data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return BigItem(
                        listItem: data.list[index],
                      );
                    },
                    childCount: data.list.length,
                  ),
                  itemExtent: 260.0,
                )
              ],
            ),
    );
  }
}

class BigItem extends StatelessWidget {
  final ListItem listItem;

  const BigItem({
    Key key,
    this.listItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Ink(
          child: InkWell(
            splashColor: Colors.white,
            onTap: () {},
            child: Container(
              height: 260,
              width: MediaQuery.of(context).size.width,
              child: FadeInImage(
                placeholder: AssetImage(
                  'lib/assets/images/article_broken_image.png',
                ),
                image: CachedNetworkImageProvider(
                  listItem.article.cover,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            constraints: BoxConstraints(maxHeight: 130),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(16, 21, 16, 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
                colors: [
                  Color.fromRGBO(0, 0, 0, 0),
                  Color.fromRGBO(0, 0, 0, 0.6),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      '#',
                      style: TextStyle(
                        color: Color(0xffF50627),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${listItem.channel.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '${listItem.article.title}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'NotoSerifSC',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
