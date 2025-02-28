import 'package:flutter/material.dart';
import 'package:suitmedia_test/data/api/api_service.dart';
import 'package:suitmedia_test/static/sealed/user_list_result_state.dart';

class UserProvider extends ChangeNotifier {
  final ApiService _service;
  int _currentPage = 1;
  final int _perPage = 10;
  bool _isLoading = false;
  bool _hasMoreData = true;

  UserProvider(this._service);

  UserListResultState _resultState = UserListNoneState();

  UserListResultState get resultState => _resultState;
  bool get isLoading => _isLoading;

  Future<void> getUserList({bool isRefresh = false}) async {
    if (_isLoading || !_hasMoreData) return;

    try {
      if (isRefresh) {
        _currentPage = 1;
        _hasMoreData = true;
      }

      _isLoading = true;
      if (isRefresh || _resultState is! UserListSuccessState) {
        _resultState = UserListLoadingState();
        notifyListeners();
      }

      final result = await _service.getListUsers(_currentPage, _perPage);

      if (result.data.isEmpty) {
        if (_currentPage == 1) {
          _resultState = UserListErrorState('Users not found');
        }
        _hasMoreData = false;
      } else {
        final currentData =
            (_resultState is UserListSuccessState)
                ? (_resultState as UserListSuccessState).data
                : [];

        _resultState = UserListSuccessState(
          isRefresh ? result.data : [...currentData, ...result.data],
        );

        if (result.data.length < _perPage) {
          _hasMoreData = false;
        } else {
          _currentPage++;
        }
      }
    } catch (e) {
      _resultState = UserListErrorState(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
