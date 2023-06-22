import 'package:flutter/material.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';

class MySearchDelegate extends SearchDelegate<String> {
  final List<String> _data;

  MySearchDelegate(this._data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _search(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]),
                // onTap: () {
                //   close(context, snapshot.data![index]);
                // },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _data
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            close(context, query);
          },
        );
      },
    );
  }

  Future<List<String>> _search(String query) async {
    // Call your backend API here to search for data
    // Return a list of search results
    // For example:
    try {
      final response =
          await NetworkHandler.get(endpoint: 'events/search/$query');
      if (response[1] == 200) {
        final List<String> results =
            List<String>.generate(3, (index) => 'null');
        return results;
      } else {
        throw Exception('Failed to search');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
