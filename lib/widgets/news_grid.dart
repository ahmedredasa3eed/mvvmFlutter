import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/news_article_detail_screen.dart';
import 'package:news/viewmodels/news_article_view_model.dart';
import 'package:news/widgets/circle_image.dart';

class NewsGrid extends StatelessWidget {

  final List<NewsArticleViewModel> articles;

  NewsGrid({this.articles});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: this.articles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              (MediaQuery.of(context).orientation == Orientation.portrait)
                  ? 2
                  : 3),
      itemBuilder: (BuildContext context, int index) {
        final article = this.articles[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsArticleDetailScreen(article: article,)));
          },
          child: GridTile(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: CircleImage(
                imageUrl: article.imageUrl,
              ),
            ),
            footer: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              child: Text(
                article.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
}
