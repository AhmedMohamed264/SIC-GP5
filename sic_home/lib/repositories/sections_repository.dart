import 'package:dio/dio.dart';
import 'package:sic_home/apis/sections_api.dart';
import 'package:sic_home/models/create_section_model.dart';
import 'package:sic_home/models/section.dart';
import 'package:sic_home/models/update_section_model.dart';
import 'package:sic_home/repositories/interfaces/i_sections_repository.dart';

class SectionsRepository implements ISectionsRepository {
  final SectionsApi _sectionsApi = SectionsApi(Dio());

  @override
  Future<void> createSection(CreateSectionModel section) async {
    return await _sectionsApi.createSection(section);
  }

  @override
  Future<void> deleteSection(int id) async {
    return await _sectionsApi.deleteSection(id);
  }

  @override
  Future<Section> getSectionById(int id) async {
    return await _sectionsApi.getSection(id);
  }

  @override
  Future<List<Section>> getSectionsByPlace(int placeId) async {
    return await _sectionsApi.getSectionsByPlace(placeId);
  }

  @override
  Future<List<Section>> getSectionsByUser(String userId) async {
    return await _sectionsApi.getSectionsByUser(userId);
  }

  @override
  Future<void> updateSection(int id, UpdateSectionModel section) async {
    return await _sectionsApi.updateSection(id, section);
  }
}
