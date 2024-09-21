import "package:flutter/material.dart";
import "package:flutter_mobile_template/src/core/app_envs.dart";
import "package:flutter_mobile_template/src/core/types/json_mapper.dart";
import "package:flutter_mobile_template/src/shared/widgets/debug_box.dart";
import "package:flutter_mobile_template/src/shared/widgets/ui_search_bar.dart";

Future<void> init() async {
  await AppEnvs.init();
}

void main() async {
  await init();
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
              const Text("Hello World!"),
              TextButton(
                onPressed: () async {
                  return;
                },
                child: const Text("Gaudiot"),
              ),
              DebugBox(
                child: UISearchBar(
                  hintText: "Search...",
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
