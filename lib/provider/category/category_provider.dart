import 'package:brublaapp/model/category_model.dart';
import 'package:brublaapp/services/category/category_service.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

enum CategoryStatus { initial, loading, success, error }

class CategoryProvider extends ChangeNotifier {
  // final CategoryService _service;

  final CategoryService _service = CategoryService();

  // CategoryProvider(Dio dio) : _service = CategoryService(dio);

  CategoryStatus _status = CategoryStatus.initial;
  List<CategoryModel> _categories = [];


  String? _tabFilter;

  List<SubcategoryModel> _subcategories = [];
  List<SubcategoryModel> get subcategories => _subcategories;

  CategoryModel? _selectedCategory;
  String? _errorMessage;


  List<CategoryModel> get filteredCategories {
  if (_tabFilter == null) return activeCategories;
  return activeCategories
      .where((c) => c.name.toLowerCase().contains(_tabFilter!.toLowerCase()))
      .toList();
}


  CategoryStatus get status => _status;
  List<CategoryModel> get categories => _categories;
  CategoryModel? get selectedCategory => _selectedCategory;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _status == CategoryStatus.loading;
  bool get hasError => _status == CategoryStatus.error;

  List<CategoryModel> get activeCategories =>
      _categories.where((c) => c.isActive).toList();

  List<SubcategoryModel> get activeSubcategoriesList =>
      _subcategories.where((s) => s.isActive).toList();

  List<SubcategoryModel> activeSubcategories(String categoryId) {
    final cat = _categories.firstWhere(
      (c) => c.id == categoryId,
      orElse: () => throw StateError('Category $categoryId not found'),
    );
    return cat.subcategories.where((s) => s.isActive).toList();
  }

  Future<void> fetchAllCategories({String? token}) async {
    _setLoading();
    try {
      _categories = await _service.getAllCategories(token: token);
      _setSuccess();
    } on DioException catch (e) {
      _setError(_dioMessage(e));
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> fetchCategoryById(String categoryId, {String? token}) async {
    _setLoading();
    try {
      _selectedCategory = await _service.getCategoryById(
        categoryId,
        token: token,
      );
      _setSuccess();
    } on DioException catch (e) {
      _setError(_dioMessage(e));
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> fetchSubcategories(String categoryId, {String? token}) async {
    _setLoading();
    try {
      _subcategories = await _service.getSubcategories(
        categoryId,
        token: token,
      );
      _setSuccess();
    } on DioException catch (e) {
      _setError(_dioMessage(e));
    } catch (e) {
      _setError(e.toString());
    }
  }

  void clearSelectedCategory() {
    _selectedCategory = null;
    notifyListeners();
  }


  void setTabFilter(String? filter) {
  _tabFilter = filter;
  _subcategories = [];
  notifyListeners();
}

  void clearSubcategories() {
    _subcategories = [];
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    if (_status == CategoryStatus.error) {
      _status = CategoryStatus.initial;
    }
    notifyListeners();
  }

  void _setLoading() {
    _status = CategoryStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setSuccess() {
    _status = CategoryStatus.success;
    notifyListeners();
  }

  void _setError(String message) {
    _status = CategoryStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  String _dioMessage(DioException e) =>
      e.response?.data?['message'] as String? ?? e.message ?? 'Network error';
}
