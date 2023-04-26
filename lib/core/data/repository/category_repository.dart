import 'package:afisha_market/core/data/source/remote/response/ProductCategoryResponse.dart';
import 'package:afisha_market/core/data/source/remote/response/UserCategoryResponse.dart';
import 'package:afisha_market/core/handlers/api_result.dart';

abstract class CategoryRepository{
  Future<ApiResult<ProductCategoryResponse>> getProductCategoryList();
  Future<ApiResult<UserCategoryResponse>> getUserCategoryList();

}