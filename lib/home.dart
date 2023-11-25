import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'movie_detail.dart';
import 'movie_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Api call
  List<Welcome> welcome = [];
  Future<List<Welcome>> getApi() async {
    final response =
        await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var i = 0; i < data.length; i++) {
        welcome.add(Welcome.fromMap(data[i]));
      }
      return welcome;
    } else {
      debugPrint("failed to load data");
      return welcome;
    }
  }

  //Search Api call
  List<Welcome> searchwelcome = [];
  Future<List<Welcome>> getSearch(String term) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$term'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var i = 0; i < data.length; i++) {
        searchwelcome.add(Welcome.fromMap(data[i]));
      }
      return searchwelcome;
    } else {
      debugPrint("failed to load data");
      return searchwelcome;
    }
  }

  Future<List<Welcome>>? result;

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottom navigation bar
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.white,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_sharp),
            label: '',
          ),
        ],
      ),
      // app bar
      appBar: AppBar(
        title: const Text("Movie App", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: <Widget>[
        /// Home page
        Column(
          children: [
            // search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: InkWell(
                onTap: () {
                  setState(() {
                    currentPageIndex = 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 128, 123, 123),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Search for movies!",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.search, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // list of movies
            Expanded(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            // remove html tags from summary
                            String textWithoutHtmlTags = parse(snapshot
                                        .data![index].show.summary
                                        .toString())
                                    .body
                                    ?.text ??
                                '';
                            return InkWell(
                              // redirect to movie details page
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetails(
                                      movie: snapshot.data![index],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                // movie name
                                title: Text(snapshot.data![index].show.name,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                // movie summary
                                subtitle: Text(
                                    textWithoutHtmlTags.length > 100
                                        ? '${textWithoutHtmlTags.substring(0, 100)}.....'
                                        : textWithoutHtmlTags,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                // movie image
                                leading:
                                    snapshot.data![index].show.image == null
                                        ? const Icon(Icons.movie, size: 50)
                                        : Image.network(
                                            snapshot.data![index].show.image!
                                                .medium,
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            );
                          }),
                    );
                  } else {
                    // show loading indicator
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                future: getApi(),
              ),
            ),
          ],
        ),

        /// Search page
        Column(
          children: [
            // search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 128, 123, 123),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search for movies!',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    // call search api
                    result = getSearch(value);
                  },
                ),
              ),
            ),
            // search results
            result == null
                ? // show message if no search results or not searched yet
                const Text(
                    'Search results will appear here',
                    style: TextStyle(color: Colors.white),
                  )
                : // show search results
                Expanded(
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  // remove html tags from summary
                                  String textWithoutHtmlTags = parse(snapshot
                                              .data![index].show.summary
                                              .toString())
                                          .body
                                          ?.text ??
                                      '';
                                  return InkWell(
                                    // redirect to movie details page
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MovieDetails(
                                            movie: snapshot.data![index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      // movie name
                                      title: Text(
                                          snapshot.data![index].show.name,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      // movie summary
                                      subtitle: Text(
                                          textWithoutHtmlTags.length > 100
                                              ? '${textWithoutHtmlTags.substring(0, 100)}.....'
                                              : textWithoutHtmlTags,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      // movie image
                                      leading: snapshot
                                                  .data![index].show.image ==
                                              null
                                          ? const Icon(Icons.movie, size: 50)
                                          : Image.network(
                                              snapshot.data![index].show.image!
                                                  .medium,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  );
                                }),
                          );
                        } else {
                          // show loading indicator
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      future: result,
                    ),
                  ),
          ],
        )
      ][currentPageIndex],
    );
  }
}
