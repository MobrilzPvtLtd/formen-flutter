import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../core/api.dart';
import '../core/config.dart';

bool internet = true;
  final Api _api = Api();
final ValueNotifier<List<Map<String, dynamic>>> chatListNotifier = ValueNotifier<List<Map<String, dynamic>>>([]);



Future<void> getMessage(String? receiverId, String? senderId) async {
  if (receiverId == null || senderId == null) {
    debugPrint('Receiver ID or Sender ID is null');
    return;
  }

  try {
    final response = await Dio().get('${Config.baseUrlApi}${Config.getChat}$senderId&receiver_id=$receiverId');

    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        if (data.containsKey('messages')) {
          final messages = data['messages'] as List<dynamic>;
          final chatList = messages.map((message) {
            final msg = message as Map<String, dynamic>;
            return {
              'sender_id': msg['sender_id'],
              'message': msg['message']
            };
          }).toList();
          chatListNotifier.value = chatList; // Update the notifier with the new data
        } else {
          debugPrint('Unexpected response format: $data');
        }
      } else {
        debugPrint('Unexpected response data type: ${response.data.runtimeType}');
      }
    } else {
      debugPrint('Failed to load messages: ${response.statusCode} ${response.statusMessage}');
      debugPrint('Response data: ${response.data}');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      debugPrint('DioException - Status Code: ${e.response?.statusCode}');
      debugPrint('DioException - Response Data: ${e.response?.data}');
    } else {
      debugPrint('DioException - Error Message: ${e.message}');
    }
  } on SocketException catch (_) {
    debugPrint('No internet connection');
  } catch (e) {
    debugPrint('Unexpected error: $e');
  }
}

Future<void> sendMessage(String? receiverId, String? senderId,String message) async {
  try {
    // Construct the URL with proper encoding
    final response = await _api.sendRequest.post('${Config.baseUrlApi}${Config.sendChat}$senderId&receiver_id=$receiverId&message=$message');
    // Check if the response status code is 200
    if (response.statusCode == 200) {
      // response.data is already a Map<String, dynamic> if Dio parsed it
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        // Extract and handle messages
        if (data.containsKey('messages')) {
          final messages = data['messages'] as List<dynamic>;
          // Process messages as needed
          List<Map<String, dynamic>> chatList = messages.map((message) {
            // Cast to a map and access required fields
            final msg = message as Map<String, dynamic>;
            return {
              'sender_id': msg['sender_id'],
              'message': msg['message']
            };
          }).toList();
          // Example: Notify listeners or update UI
          debugPrint('Chat List: $chatList');
          // valueNotifierHome.incrementNotifier(); // Uncomment if using ValueNotifier
        } else {
          debugPrint('Unexpected response format: $data');
        }
      } else {
        debugPrint('Unexpected response data type: ${response.data.runtimeType}');
      }
    } else {
      // Handle non-200 status codes
      debugPrint('Failed to load messages: ${response.statusCode} ${response.statusMessage}');
      debugPrint('Response data: ${response.data}');
    }
  } on DioException catch (e) {
    // Handle Dio specific errors
    if (e.response != null) {
      debugPrint('DioException - Status Code: ${e.response?.statusCode}');
      debugPrint('DioException - Response Data: ${e.response?.data}');
    } else {
      debugPrint('DioException - Error Message: ${e.message}');
    }
  } on SocketException catch (_) {
    // Handle network issues
    debugPrint('No internet connection');
    // Set internet connection status
    // internet = false; // Uncomment if you have an internet status variable
  } catch (e) {
    // Handle any other types of errors
    debugPrint('Unexpected error: $e');
  }
}

Future<void> lastAvailable(String? id) async {
  try {
    // Construct the URL with proper encoding
    final response = await _api.sendRequest.post('${Config.baseUrlApi}${Config.lastAvailable}');
    // Check if the response status code is 200
    if (response.statusCode == 200) {
      // response.data is already a Map<String, dynamic> if Dio parsed it
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        // Extract and handle messages
      } else {
        debugPrint('Unexpected response data type: ${response.data.runtimeType}');
      }
    } else {
      // Handle non-200 status codes
      debugPrint('Failed to load messages: ${response.statusCode} ${response.statusMessage}');
      debugPrint('Response data: ${response.data}');
    }
  } on DioException catch (e) {
    // Handle Dio specific errors
    if (e.response != null) {
      debugPrint('DioException - Status Code: ${e.response?.statusCode}');
      debugPrint('DioException - Response Data: ${e.response?.data}');
    } else {
      debugPrint('DioException - Error Message: ${e.message}');
    }
  } on SocketException catch (_) {
    // Handle network issues
    debugPrint('No internet connection');
    // Set internet connection status
    // internet = false; // Uncomment if you have an internet status variable
  } catch (e) {
    // Handle any other types of errors
    debugPrint('Unexpected error: $e');
  }
}

Future<void> getMessageList(String? senderId) async {
  try {
    final response = await Dio().get('${Config.baseUrlApi}${Config.getMessageList}$senderId');

    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        if (data.containsKey('messages')) {
          final messages = data['messages'] as List<dynamic>;
          final chatList = messages.map((message) {
            final msg = message as Map<String, dynamic>;
            return {
              'sender_id': msg['sender_id'],
              'message': msg['message']
            };
          }).toList();
          chatListNotifier.value = chatList; // Update the notifier with the new data
        } else {
          debugPrint('Unexpected response format: $data');
        }
      } else {
        debugPrint('Unexpected response data type: ${response.data.runtimeType}');
      }
    } else {
      debugPrint('Failed to load messages: ${response.statusCode} ${response.statusMessage}');
      debugPrint('Response data: ${response.data}');
    }
  } on DioException catch (e) {
    if (e.response != null) {
      debugPrint('DioException - Status Code: ${e.response?.statusCode}');
      debugPrint('DioException - Response Data: ${e.response?.data}');
    } else {
      debugPrint('DioException - Error Message: ${e.message}');
    }
  } on SocketException catch (_) {
    debugPrint('No internet connection');
  } catch (e) {
    debugPrint('Unexpected error: $e');
  }
}