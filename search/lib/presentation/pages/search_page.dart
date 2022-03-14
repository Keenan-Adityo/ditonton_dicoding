import 'package:core/presentation/provider/switch_notifier.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/switch_catd.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/provider/movie_search_notifier.dart';
import 'package:search/presentation/provider/tv_search_notifier.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
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
                  decoration: InputDecoration(
                    hintText: 'Search title',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.search,
                );
              } else {
                return TextField(
                  onSubmitted: (query) {
                    Provider.of<TVSearchNotifier>(context, listen: false)
                        .fetchTVSearch(query);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search title',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.search,
                );
              }
            }),
            SizedBox(height: 16),
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
            SizedBox(height: 16),
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
                        return Center(
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
                  return Consumer<TVSearchNotifier>(
                    builder: (context, data, child) {
                      if (data.state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.state == RequestState.Loaded) {
                        final result = data.searchResult;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final tv = data.searchResult[index];
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
