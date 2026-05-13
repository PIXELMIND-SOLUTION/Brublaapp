import 'package:dio/dio.dart';
import 'package:brublaapp/constant/api_constant.dart';
import 'package:brublaapp/model/address_model.dart';

class AddressService {
  AddressService({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options
      ..connectTimeout = ApiConstants.connectTimeout
      ..receiveTimeout = ApiConstants.receiveTimeout
      ..headers = {ApiConstants.contentType: ApiConstants.applicationJson};
  }

  final Dio _dio;

  Options _authHeader(String token) => Options(
    headers: {ApiConstants.authorization: '${ApiConstants.bearer} $token'},
  );

  Future<List<AddressModel>> addAddress({
    required String userId,
    required String token,
    required AddressModel address,
  }) async {
    final response = await _dio.post(
      ApiConstants.addAddress(userId),
      data: address.toJson(),
      options: _authHeader(token),
    );

    print('✅ Status Code for add address: ${response.statusCode}');
    print('🧾 Response Body for add address: ${response.data}');

    _assertSuccess(response.data);

    return getAllAddresses(userId: userId, token: token);
  }

  Future<List<AddressModel>> getAllAddresses({
    required String userId,
    required String token,
  }) async {
    final response = await _dio.get(
      ApiConstants.getAllAddresses(userId),
      options: _authHeader(token),
    );

    print('🔄 Status Code for get all  address: ${response.statusCode}');
    print('🔍 Response Body for get all address: ${response.data}');

    _assertSuccess(response.data);

    final List<dynamic> raw =
        response.data[ApiConstants.keyAddresses] as List<dynamic>;
    return raw
        .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<AddressModel>> updateAddress({
    required String userId,
    required String addressId,
    required String token,
    required AddressModel address,
  }) async {
    final response = await _dio.put(
      ApiConstants.updateAddress(userId, addressId),
      data: address.toJson(),
      options: _authHeader(token),
    );

    print('📶 Status Code for update: ${response.statusCode}');
    print('📡 Response Body for update: ${response.data}');

    _assertSuccess(response.data);

    return getAllAddresses(userId: userId, token: token);
  }

  Future<List<AddressModel>> deleteAddress({
    required String userId,
    required String addressId,
    required String token,
  }) async {
    final response = await _dio.delete(
      ApiConstants.deleteAddress(userId, addressId),
      options: _authHeader(token),
    );

    print('🚀 Status Code for delete: ${response.statusCode}');
    print('🧰 Response Body for delete: ${response.data}');

    _assertSuccess(response.data);

    return getAllAddresses(userId: userId, token: token);
  }

  void _assertSuccess(dynamic data) {
    if (data is! Map<String, dynamic>) {
      throw Exception('Unexpected response format');
    }
    final success = data[ApiConstants.keySuccess];
    if (success != true) {
      final message =
          data[ApiConstants.keyMessage] as String? ?? 'Something went wrong';
      throw Exception(message);
    }
  }
}
