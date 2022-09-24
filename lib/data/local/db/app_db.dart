import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_drift/data/local/entity/employee_entity.dart';

part 'app_db.g.dart';

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'app_database.db'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Employee])
class AppDB extends _$AppDB {
  AppDB() : super(openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertEmployee(EmployeeCompanion entity) async {
    return await into(employee).insert(entity);
  }

  Future<int> deleteEmployee(int id) async {
    return await (delete(employee)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<EmployeeData>> getAllEmployees() async {
    return await select(employee).get();
  }

  Future<bool> updateEmployee(EmployeeCompanion entity) async {
    return await update(employee).replace(entity);
  }

  Future getEmployeeById(int id) async {
    return await (select(employee)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }
}
