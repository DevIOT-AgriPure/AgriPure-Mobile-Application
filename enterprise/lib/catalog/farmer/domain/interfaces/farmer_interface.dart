import 'package:agripure_mobile/catalog/farmer/domain/entity/farmer.dart';

abstract class FarmerInterface {
  Future<List<Farmer>> fetchProducts();
  Future<Farmer> getProduct(String id);
}