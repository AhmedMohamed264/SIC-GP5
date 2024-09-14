import 'package:sic_home/models/create_section_model.dart';
import 'package:sic_home/models/section.dart';
import 'package:sic_home/models/update_section_model.dart';

abstract class ISectionsRepository {
  Future<Section> getSectionById(int id);

  Future<List<Section>> getSectionsByUser(String userId);

  Future<List<Section>> getSectionsByPlace(int placeId);

  Future<void> createSection(CreateSectionModel section);

  Future<void> updateSection(int id, UpdateSectionModel section);

  Future<void> deleteSection(int id);
}
