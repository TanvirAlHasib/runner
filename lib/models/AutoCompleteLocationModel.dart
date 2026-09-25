class AutoCompleteLocationModel {
  List<Suggestions>? suggestions;

  AutoCompleteLocationModel({this.suggestions});

  AutoCompleteLocationModel.fromJson(Map<String, dynamic> json) {
    if (json['suggestions'] != null) {
      suggestions = <Suggestions>[];
      json['suggestions'].forEach((v) {
        suggestions!.add(new Suggestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.suggestions != null) {
      data['suggestions'] = this.suggestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Suggestions {
  PlacePrediction? placePrediction;

  Suggestions({this.placePrediction});

  Suggestions.fromJson(Map<String, dynamic> json) {
    placePrediction = json['placePrediction'] != null
        ? new PlacePrediction.fromJson(json['placePrediction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.placePrediction != null) {
      data['placePrediction'] = this.placePrediction!.toJson();
    }
    return data;
  }
}

class PlacePrediction {
  String? place;
  String? placeId;
  Text? text;
  StructuredFormat? structuredFormat;
  List<String>? types;

  PlacePrediction(
      {this.place, this.placeId, this.text, this.structuredFormat, this.types});

  PlacePrediction.fromJson(Map<String, dynamic> json) {
    place = json['place'];
    placeId = json['placeId'];
    text = json['text'] != null ? new Text.fromJson(json['text']) : null;
    structuredFormat = json['structuredFormat'] != null
        ? new StructuredFormat.fromJson(json['structuredFormat'])
        : null;
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place'] = this.place;
    data['placeId'] = this.placeId;
    if (this.text != null) {
      data['text'] = this.text!.toJson();
    }
    if (this.structuredFormat != null) {
      data['structuredFormat'] = this.structuredFormat!.toJson();
    }
    data['types'] = this.types;
    return data;
  }
}

class Text {
  String? text;
  List<Matches>? matches;

  Text({this.text, this.matches});

  Text.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    if (json['matches'] != null) {
      matches = <Matches>[];
      json['matches'].forEach((v) {
        matches!.add(new Matches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    if (this.matches != null) {
      data['matches'] = this.matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matches {
  int? endOffset;

  Matches({this.endOffset});

  Matches.fromJson(Map<String, dynamic> json) {
    endOffset = json['endOffset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['endOffset'] = this.endOffset;
    return data;
  }
}

class StructuredFormat {
  MainText? mainText;
  MainText? secondaryText;

  StructuredFormat({this.mainText, this.secondaryText});

  StructuredFormat.fromJson(Map<String, dynamic> json) {
    mainText = json['mainText'] != null
        ? new MainText.fromJson(json['mainText'])
        : null;
    secondaryText = json['secondaryText'] != null
        ? new MainText.fromJson(json['secondaryText'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mainText != null) {
      data['mainText'] = this.mainText!.toJson();
    }
    if (this.secondaryText != null) {
      data['secondaryText'] = this.secondaryText!.toJson();
    }
    return data;
  }
}

class MainText {
  String? text;

  MainText({this.text});

  MainText.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}
