import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Repository<T> {
  final CollectionReference<Map<String, dynamic>> collection;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  Repository(
      {required this.collection, required this.fromJson, required this.toJson});

  Future<List<T>> getAll() async {
    try {
      final querySnapshot = await collection.get();
      final List<T> items = [];
      querySnapshot.docs.forEach((element) {
        items.add(fromJson({"_id": element.id, ...element.data()}));
      });
      return items;
    } catch (e) {
      throw Exception('Failed to load data from Firestore: $e');
    }
  }

  Future<String> create(T item) async {
    try {
      DocumentReference<Map<String, dynamic>> response = await collection.add(toJson(item));
      return response.id;
    } catch (e) {
      throw Exception('Failed to add data to Firestore: $e');
    }
  }

  Future<void> update(String id, T item) async {
    try {
      await collection.doc(id).set(toJson(item));
    } catch (e) {
      throw Exception('Failed to update data in Firestore: $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete data from Firestore: $e');
    }
  }

  Future<List<T>> getAllByField(String field,var param) async {
   try {
      final querySnapshot = await collection.where(field,isEqualTo: param).get();
      final List<T> items = [];
      querySnapshot.docs.forEach((element) {
        items.add(fromJson({"_id": element.id, ...element.data()}));
      });
      return items;
    } catch (e) {
      throw Exception('Failed to load data from Firestore: $e');
    } 
  }
}

