class Urls {
  static final String autoCompleteLocationUrl = "https://places.googleapis.com/v1/places:autocomplete";
  static String getPlacesByPlaceIdUrl(String placeId) => "https://places.googleapis.com/v1/places/$placeId";
}