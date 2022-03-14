import 'package:core/domain/repositories/tv_series_repository.dart';

class GetWatchListStatusTV {
  final TVSeriesRepository repository;

  GetWatchListStatusTV(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
