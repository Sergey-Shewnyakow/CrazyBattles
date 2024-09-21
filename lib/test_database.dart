import 'dart:async';
import 'dart:io';
import 'package:mysql1/mysql1.dart';

Future main() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '1234',
    db: 'database_name'));

  // Создание таблицы
  await conn.query(
    'CREATE TABLE users (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(255), tgID varchar(255))');

  // Вставка данных
  var result = await conn.query(
    'insert into users (name, tgID) values (?, ?)',
    ['Vlad', 'lahta_vlad']);
  print('Inserted row id=${result.insertId}');

  // Запрос базы данных с параметризованным запросом
  var results = await conn .query('select name, tgID from users where id = ?', [result.insertId]);
  for (var row in results) {
    print('Name: ${row}, [0] tgID: ${row}');
  }

  // Закрытие соединения
  await conn.close();
}