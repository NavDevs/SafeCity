import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';
import '../models/emergency_contact.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isLoading = true;
  ThemeMode _themeMode = ThemeMode.system;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String get userName => _currentUser?.name ?? 'User';
  String get userEmail => _currentUser?.email ?? '';
  String get userPhone => _currentUser?.phone ?? '';
  String get userEmergencyContact => _currentUser?.emergencyContact ?? '';
  List<EmergencyContact> get userEmergencyContacts =>
      _currentUser?.emergencyContacts ?? [];
  ThemeMode get themeMode => _themeMode;

  UserProvider() {
    _loadUserFromStorage();
  }

  // Load user from shared preferences
  Future<void> _loadUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('user_data');

      if (userData != null) {
        // Parse user data from JSON
        final userMap = <String, dynamic>{
          'name': prefs.getString('user_name') ?? '',
          'email': prefs.getString('user_email') ?? '',
          'phone': prefs.getString('user_phone') ?? '',
          'emergencyContact': prefs.getString('user_emergency') ?? '',
        };

        // Load emergency contacts
        final emergencyContactsJson = prefs.getString('emergency_contacts');
        if (emergencyContactsJson != null) {
          try {
            final List<dynamic> contactsList = json.decode(
              emergencyContactsJson,
            );
            userMap['emergencyContacts'] = contactsList;
          } catch (e) {
            debugPrint('Error parsing emergency contacts: $e');
            userMap['emergencyContacts'] = <Map<String, dynamic>>[];
          }
        } else {
          userMap['emergencyContacts'] = <Map<String, dynamic>>[];
        }

        if (userMap['name']!.isNotEmpty) {
          _currentUser = User.fromJson(userMap);
          _isLoggedIn = true;
        }
      }

      // Load theme preference
      final savedThemeIndex = prefs.getInt('theme_mode') ?? 0;
      _themeMode = ThemeMode.values[savedThemeIndex];
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Save user and login
  Future<bool> loginUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Save user data to shared preferences
      await prefs.setString('user_name', user.name);
      await prefs.setString('user_email', user.email);
      await prefs.setString('user_phone', user.phone);
      await prefs.setString('user_emergency', user.emergencyContact);
      await prefs.setString('user_data', 'logged_in');

      // Save emergency contacts
      final emergencyContactsJson = json.encode(
        user.emergencyContacts.map((contact) => contact.toJson()).toList(),
      );
      await prefs.setString('emergency_contacts', emergencyContactsJson);

      _currentUser = user;
      _isLoggedIn = true;
      notifyListeners();

      return true;
    } catch (e) {
      debugPrint('Error saving user data: $e');
      return false;
    }
  }

  // Logout user
  Future<void> logoutUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      _currentUser = null;
      _isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error during logout: $e');
    }
  }

  // Update user information
  Future<bool> updateUser(User updatedUser) async {
    try {
      final success = await loginUser(updatedUser);
      return success;
    } catch (e) {
      debugPrint('Error updating user: $e');
      return false;
    }
  }

  // Theme management
  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      _themeMode = mode;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('theme_mode', mode.index);
    } catch (e) {
      debugPrint('Error saving theme preference: $e');
    }
  }

  void toggleTheme() {
    switch (_themeMode) {
      case ThemeMode.system:
        setThemeMode(ThemeMode.light);
        break;
      case ThemeMode.light:
        setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        setThemeMode(ThemeMode.system);
        break;
    }
  }

  // Emergency contacts management
  Future<bool> addEmergencyContact(EmergencyContact contact) async {
    if (_currentUser == null) return false;

    try {
      final updatedContacts = List<EmergencyContact>.from(
        _currentUser!.emergencyContacts,
      )..add(contact);

      final updatedUser = _currentUser!.copyWith(
        emergencyContacts: updatedContacts,
      );
      return await updateUser(updatedUser);
    } catch (e) {
      debugPrint('Error adding emergency contact: $e');
      return false;
    }
  }

  Future<bool> updateEmergencyContact(EmergencyContact updatedContact) async {
    if (_currentUser == null) return false;

    try {
      final updatedContacts = _currentUser!.emergencyContacts
          .map(
            (contact) =>
                contact.id == updatedContact.id ? updatedContact : contact,
          )
          .toList();

      final updatedUser = _currentUser!.copyWith(
        emergencyContacts: updatedContacts,
      );
      return await updateUser(updatedUser);
    } catch (e) {
      debugPrint('Error updating emergency contact: $e');
      return false;
    }
  }

  Future<bool> removeEmergencyContact(String contactId) async {
    if (_currentUser == null) return false;

    try {
      final updatedContacts = _currentUser!.emergencyContacts
          .where((contact) => contact.id != contactId)
          .toList();

      final updatedUser = _currentUser!.copyWith(
        emergencyContacts: updatedContacts,
      );
      return await updateUser(updatedUser);
    } catch (e) {
      debugPrint('Error removing emergency contact: $e');
      return false;
    }
  }
}
