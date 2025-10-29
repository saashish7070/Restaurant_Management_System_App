import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class CloudinaryService {
  static const _cloudName = 'YOUR_CLOUD_NAME';
  static const _uploadPreset = 'YOUR_UPLOAD_PRESET';

  static Future<String?> uploadImage(File imageFile) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = _uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = json.decode(responseData);
      return data['secure_url'];
    } else {
      print('Upload failed: ${response.reasonPhrase}');
      return null;
    }
  }
}
