class MovieResponse {
  MovieResponse({
      List<Search>? search, 
      String? totalResults, 
      String? response,}){
    _search = search;
    _totalResults = totalResults;
    _response = response;
}

  MovieResponse.fromJson(dynamic json) {
    if (json['Search'] != null) {
      _search = [];
      json['Search'].forEach((v) {
        _search?.add(Search.fromJson(v));
      });
    }
    _totalResults = json['totalResults'];
    _response = json['Response'];
  }
  List<Search>? _search;
  String? _totalResults;
  String? _response;

  List<Search>? get search => _search;
  String? get totalResults => _totalResults;
  String? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_search != null) {
      map['Search'] = _search?.map((v) => v.toJson()).toList();
    }
    map['totalResults'] = _totalResults;
    map['Response'] = _response;
    return map;
  }

}

class Search {
  Search({
      String? title, 
      String? year, 
      String? imdbID, 
      String? type, 
      String? poster,}){
    _title = title;
    _year = year;
    _imdbID = imdbID;
    _type = type;
    _poster = poster;
}

  Search.fromJson(dynamic json) {
    _title = json['Title'];
    _year = json['Year'];
    _imdbID = json['imdbID'];
    _type = json['Type'];
    _poster = json['Poster'];
  }
  String? _title;
  String? _year;
  String? _imdbID;
  String? _type;
  String? _poster;

  String? get title => _title;
  String? get year => _year;
  String? get imdbID => _imdbID;
  String? get type => _type;
  String? get poster => _poster;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Title'] = _title;
    map['Year'] = _year;
    map['imdbID'] = _imdbID;
    map['Type'] = _type;
    map['Poster'] = _poster;
    return map;
  }

}