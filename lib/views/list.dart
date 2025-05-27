import 'package:flutter/material.dart';
import 'package:responsi_prakmobile/models/movie_model.dart';
import 'package:responsi_prakmobile/presenters/movie_presenter.dart';
import 'package:responsi_prakmobile/views/movie_detail.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen>
    implements MovieView {
  late MoviePresenter _presenter;
  bool _isLoading = false;
  List<movie> _movieList = [];
  String? _errorMessage;
  String _currentEndpoint = 'movie';

  @override
  void initState() {
    super.initState();
    _presenter = MoviePresenter(this);
    _presenter.loadMovieData(_currentEndpoint);
  }

  void _fetchData(String endpoint) {
    setState(() {
      _currentEndpoint = endpoint;
      _errorMessage = null;
      _presenter.loadMovieData(endpoint);
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showMovieList(List<movie> movieList) {
    setState(() {
      _movieList = movieList;
      _errorMessage = null;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
      _isLoading = false;
    });
  }

  @override
  void showloading() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie List")),
      body: Column(
        children: [
          Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(child: Text("Error: $_errorMessage"))
                      : _movieList.isEmpty
                          ? Center(child: Text("No movies found"))
                          : ListView.builder(
                              itemCount: _movieList.length,
                              itemBuilder: (context, index) {
                                final movie = _movieList[index];
                                return ListTile(
                                    leading: movie.imgUrl.isNotEmpty
                                        ? Image.network(
                                            movie.imgUrl,
                                            width: 50,
                                            height: 75,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.network(
                                                  "https://placehold.co/50x75");
                                            },
                                          )
                                        : Image.network(
                                            "https://placehold.co/50x75"),
                                    title: Text(movie.title),
                                    subtitle: Text(
                                        "Rating: ${movie.rating} | Genre: ${movie.genre.join(", ")} | Duration: ${movie.duration}"),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      id: movie.id,
                                                      endpoint:
                                                          _currentEndpoint)));
                                    });
                              })),
        ],
      ),
    );
  }
}
