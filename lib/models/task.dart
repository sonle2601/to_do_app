import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String id;
  final String description;
  final String title;
  final String date;
  bool? isFavorite;
  bool? isDone;
  bool ?isDeleted;

  Task( {required this.date, this.isFavorite,required this.description,required this.id,required this.title,  this.isDone,  this.isDeleted}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavorite = isFavorite ?? false;
  }

  Task copyWith({String? description,String? id,String? title,String? date, bool? isFavorite, bool? isDone, bool? isDeleted}) {
    return Task(
        description: description ?? this.description,
        id: id ?? this.id,
        title: title ?? this.title,
        isDone: isDone ?? this.isDone,
        isDeleted: isDeleted ?? this.isDeleted,
        date: date ?? this.date,
        isFavorite: isFavorite ?? this.isFavorite
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description' : this.description,
      'id' : this.id,
      'title': this.title,
      'date' : this.date,
      'isFavorite' : this.isFavorite,
      'isDone': this.isDone,
      'isDeleted': this.isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      description:  map['description'] as String,
      id: map['id'] as String,
      title: map['title'] as String,
      date: map['date'] as String,
      isFavorite: map['isFavorite'] as bool,
      isDone: map['isDone'] as bool,
      isDeleted: map['isDeleted'] as bool,
    );
  }

  @override
  List<Object?> get props => [
    description,
    id,
    date,
    isFavorite,
    title,
    isDone,
    isDeleted
  ];
}
