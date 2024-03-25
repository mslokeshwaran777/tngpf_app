import 'dart:convert';

class Signin {
  String id;
  String apiVersion;
  GpfStatus? gpfStatus;
  Error? error;
  bool success;

  Signin({
    required this.id,
    required this.apiVersion,
    this.gpfStatus,
    this.error,
    required this.success,
  });

  factory Signin.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("GPF_Status")) {
      return Signin(
        id: json["\$id"],
        apiVersion: json["apiVersion"],
        gpfStatus: GpfStatus.fromJson(json["GPF_Status"]),
        success: true,
      );
    } else if (json.containsKey("error")) {
      return Signin(
        id: json["\$id"],
        apiVersion: json["apiVersion"],
        error: Error.fromJson(json["error"]),
        success: false,
      );
    } else {
      throw FormatException("Invalid JSON structure"); // Handle unexpected case
    }
  }

  Map<String, dynamic> toJson() => {
    "\$id": id,
    "apiVersion": apiVersion,
    if (gpfStatus != null) "GPF_Status": gpfStatus!.toJson(),
    "success": success,
  };
}

class GpfStatus {
  String id;
  int code;
  String message;

  GpfStatus({
    required this.id,
    required this.code,
    required this.message,
  });

  factory GpfStatus.fromJson(Map<String, dynamic> json) => GpfStatus(
    id: json["\u0024id"],
    code: json["code"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "\u0024id": id,
    "code": code,
    "Message": message,
  };
}

class Error {
  String id;
  int code;
  String message;

  Error({
    required this.id,
    required this.code,
    required this.message,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    id: json["\u0024id"] ?? "",
    code: json["code"] ?? 0,
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "\u0024id": id,
    "code": code,
    "message": message,
  };
}
