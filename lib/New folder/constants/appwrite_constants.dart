
//setting up appwrite constants
class AppwriteConstants {
  static const String databaseId = '<your db id>';
  static const String projectId = '<your project id>';

  static const String endPoint = 'https://cloud.appwrite.io/v1';
  static const String usersCollection = '';
  static const String tweetsCollection = '';


  static const String imagesBucket = '';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
