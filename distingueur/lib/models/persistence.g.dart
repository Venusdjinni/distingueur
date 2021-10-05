// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistence.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Address extends DataClass implements Insertable<Address> {
  final int id;
  final String site;
  final String as;
  final String rd;
  Address(
      {required this.id,
      required this.site,
      required this.as,
      required this.rd});
  factory Address.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Address(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      site: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}site'])!,
      as: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}as'])!,
      rd: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}rd'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['site'] = Variable<String>(site);
    map['as'] = Variable<String>(as);
    map['rd'] = Variable<String>(rd);
    return map;
  }

  AddressesCompanion toCompanion(bool nullToAbsent) {
    return AddressesCompanion(
      id: Value(id),
      site: Value(site),
      as: Value(as),
      rd: Value(rd),
    );
  }

  factory Address.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Address(
      id: serializer.fromJson<int>(json['id']),
      site: serializer.fromJson<String>(json['site']),
      as: serializer.fromJson<String>(json['as']),
      rd: serializer.fromJson<String>(json['rd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'site': serializer.toJson<String>(site),
      'as': serializer.toJson<String>(as),
      'rd': serializer.toJson<String>(rd),
    };
  }

  Address copyWith({int? id, String? site, String? as, String? rd}) => Address(
        id: id ?? this.id,
        site: site ?? this.site,
        as: as ?? this.as,
        rd: rd ?? this.rd,
      );
  @override
  String toString() {
    return (StringBuffer('Address(')
          ..write('id: $id, ')
          ..write('site: $site, ')
          ..write('as: $as, ')
          ..write('rd: $rd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode, $mrjc(site.hashCode, $mrjc(as.hashCode, rd.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Address &&
          other.id == this.id &&
          other.site == this.site &&
          other.as == this.as &&
          other.rd == this.rd);
}

class AddressesCompanion extends UpdateCompanion<Address> {
  final Value<int> id;
  final Value<String> site;
  final Value<String> as;
  final Value<String> rd;
  const AddressesCompanion({
    this.id = const Value.absent(),
    this.site = const Value.absent(),
    this.as = const Value.absent(),
    this.rd = const Value.absent(),
  });
  AddressesCompanion.insert({
    this.id = const Value.absent(),
    required String site,
    required String as,
    required String rd,
  })  : site = Value(site),
        as = Value(as),
        rd = Value(rd);
  static Insertable<Address> custom({
    Expression<int>? id,
    Expression<String>? site,
    Expression<String>? as,
    Expression<String>? rd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (site != null) 'site': site,
      if (as != null) 'as': as,
      if (rd != null) 'rd': rd,
    });
  }

  AddressesCompanion copyWith(
      {Value<int>? id,
      Value<String>? site,
      Value<String>? as,
      Value<String>? rd}) {
    return AddressesCompanion(
      id: id ?? this.id,
      site: site ?? this.site,
      as: as ?? this.as,
      rd: rd ?? this.rd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (site.present) {
      map['site'] = Variable<String>(site.value);
    }
    if (as.present) {
      map['as'] = Variable<String>(as.value);
    }
    if (rd.present) {
      map['rd'] = Variable<String>(rd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AddressesCompanion(')
          ..write('id: $id, ')
          ..write('site: $site, ')
          ..write('as: $as, ')
          ..write('rd: $rd')
          ..write(')'))
        .toString();
  }
}

class $AddressesTable extends Addresses
    with TableInfo<$AddressesTable, Address> {
  final GeneratedDatabase _db;
  final String? _alias;
  $AddressesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _siteMeta = const VerificationMeta('site');
  late final GeneratedColumn<String?> site = GeneratedColumn<String?>(
      'site', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _asMeta = const VerificationMeta('as');
  late final GeneratedColumn<String?> as = GeneratedColumn<String?>(
      'as', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _rdMeta = const VerificationMeta('rd');
  late final GeneratedColumn<String?> rd = GeneratedColumn<String?>(
      'rd', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, site, as, rd];
  @override
  String get aliasedName => _alias ?? 'addresses';
  @override
  String get actualTableName => 'addresses';
  @override
  VerificationContext validateIntegrity(Insertable<Address> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('site')) {
      context.handle(
          _siteMeta, site.isAcceptableOrUnknown(data['site']!, _siteMeta));
    } else if (isInserting) {
      context.missing(_siteMeta);
    }
    if (data.containsKey('as')) {
      context.handle(_asMeta, as.isAcceptableOrUnknown(data['as']!, _asMeta));
    } else if (isInserting) {
      context.missing(_asMeta);
    }
    if (data.containsKey('rd')) {
      context.handle(_rdMeta, rd.isAcceptableOrUnknown(data['rd']!, _rdMeta));
    } else if (isInserting) {
      context.missing(_rdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Address map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Address.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AddressesTable createAlias(String alias) {
    return $AddressesTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AddressesTable addresses = $AddressesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [addresses];
}
