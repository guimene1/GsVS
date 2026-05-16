import 'package:flutter/material.dart';
import 'package:frontend/data/models/access_profile_model.dart';
import 'package:frontend/data/repositories/access_profile_repository.dart';

class AccessProfileController extends ChangeNotifier {
  final AccessProfileRepository _repository;

  List<AccessProfileModel> _profiles = [];
  List<SystemModuleModel> _modules = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<AccessProfileModel> get profiles => _profiles;
  List<SystemModuleModel> get modules => _modules;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AccessProfileController({AccessProfileRepository? repository})
      : _repository = repository ?? AccessProfileRepositoryImpl();


  Future<void> loadData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _profiles = await _repository.getAll();
      _modules = await _repository.getAllModules();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createProfile(AccessProfileModel profile) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final newProfile = await _repository.create(profile);
      _profiles.add(newProfile);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(AccessProfileModel profile) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final updatedProfile = await _repository.update(profile);
      final index = _profiles.indexWhere((p) => p.id == updatedProfile.id);
      if (index != -1) {
        _profiles[index] = updatedProfile;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProfile(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _repository.delete(id);
      _profiles.removeWhere((p) => p.id == id);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> toggleActive(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final newIsActive = await _repository.toggleActive(id);
      final index = _profiles.indexWhere((p) => p.id == id);
      if (index != -1) {
        _profiles[index] = _profiles[index].copyWith(isActive: newIsActive);
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}