class ConsentModel {
  bool processingRoutes;
  bool aiSuggestions;
  bool shareData;

  ConsentModel({
    this.processingRoutes = false,
    this.aiSuggestions = false,
    this.shareData = false,
  });

  ConsentModel copyWith({
    bool? processingRoutes,
    bool? aiSuggestions,
    bool? shareData,
  }) {
    return ConsentModel(
      processingRoutes: processingRoutes ?? this.processingRoutes,
      aiSuggestions: aiSuggestions ?? this.aiSuggestions,
      shareData: shareData ?? this.shareData,
    );
  }

  factory ConsentModel.fromJson(Map<String, dynamic> json) {
    return ConsentModel(
      processingRoutes: json['anonymizedRouteData'] as bool? ?? false,
      aiSuggestions: json['aiRouteSuggestions'] as bool? ?? false,
      shareData: json['municipalityDataSharing'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anonymizedRouteData': processingRoutes,
      'aiRouteSuggestions': aiSuggestions,
      'municipalityDataSharing': shareData,
    };
  }
}
