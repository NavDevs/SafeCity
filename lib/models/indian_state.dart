class IndianState {
  final String name;
  final String capital;
  final double latitude;
  final double longitude;
  final String description;
  final List<String> majorCities;
  final String language;
  final double area; // in sq km
  final int population;

  const IndianState({
    required this.name,
    required this.capital,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.majorCities,
    required this.language,
    required this.area,
    required this.population,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'capital': capital,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'majorCities': majorCities,
      'language': language,
      'area': area,
      'population': population,
    };
  }

  // Create from JSON
  factory IndianState.fromJson(Map<String, dynamic> json) {
    return IndianState(
      name: json['name'] as String,
      capital: json['capital'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      description: json['description'] as String,
      majorCities: List<String>.from(json['majorCities'] as List),
      language: json['language'] as String,
      area: (json['area'] as num).toDouble(),
      population: json['population'] as int,
    );
  }

  @override
  String toString() {
    return 'IndianState(name: $name, capital: $capital, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IndianState && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
