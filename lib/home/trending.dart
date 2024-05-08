import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Trending extends StatefulWidget {
  const Trending({super.key});

  @override
  State<Trending> createState() => _HomeHomePageState();
}

class _HomeHomePageState extends State<Trending> {
  List<Article> articles = [];

  loadTrending() async {
    articles = List.generate(
        5,
        (index) => Article("Test", DateTime.now(),
            Image(image: AssetImage('assets/banner.png')), "hallo"));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadTrending();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Trending"),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      for (var i in articles) ArticleWidget(article: i)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                width: 300,
                height: 120,
                child: Card(
                  color: Colors.white,
                    child: Column(
                  children: [
                    SizedBox(height:10),
                    Text(article.title,
                        style: TextStyle(color: Colors.black)),
                    Text(article.date.toIso8601String(), style: TextStyle(color: Colors.black)),
                    Text(article.text),
                    article.img,
                    
                  ],
                )));
  }
}

class Article {
  String title = "";
  DateTime date = DateTime.now();
  Image img = Image(image: Icons.);
  String text = "";

  Article(String title, DateTime date, Image img, String text) {
    this.title = title;
    this.date = date;
    this.img = img;
    this.text = text;
  }
}
