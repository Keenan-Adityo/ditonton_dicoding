import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:core/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/popular_tv_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/top_rated_tv_page.dart';
import 'package:core/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<OnAirTvListBloc>(context, listen: false)
            .add(OnFetchTVList()));
    Future.microtask(() =>
        BlocProvider.of<PopularTvListBloc>(context, listen: false)
            .add(OnFetchTVList()));
    Future.microtask(() =>
        BlocProvider.of<TopRatedTvListBloc>(context, listen: false)
            .add(OnFetchTVList()));
    Future.microtask(() =>
        BlocProvider.of<NowPlayingMovieListBloc>(context, listen: false)
            .add(OnFetchMovieList()));
    Future.microtask(() =>
        BlocProvider.of<PopularMovieListBloc>(context, listen: false)
            .add(OnFetchMovieList()));
    Future.microtask(() =>
        BlocProvider.of<TopRatedMovieListBloc>(context, listen: false)
            .add(OnFetchMovieList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies & TV'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, aboutRoute);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing Movies',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state is MovieListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieListHasData) {
                    return MovieList(state.result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular Movies',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),
              BlocBuilder<PopularMovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state is MovieListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieListHasData) {
                    return MovieList(state.result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated Movies',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<TopRatedMovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state is MovieListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieListHasData) {
                    return MovieList(state.result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              Text(
                'On The Air TV',
                style: kHeading6,
              ),
              BlocBuilder<OnAirTvListBloc, TvListState>(
                builder: (context, state) {
                  if (state is TvListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvListHasData) {
                    return TVList(state.result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular TV',
                onTap: () {
                  Navigator.pushNamed(context, PopularTVPage.routeName);
                },
              ),
              BlocBuilder<PopularTvListBloc, TvListState>(
                builder: (context, state) {
                  if (state is TvListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvListHasData) {
                    return TVList(state.result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated TV',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTVPage.routeName);
                },
              ),
              BlocBuilder<TopRatedTvListBloc, TvListState>(
                builder: (context, state) {
                  if (state is TvListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvListHasData) {
                    return TVList(state.result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageURL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class TVList extends StatelessWidget {
  final List<TVSeries> tvSeries;

  const TVList(this.tvSeries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVDetailPage.routeName,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageURL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
