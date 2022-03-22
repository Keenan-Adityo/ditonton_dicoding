import 'package:core/presentation/bloc/switch/switch_bloc.dart';
import 'package:core/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/switch_catd.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';

  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchlistMovieBloc>(context, listen: false)
            .add(OnFetchWatchlistMovie()));
    Future.microtask(() =>
        BlocProvider.of<WatchlistTvBloc>(context, listen: false)
            .add(OnFetchWatchlistTv()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<WatchlistMovieBloc>(context, listen: false)
        .add(OnFetchWatchlistMovie());
    BlocProvider.of<WatchlistTvBloc>(context, listen: false)
        .add(OnFetchWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                if (state is SwitchMovie) {
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
                          BlocProvider.of<SwitchBloc>(context)
                              .add(const OnChanged('tv'));
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
                          BlocProvider.of<SwitchBloc>(context)
                              .add(const OnChanged('movie'));
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
              child: BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  if (state is SwitchMovie) {
                    return BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                      builder: (context, state) {
                        if (state is WatchlistMovieLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is WatchlistMovieHasData) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final movie = state.result[index];
                              return MovieCard(movie);
                            },
                            itemCount: state.result.length,
                          );
                        } else if (state is WatchlistMovieError) {
                          return Center(
                            key: const Key('error_message'),
                            child: Text(state.message),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else {
                    return BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
                      builder: (context, state) {
                        if (state is WatchlistTvLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is WatchlistTvHasData) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final tv = state.result[index];
                              return TVCard(tv);
                            },
                            itemCount: state.result.length,
                          );
                        } else if (state is WatchlistTvError) {
                          return Center(
                            key: const Key('error_message'),
                            child: Text(state.message),
                          );
                        } else {
                          return Container();
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
