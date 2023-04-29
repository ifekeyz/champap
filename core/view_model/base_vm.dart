import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isDisposed = false;
  bool _isInitializeDone = false;
  bool _isVisible = false;
  bool _isNewPassVisible = false;
  bool _isConfirmPassVisible = false;

  FutureOr<void> _initState;

  BaseViewModel() {
    _init();
  }

  FutureOr<void> init();

  void _init() async {
    this.isLoading = true;
    _initState = init();
    await _initState;
    this._isInitializeDone = true;
    this.isLoading = false;
  }

  void changeStatus() => isLoading = !isLoading;

  void setLoadingState(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setVisibleState(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  void setNewPassVisibleState(bool value) {
    _isNewPassVisible = value;
    notifyListeners();
  }

  void setConfirmPassVisibleState(bool value) {
    _isConfirmPassVisible = value;
    notifyListeners();
  }

  void reloadState() {
    if (!isLoading) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  //Getters
  FutureOr<void>? get initState => _initState;

  bool get isLoading => _isLoading;
  bool get isDisposed => _isDisposed;
  bool get isInitialized => _isInitializeDone;
  bool get isVisible => _isVisible;
  bool get isNewPassVisible => _isNewPassVisible;
  bool get isConfirmPassVisible => _isConfirmPassVisible;

  //Setters
  set isLoading(bool value) {
    _isLoading = value;
    scheduleMicrotask(() {
      if (!_isDisposed) notifyListeners();
    });
  }

  set isVisible(bool value) {
    _isVisible = value;
    scheduleMicrotask(() {
      if (!_isDisposed) notifyListeners();
    });
  }
}
