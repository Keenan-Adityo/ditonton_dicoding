import 'package:core/presentation/provider/switch_notifier.dart';
import 'package:core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/watchlist_tv_notifier.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/switch_catd.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
    Future.microtask(() =>
        Provider.of<WatchlistTVNotifier>(context, listen: false)
            .fetchWatchlistTV());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTVNotifier>(context, listen: false).fetchWatchlistTV();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<SwitchNotifier>(
              builder: (context, data, child) {
                if (data.data == 'movie') {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwitchCard(
                        name: 'Movie',
                        style: kHeading6,
                        color: Colors.black,
                      ),
                      InkWell(
                        child: SwitchCard(
                          name: 'TV',
                          style: kHeading6.copyWith(color: Colors.black),
                          color: Colors.white,
                        ),
                        onTap: () {
                          Provider.of<SwitchNotifier>(context, listen: false)
                              .changeTV();
                        },
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: SwitchCard(
                          name: 'Movie',
                          style: kHeading6.copyWith(color: Colors.black),
                          color: Colors.white,
                        ),
                        onTap: () {
                          Provider.of<SwitchNotifier>(context, listen: false)
                              .changeMovie();
                        },
                      ),
                      SwitchCard(
                        name: 'TV',
                        style: kHeading6,
                        color: Colors.black,
                      ),
                    ],
                  );
                }
              },
            ),
            Expanded(
              child: Consumer<SwitchNotifier>(
                builder: (context, value, child) {
                  if (value.data == 'movie') {
                    return Consumer<WatchlistMovieNotifier>(
                      builder: (context, data, child) {
                        if (data.watchlistState == RequestState.Loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (data.watchlistState == RequestState.Loaded) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final movie = data.watchlistMovies[index];
                              return MovieCard(movie);
                            },
                            itemCount: data.watchlistMovies.length,
                          );
                        } else {
                          return Center(
                            key: Key('error_message'),
                            child: Text(data.message),
                          );
                        }
                      },
                    );
                  } else {
                    return Consumer<WatchlistTVNotifier>(
                      builder: (context, data, child) {
                        if (data.watchlistState == RequestState.Loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (data.watchlistState == RequestState.Loaded) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final tv = data.watchlistTV[index];
                              print(data.watchlistTV.length);
                              return TVCard(tv);
                            },
                            itemCount: data.watchlistTV.length,
                          );
                        } else {
                          return Center(
                            key: Key('error_message'),
                            child: Text(data.message),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
