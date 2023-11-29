class ApiEndpoints{
  static const String baseUrl="https://api.themoviedb.org/3/movie/";
  static NowPlayingEndPoints nowPlayingEndPoints=NowPlayingEndPoints();
  static TopRated topRated=TopRated();
}
class NowPlayingEndPoints{
  final String nowPlaying="now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
}

class TopRated{
  final String topRated="top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
}