import 'package:flutter_movies_app/data/database/entity/movie_db_entity.dart';
import 'package:sqflite/sqflite.dart';

import 'base_dao.dart';

class MoviesDao extends BaseDao {
  Future<List<MovieDbEntity>> selectAll({int? limit, int? offset}) async {
    final Database db = await getDb();
    final List<Map<String, dynamic>> maps = await db.query(
      BaseDao.moviesTableName,
      limit: limit,
      offset: offset,
      orderBy: '${MovieDbEntity.fieldId} ASC',
    );
    return List.generate(
        maps.length, (index) => MovieDbEntity.fromJson(maps[index]));
  }

  Future<void> insertAll(List<MovieDbEntity> entities) async {
    final Database db = await getDb();
    await db.transaction((txn) async {
      for (final entity in entities) {
        txn.insert(BaseDao.moviesTableName, entity.toJson());
      }
    });
  }

  Future<void> deleteAll() async {
    final Database db = await getDb();
    await db.delete(BaseDao.moviesTableName);
  }
}
