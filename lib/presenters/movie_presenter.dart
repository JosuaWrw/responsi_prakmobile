import 'package:responsi_prakmobile/models/movie_model.dart';
import 'package:responsi_prakmobile/network/base_network.dart';

abstract class MovieView {
  void showloading();
  void hideLoading();
  void showMovieList(List<movie> movieList);
  void showError(String message);
}

class MoviePresenter {
  final MovieView view;
  MoviePresenter(this.view);

  Future<void> loadMovieData(String endpoint) async {
    try {
      final List<dynamic> data = await BaseNetwork.getData(endpoint);
      final movieList = data.map((json) => movie.fromJson(json)).toList();
      view.showMovieList(movieList);
    } catch (e) {
      view.showError(e.toString());
    } finally {
      view.hideLoading();
    }
  }
}
