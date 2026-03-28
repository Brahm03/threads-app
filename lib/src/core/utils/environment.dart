import 'package:appwrite/appwrite.dart';
import 'package:threads_app/src/core/utils/mixin_listen_toLoction.dart';

class Environment {
  static final Environment instance = Environment._internal();
  Environment._internal();
  late Client client;
  late Storage storage;

  void init() {
    client = Client()
      ..setEndpoint(Environment.instance.endPoint)
      ..setProject(Environment.instance.projectID);
    storage = Storage(client);
  }

  final String projectID = "69c2aeb8003cf0904ae2";
  final String projectName = "Threads app";
  final String bucketID = "media_storage_123";
  final String endPoint = "https://sgp.cloud.appwrite.io/v1";
}
