const String collectionBus = 'Bus';
const String busFieldId = 'busID';
const String busFieldImage = 'Image';
const String busFieldName = 'Bus Name';
const String busFieldType = 'Bus type';
const String busFieldPassengerCategory = 'PassengerCategory';
const String busFieldStudentRent = 'studentRent';

class BusModel {
  String? busId;
  String? busImage;
  String busName;
  String busType;

  String passengerCategory;
  num studentRent;

  BusModel(
      {this.busId,
        this.busImage,
        required this.busName,
        required this.busType,
        required this.passengerCategory,
        required this.studentRent,
        });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      busFieldId: busId,
      busFieldImage: busImage,
      busFieldName:busName,
      busFieldType: busType,
      busFieldPassengerCategory: passengerCategory,
      busFieldStudentRent: studentRent,
    };
  }

  factory BusModel.fromMap(Map<String, dynamic> map) => BusModel(
      busId: map[busFieldId],
      busImage: map[busFieldImage],
      busName: map[busFieldName],
      busType: map[busFieldType],
      passengerCategory: map[busFieldPassengerCategory],
      studentRent: map[busFieldStudentRent],
   );
}
