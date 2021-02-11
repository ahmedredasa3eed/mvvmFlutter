import 'package:flutter/material.dart';
import 'package:news/models/news_article.dart';
import 'package:news/services/web_service.dart';
import 'package:news/viewmodels/news_article_view_model.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class NewsArticleListViewModel with ChangeNotifier {

  LoadingStatus loadingStatus = LoadingStatus.searching;

  List<NewsArticleViewModel> articles = List<NewsArticleViewModel>();



  void topHeadlines() async {

    this.loadingStatus = LoadingStatus.searching;

    List<NewsArticle> newsArticles = await WebService().fetchTopHeadlines();

    notifyListeners();

    this.articles = newsArticles.map((article) => NewsArticleViewModel(article)).toList();


    if (this.articles.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }



  void topHeadlinesByCountry(String country) async {

    this.loadingStatus = LoadingStatus.searching;

    notifyListeners();

    List<NewsArticle> newsArticles = await WebService().fetchHeadlinesByCountry(country);

    this.articles = newsArticles.map((item) => NewsArticleViewModel(item)).toList();

    if (this.articles.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }

}
