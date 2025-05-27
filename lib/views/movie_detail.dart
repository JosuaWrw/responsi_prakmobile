import 'package:flutter/material.dart';
import 'package:responsi_prakmobile/network/base_network.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String endpoint;
  const DetailScreen({super.key, required this.id, required this.endpoint});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _detailData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchDetailData();
  }

  Future<void> _fetchDetailData() async {
    try {
      final data = await BaseNetwork.getDetailData(widget.endpoint, widget.id);
      setState(() {
        _detailData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text("Error: $_errorMessage"))
              : _detailData != null
                  ? Column(
                      children: [
                        Image.network(_detailData!['images'][0] ??
                            'https://placehold.co/600x400'),
                        Text("Title : ${_detailData!['title']}"),
                        Text("Rating : ${_detailData!['rating']}"),
                        Text("Genre : ${_detailData!['genre']}"),
                        Text("Duration : ${_detailData!['duration']}"),
                        Text("Description : ${_detailData!['description']}"),
                        Text("Release Date : ${_detailData!['release_date']}"),
                        Text("Created at : ${_detailData!['created_at']}"),
                        Text("Director : ${_detailData!['director']}"),
                        Text("Cast : ${_detailData!['cast']}"),
                        Text("Language : ${_detailData!['language']}"),
                      ],
                    )
                  : Text("No Data available"),
    );
  }
}
