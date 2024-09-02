import "package:flutter/material.dart";
import "package:flutter_mobile_template/src/base/local_storage/ilocal_storage.dart";
import "package:flutter_mobile_template/src/base/local_storage/implementations/shared_preferences_storage.dart";
import "package:flutter_mobile_template/src/core/types/json_mapper.dart";

void main() {
  runApp(const MainApp());
}

class TestModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TestModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });
}

class TestModelMapper implements JsonMapper<TestModel> {
  @override
  TestModel fromJson(Map<String, dynamic> json) {
    return TestModel(
      userId: json["userId"] as int,
      id: json["id"] as int,
      title: json["title"] as String,
      completed: json["completed"] as bool,
    );
  }

  @override
  Map<String, dynamic> toJson(TestModel data) {
    return {
      "userId": data.userId,
      "id": data.id,
      "title": data.title,
      "completed": data.completed,
    };
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Hello World!"),
              TextButton(
                onPressed: () async {
                  final ILocalStorage storage = SharedPreferencesAsyncStorage();
                  await storage.init();

                  await storage.delete(collection: "batata", key: "abc");

                  final res = await storage.save<int>(
                    collection: "batata",
                    key: "abc",
                    value: 1,
                  );

                  final result = await storage.get<int>(
                    collection: "batata",
                    key: "abc",
                  );

                  await storage.delete(collection: "batata", key: "abc");

                  final result2 = await storage.get<int>(
                    collection: "batata",
                    key: "abc",
                  );

                  return;
                },
                child: Text("aqui"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
