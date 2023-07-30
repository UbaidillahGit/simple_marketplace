// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelCartsAdapter extends TypeAdapter<ModelCarts> {
  @override
  final int typeId = 1;

  @override
  ModelCarts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    // ignore: unused_local_variable
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelCarts();
  }

  @override
  void write(BinaryWriter writer, ModelCarts obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelCartsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductCheckOutAdapter extends TypeAdapter<ProductCheckOut> {
  @override
  final int typeId = 2;

  @override
  ProductCheckOut read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductCheckOut(
      id: fields[0] as int?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      price: fields[3] as int?,
      discountPercentage: fields[4] as double?,
      rating: fields[5] as dynamic,
      stock: fields[6] as int?,
      brand: fields[7] as String?,
      category: fields[8] as String?,
      thumbnail: fields[9] as String?,
      images: (fields[10] as List?)?.cast<String>(),
      quantity: fields[11] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductCheckOut obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.discountPercentage)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.stock)
      ..writeByte(7)
      ..write(obj.brand)
      ..writeByte(8)
      ..write(obj.category)
      ..writeByte(9)
      ..write(obj.thumbnail)
      ..writeByte(10)
      ..write(obj.images)
      ..writeByte(11)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCheckOutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
