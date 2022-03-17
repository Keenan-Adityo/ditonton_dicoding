import 'package:core/presentation/provider/switch_notifier.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/switch_catd.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/styles/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_movie/search_bloc.dart';
import 'package:search/presentation/bloc/search_tv/searchtv_bloc.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<SwitchNotifier>(builder: (context, data, child) {
              if (data.data == 'movie') {
                return TextField(
                  onChanged: (query) {
                    context.read<SearchBloc>().add(OnQueryChanged(query));
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search title',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.search,
                );
              } else {
                return TextField(
                  onChanged: (query) {
                    context.read<SearchTVBloc>().add(OnQueryChangedTV(query));
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search title',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.search,
                );
              }
            }),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<SwitchNotifier>(
              builder: (context, value, child) {
                if (value.data == 'movie') {
                  return BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchHasData) {
                        final result = state.result;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = result[index];
                              return MovieCard(movie);
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else if (state is SearchError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  );
                } else {
                  return BlocBuilder<SearchTVBloc, SearchTVState>(
                    builder: (context, state) {
                      if (state is SearchTVLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchTVHasData) {
                        final result = state.result;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final tv = result[index];
                              return TVCard(tv);
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
