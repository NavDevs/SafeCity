import 'package:flutter/foundation.dart';
import '../models/indian_state.dart';

class StatesProvider with ChangeNotifier {
  List<IndianState> _states = [];
  IndianState? _selectedState;
  bool _isLoading = false;

  // Getters
  List<IndianState> get states => _states;
  IndianState? get selectedState => _selectedState;
  bool get isLoading => _isLoading;

  StatesProvider() {
    _initializeStates();
  }

  void _initializeStates() {
    _states = [
      const IndianState(
        name: 'Maharashtra',
        capital: 'Mumbai',
        latitude: 19.7515,
        longitude: 75.7139,
        description:
            'Maharashtra is a state in western India with Mumbai as its capital.',
        majorCities: ['Mumbai', 'Pune', 'Nagpur', 'Nashik'],
        language: 'Marathi',
        area: 307713,
        population: 112374333,
      ),
      const IndianState(
        name: 'Delhi',
        capital: 'New Delhi',
        latitude: 28.7041,
        longitude: 77.1025,
        description: 'Delhi is the capital territory of India.',
        majorCities: ['New Delhi', 'Gurgaon', 'Faridabad', 'Noida'],
        language: 'Hindi',
        area: 1484,
        population: 32941309,
      ),
      const IndianState(
        name: 'Karnataka',
        capital: 'Bengaluru',
        latitude: 15.3173,
        longitude: 75.7139,
        description:
            'Karnataka is a state in southern India known for its IT industry.',
        majorCities: ['Bengaluru', 'Mysuru', 'Hubli', 'Mangaluru'],
        language: 'Kannada',
        area: 191791,
        population: 61095297,
      ),
      const IndianState(
        name: 'Tamil Nadu',
        capital: 'Chennai',
        latitude: 11.0168,
        longitude: 76.9558,
        description:
            'Tamil Nadu is a state in southern India with rich cultural heritage.',
        majorCities: ['Chennai', 'Coimbatore', 'Madurai', 'Tiruchirappalli'],
        language: 'Tamil',
        area: 130060,
        population: 72147030,
      ),
      const IndianState(
        name: 'Uttar Pradesh',
        capital: 'Lucknow',
        latitude: 26.8467,
        longitude: 80.9462,
        description: 'Uttar Pradesh is the most populous state in India.',
        majorCities: ['Lucknow', 'Kanpur', 'Agra', 'Varanasi'],
        language: 'Hindi',
        area: 240928,
        population: 199812341,
      ),
      const IndianState(
        name: 'West Bengal',
        capital: 'Kolkata',
        latitude: 22.9868,
        longitude: 87.8550,
        description:
            'West Bengal is a state in eastern India known for its cultural heritage.',
        majorCities: ['Kolkata', 'Howrah', 'Durgapur', 'Asansol'],
        language: 'Bengali',
        area: 88752,
        population: 91276115,
      ),
      const IndianState(
        name: 'Gujarat',
        capital: 'Gandhinagar',
        latitude: 23.0225,
        longitude: 72.5714,
        description:
            'Gujarat is a state in western India known for its business culture.',
        majorCities: ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot'],
        language: 'Gujarati',
        area: 196244,
        population: 60439692,
      ),
      const IndianState(
        name: 'Rajasthan',
        capital: 'Jaipur',
        latitude: 27.0238,
        longitude: 74.2179,
        description:
            'Rajasthan is the largest state in India by area, known for its desert and palaces.',
        majorCities: ['Jaipur', 'Jodhpur', 'Udaipur', 'Kota'],
        language: 'Hindi',
        area: 342239,
        population: 68548437,
      ),
      const IndianState(
        name: 'Andhra Pradesh',
        capital: 'Amaravati',
        latitude: 15.9129,
        longitude: 79.7400,
        description:
            'Andhra Pradesh is a state in southern India known for its technology industry.',
        majorCities: ['Visakhapatnam', 'Vijayawada', 'Guntur', 'Tirupati'],
        language: 'Telugu',
        area: 162968,
        population: 49577103,
      ),
      const IndianState(
        name: 'Kerala',
        capital: 'Thiruvananthapuram',
        latitude: 10.8505,
        longitude: 76.2711,
        description:
            'Kerala is a state in southern India known as "God\'s Own Country".',
        majorCities: ['Kochi', 'Thiruvananthapuram', 'Kozhikode', 'Thrissur'],
        language: 'Malayalam',
        area: 38852,
        population: 33406061,
      ),
    ];
    notifyListeners();
  }

  void selectState(IndianState state) {
    _selectedState = state;
    notifyListeners();
  }

  void clearSelection() {
    _selectedState = null;
    notifyListeners();
  }

  IndianState? getStateByName(String name) {
    try {
      return _states.firstWhere((state) => state.name == name);
    } catch (e) {
      return null;
    }
  }

  List<IndianState> searchStates(String query) {
    if (query.isEmpty) return _states;

    return _states.where((state) {
      return state.name.toLowerCase().contains(query.toLowerCase()) ||
          state.capital.toLowerCase().contains(query.toLowerCase()) ||
          state.majorCities.any(
            (city) => city.toLowerCase().contains(query.toLowerCase()),
          );
    }).toList();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
