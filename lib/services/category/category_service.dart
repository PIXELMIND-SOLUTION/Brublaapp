import 'package:brublaapp/constant/api_constant.dart';
import 'package:brublaapp/model/category_model.dart';
import 'package:dio/dio.dart';

class CategoryService {
   final Dio _dio = Dio(BaseOptions(
    connectTimeout: ApiConstants.connectTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
  ));

  // CategoryService(this._dio);
  Future<List<CategoryModel>> getAllCategories({String? token}) async {
    final response = await _dio.get(
      ApiConstants.getAllCategories,
      options: _authOptions(token),
    );

    print(
      'Response Status Code for get all categories: ${response.statusCode}',
    );

    print('Response Body for get all categories: ${response.data}');

    final data = response.data as Map<String, dynamic>;
    _assertSuccess(data);

    final rawList = data[ApiConstants.keyCategories] as List<dynamic>;
    return rawList
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<CategoryModel> getCategoryById(
    String categoryId, {
    String? token,
  }) async {
    final response = await _dio.get(
      ApiConstants.getCategoryById(categoryId),
      options: _authOptions(token),
    );

    print(
      'Response Status Code for singleeeeeeeeee categories: ${response.statusCode}',
    );

    print(
      'Response Body for get singleeeeeeeeeeeeeeeee categories: ${response.data}',
    );

    final data = response.data as Map<String, dynamic>;
    _assertSuccess(data);
    if (data.containsKey(ApiConstants.keyCategory)) {
      return CategoryModel.fromJson(
        data[ApiConstants.keyCategory] as Map<String, dynamic>,
      );
    }

    final rawList = data[ApiConstants.keyCategories] as List<dynamic>;
    return CategoryModel.fromJson(rawList.first as Map<String, dynamic>);
  }




  Future<List<SubcategoryModel>> getSubcategories(
  String categoryId, {
  String? token,
}) async {
  final response = await _dio.get(
    ApiConstants.subCategories(categoryId),
    options: _authOptions(token),
  );

  print('Response Status Code for subcategories: ${response.statusCode}');
  print('Response Body for subcategories: ${response.data}');

  final data = response.data as Map<String, dynamic>;
  _assertSuccess(data);

  final rawList = data[ApiConstants.keySubcategories] as List<dynamic>;
  return rawList
      .map((e) => SubcategoryModel.fromJson(e as Map<String, dynamic>))
      .toList();
}

  Options _authOptions(String? token) {
    if (token == null) return Options();
    return Options(
      headers: {ApiConstants.authorization: '${ApiConstants.bearer} $token'},
    );
  }

  void _assertSuccess(Map<String, dynamic> data) {
    final success = data[ApiConstants.keySuccess] as bool? ?? false;
    if (!success) {
      throw Exception(
        data[ApiConstants.keyMessage] ?? 'Category request failed',
      );
    }
  }
}
