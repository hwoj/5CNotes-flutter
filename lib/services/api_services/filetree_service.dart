import 'dart:convert';

import 'package:fivec_notes/models/file.dart';
import 'package:http/http.dart';

/// This class encapsulates all the interfaces for [File] objects in the local file system as well as the OT and REST API
///
/// The service class will handle background synchronization, offline file updates, online file updates and refreshing the local file system upon opening the app
class FileTreeService {

  /// This is a constant holding the value for the period for background syncs. 
  /// The [Duration] data type is here to allow for calculations with date times 
  static const Duration refreshPeriod = Duration(hours: 1);

  /// This DateTime value holds the time for the last file sync according to the server time. 
  /// This value will be updated each time the entire local filesystem is updated. 
  /// It uses server time to ensure consistency across components
  static DateTime? lastSync;

  /// This function calls to update the local file tree in the background
  /// 
  /// Every [refreshPeriod] the backgroundSync function will be called to update the files in the local filesystem.
  /// Upon updating it will update the lastSync class variable with the server time from the last update of the files.
  /// The server time is expected to be sent along with the data that the backgroundSync requests.
  /// The function is called under the assumption that it is supposed to be time to call the backgroundSync. 
  /// The functionality to determine when this should be performed is handled separately.
  backgroundSync() {
    // A GET request will be sent to the backend server requesting the last update times for each of the files the logged in user has access to

    // For each of the files and update times returned, check to see if the local file needs to be updates
    // If a file needs updates, request the updated contents of the file. 
    // Update the local meta data with the update time of the file from the Postgres database

    // Update the lastSync time with the server time from the synchronization

  }

  /// This function retrieves the directories and files that the [User] has access to
  ///
  /// This function is called to help initialize the [FileTree] widget
  retrieveFileTree() {
    
  }

  /// Gets the contents of a file using the file metadata
  ///
  /// Requests the contents of the file from the backend using the id from the [file] argument
  static Future<File> getFile(String uuid) async {
    // send get request to server to get contents of the file using the id of the file passed into the function
    final response = await get(Uri.parse("http://localhost:8080/files/${uuid}"));
    // overwrite the contents of the local file or create new file on disk if doesn't exist on disk yet
    if (response.statusCode == 200) {
      return File.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load ur mom');
    }
  }

  static Future<File> sendFile(String name, String author, String course) async {
    final response = await post(
      Uri.parse('http://localhost:8080/file'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'author': author,
        'name': name,
        'course': course,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return File.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }

  }

}