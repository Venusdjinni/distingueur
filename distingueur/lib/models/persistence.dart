import 'package:moor_flutter/moor_flutter.dart';

part 'persistence.g.dart';

@DataClassName("Address")
class Addresses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get site => text()();
  TextColumn get as => text()();
  TextColumn get rd => text()();
}

@UseMoor(tables: [Addresses])
class Database extends _$Database {
  Database._() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  static Database? _instance;

  static Database get instance => _instance ??= Database._();

  @override
  int get schemaVersion => 1;

  Future<List<Address>> getAllAddresses() {
    return select(addresses).get();
  }

  /// dit si oui ou non le rd passé en paramètre est déjà utilisé
  Future<bool> rdIsUsed(String rd) async {
    return (await (select(addresses)..where((tbl) => tbl.rd.equals(rd))..limit(1)).getSingleOrNull()) != null;
  }

  Future<void> saveAddress({
    required String site,
    required String as,
    required String rd,
  }) {
    AddressesCompanion companion = AddressesCompanion.insert(
      site: site,
      as: as,
      rd: rd
    );

    return into(addresses).insert(companion);
  }

  /// recherche la chaine dans chacun des champs
  Future<List<Address>> searchAddresses(String query) async {
    List<Address> siteResults = await (select(addresses)..where((tbl) => tbl.site.contains(query))).get();
    List<Address> asResults = await (select(addresses)..where((tbl) => tbl.as.contains(query))).get();
    List<Address> rdResults = await (select(addresses)..where((tbl) => tbl.rd.contains(query))).get();

    return siteResults + asResults + rdResults;
  }
}
