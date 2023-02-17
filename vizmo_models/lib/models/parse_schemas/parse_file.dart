// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
// import 'package:path/path.dart' as path;

// class CustomParseFile extends ParseFileBase {
//   /// Creates a new file
//   ///
//   /// {https://docs.parseplatform.org/rest/guide/#files/}
//   CustomParseFile(this.rawdata, {String name, String url, bool debug, ParseClient client, bool autoSendSessionId})
//       : super(
//           name: file != null ? path.basename(file.path) : name,
//           url: url,
//           debug: debug,
//           client: client,
//           autoSendSessionId: autoSendSessionId,
//         );

//   File file;

//   Uint8List rawdata;

//   final _client =
//       ParseCoreData().clientCreator(sendSessionId: ParseCoreData().autoSendSessionId, securityContext: ParseCoreData().securityContext);

//   Future<CustomParseFile> loadStorage() async {
//     if (name == null) {
//       file = null;
//       return this;
//     }

//     final File possibleFile = File('${ParseCoreData().fileDirectory}/$name');
//     // ignore: avoid_slow_async_io
//     final bool exists = await possibleFile.exists();

//     if (exists) {
//       file = possibleFile;
//     } else {
//       file = null;
//     }

//     return this;
//   }

//   @override
//   Future<CustomParseFile> download({ProgressCallback progressCallback}) async {
//     if (url == null) {
//       return this;
//     }

//     // file = File('${ParseCoreData().fileDirectory}/$name');
//     // await file.create();
//     // final ParseNetworkByteResponse response = await _client.getBytes(
//     //   url,
//     //   onReceiveProgress: progressCallback,
//     // );
//     // await file.writeAsBytes(response.bytes);

//     return this;
//   }

//   /// Uploads a file to Parse Server
//   @override
//   Future<ParseResponse> upload(Uint8List rawdata, {ProgressCallback progressCallback}) async {
//     if (saved) {
//       //Creates a Fake Response to return the correct result
//       final Map<String, String> response = <String, String>{'url': url, 'name': name};
//       return handleResponse<ParseFile>(this, ParseNetworkResponse(data: json.encode(response), statusCode: 201), ParseApiRQ.upload,
//           ParseCoreData().debug, parseClassName);
//     }

//     final Map<String, String> headers = <String, String>{
//       HttpHeaders.contentTypeHeader: 'application/octet-stream',
//     };
//     try {
//       final _path = '$keyEndPointClasses$parseClassName';
//       final String uri = ParseCoreData().serverUrl + '$_path';
//       final ParseNetworkResponse response = await _client.postBytes(
//         uri,
//         options: ParseNetworkOptions(headers: headers),
//         data: file.openRead(),
//         onSendProgress: progressCallback,
//       );
//       if (response.statusCode == 201) {
//         final Map<String, dynamic> map = json.decode(response.data);
//         url = map['url'].toString();
//         name = map['name'].toString();
//       }
//       return handleResponse<ParseFile>(this, response, ParseApiRQ.upload, _debug, parseClassName);
//     } on Exception catch (e) {
//       return handleException(e, ParseApiRQ.upload, _debug, parseClassName);
//     }
//   }
// }
