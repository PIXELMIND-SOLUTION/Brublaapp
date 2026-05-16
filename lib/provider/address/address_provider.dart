// import 'package:brublaapp/helper/shared_preference.dart';
// import 'package:brublaapp/services/address/address_services.dart';
// import 'package:flutter/foundation.dart';
// import 'package:brublaapp/model/address_model.dart';

// enum AddressStatus { initial, loading, success, error }

// class AddressProvider extends ChangeNotifier {
//   AddressProvider({AddressService? service})
//     : _service = service ?? AddressService();

//   final AddressService _service;

//   List<AddressModel> _addresses = [];
//   AddressStatus _status = AddressStatus.initial;
//   String? _errorMessage;

//   List<AddressModel> get addresses => List.unmodifiable(_addresses);
//   AddressStatus get status => _status;
//   String? get errorMessage => _errorMessage;
//   bool get isLoading => _status == AddressStatus.loading;

//   AddressModel? get defaultAddress {
//     try {
//       return _addresses.firstWhere((a) => a.isDefault);
//     } catch (_) {
//       return _addresses.isNotEmpty ? _addresses.first : null;
//     }
//   }

//   Future<void> fetchAddresses() async {
//     final userId = SharedPrefsHelper.getUserId();
//     final token = SharedPrefsHelper.getAuthToken();
//     if (userId == null || token == null) {
//       _setError('User not logged in');
//       return;
//     }

//     _setLoading();
//     try {
//       _addresses = await _service.getAllAddresses(userId: userId, token: token);
//       _setSuccess();
//     } catch (e) {
//       _setError(e.toString());
//     }
//   }

//   Future<bool> addAddress(AddressModel address) async {
//     final userId = SharedPrefsHelper.getUserId();
//     final token = SharedPrefsHelper.getAuthToken();
//     if (userId == null || token == null) {
//       _setError('User not logged in');
//       return false;
//     }

//     _setLoading();
//     try {
//       _addresses = await _service.addAddress(
//         userId: userId,
//         token: token,
//         address: address,
//       );
//       _setSuccess();
//       return true;
//     } catch (e) {
//       _setError(e.toString());
//       return false;
//     }
//   }

//   Future<bool> updateAddress({
//     required String addressId,
//     required AddressModel address,
//   }) async {
//     final userId = SharedPrefsHelper.getUserId();
//     final token = SharedPrefsHelper.getAuthToken();
//     if (userId == null || token == null) {
//       _setError('User not logged in');
//       return false;
//     }

//     _setLoading();
//     try {
//       _addresses = await _service.updateAddress(
//         userId: userId,
//         addressId: addressId,
//         token: token,
//         address: address,
//       );
//       _setSuccess();
//       return true;
//     } catch (e) {
//       _setError(e.toString());
//       return false;
//     }
//   }

//   Future<bool> deleteAddress(String addressId) async {
//     final userId = SharedPrefsHelper.getUserId();
//     final token = SharedPrefsHelper.getAuthToken();
//     if (userId == null || token == null) {
//       _setError('User not logged in');
//       return false;
//     }

//     _setLoading();
//     try {
//       _addresses = await _service.deleteAddress(
//         userId: userId,
//         addressId: addressId,
//         token: token,
//       );
//       _setSuccess();
//       return true;
//     } catch (e) {
//       _setError(e.toString());
//       return false;
//     }
//   }

//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }

//   void _setLoading() {
//     _status = AddressStatus.loading;
//     _errorMessage = null;
//     notifyListeners();
//   }

//   void _setSuccess() {
//     _status = AddressStatus.success;
//     _errorMessage = null;
//     notifyListeners();
//   }

//   void _setError(String message) {
//     _status = AddressStatus.error;
//     _errorMessage = message;
//     notifyListeners();
//   }
// }













import 'package:brublaapp/helper/shared_preference.dart';
import 'package:brublaapp/services/address/address_services.dart';
import 'package:flutter/foundation.dart';
import 'package:brublaapp/model/address_model.dart';

enum AddressStatus { initial, loading, success, error }

class AddressProvider extends ChangeNotifier {
  AddressProvider({AddressService? service})
    : _service = service ?? AddressService();

  final AddressService _service;

  List<AddressModel> _addresses = [];
  AddressStatus _status = AddressStatus.initial;
  String? _errorMessage;

  List<AddressModel> get addresses => List.unmodifiable(_addresses);
  AddressStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == AddressStatus.loading;

  AddressModel? get defaultAddress {
    try {
      return _addresses.firstWhere((a) => a.isDefault);
    } catch (_) {
      return _addresses.isNotEmpty ? _addresses.first : null;
    }
  }

  Future<void> fetchAddresses() async {
    final userId = SharedPrefsHelper.getUserId();
    final token = SharedPrefsHelper.getAuthToken();
    if (userId == null || token == null) {
      _setError('User not logged in');
      return;
    }

    _setLoading();
    try {
      _addresses = await _service.getAllAddresses(userId: userId, token: token);
      _setSuccess();
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<bool> addAddress(List<AddressModel> addresses) async {
    final userId = SharedPrefsHelper.getUserId();
    final token = SharedPrefsHelper.getAuthToken();
    if (userId == null || token == null) {
      _setError('User not logged in');
      return false;
    }

    _setLoading();
    try {
      _addresses = await _service.addAddress(
        userId: userId,
        token: token,
        addresses: addresses, 
      );
      _setSuccess();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  Future<bool> updateAddress({
    required String addressId,
    required AddressModel address,
  }) async {
    final userId = SharedPrefsHelper.getUserId();
    final token = SharedPrefsHelper.getAuthToken();
    if (userId == null || token == null) {
      _setError('User not logged in');
      return false;
    }

    _setLoading();
    try {
      _addresses = await _service.updateAddress(
        userId: userId,
        addressId: addressId,
        token: token,
        address: address,
      );
      _setSuccess();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  Future<bool> deleteAddress(String addressId) async {
    final userId = SharedPrefsHelper.getUserId();
    final token = SharedPrefsHelper.getAuthToken();
    if (userId == null || token == null) {
      _setError('User not logged in');
      return false;
    }

    _setLoading();
    try {
      _addresses = await _service.deleteAddress(
        userId: userId,
        addressId: addressId,
        token: token,
      );
      _setSuccess();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading() {
    _status = AddressStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setSuccess() {
    _status = AddressStatus.success;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = AddressStatus.error;
    _errorMessage = message;
    notifyListeners();
  }
}