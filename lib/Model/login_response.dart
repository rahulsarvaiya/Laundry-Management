class LoginResponse {
  String? jsonrpc;
  dynamic id;
  Result? result;

  LoginResponse({this.jsonrpc, this.id, this.result});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jsonrpc'] = jsonrpc;
    data['id'] = id;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  bool? status;
  String? message;
  LoginResult? result;

  Result({this.status, this.message, this.result});

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ? LoginResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class LoginResult {
  UserData? userData;
  UserSettings? userSettings;
  Currencies? currencies;
  String? message;

  LoginResult({this.userData, this.userSettings, this.currencies,this.message});

  LoginResult.fromJson(Map<String, dynamic> json) {
    userData = json['user_data'] != null
        ? UserData.fromJson(json['user_data'])
        : null;
    userSettings = json['user_settings'] != null
        ? UserSettings.fromJson(json['user_settings'])
        : null;
    currencies = json['currencies'] != null
        ? Currencies.fromJson(json['currencies'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    if (userSettings != null) {
      data['user_settings'] = userSettings!.toJson();
    }
    if (currencies != null) {
      data['currencies'] = currencies!.toJson();
    }
    data['message'] =message;
    return data;
  }
}

class UserData {
  int? userId;
  String? name;
  String? username;
  String? partnerDisplayName;
  int? partnerId;
  String? webBaseUrl;
  int? activeIdsLimit;
  dynamic profileSession;
  dynamic profileCollectors;
  dynamic profileParams;
  int? maxFileUploadSize;
  bool? homeActionId;

  UserData(
      {this.userId,
        this.name,
        this.username,
        this.partnerDisplayName,
        this.partnerId,
        this.webBaseUrl,
        this.activeIdsLimit,
        this.profileSession,
        this.profileCollectors,
        this.profileParams,
        this.maxFileUploadSize,
        this.homeActionId});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    username = json['username'];
    partnerDisplayName = json['partner_display_name'];
    partnerId = json['partner_id'];
    webBaseUrl = json['web.base.url'];
    activeIdsLimit = json['active_ids_limit'];
    profileSession = json['profile_session'];
    profileCollectors = json['profile_collectors'];
    profileParams = json['profile_params'];
    maxFileUploadSize = json['max_file_upload_size'];
    homeActionId = json['home_action_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['username'] = username;
    data['partner_display_name'] = partnerDisplayName;
    data['partner_id'] = partnerId;
    data['web.base.url'] = webBaseUrl;
    data['active_ids_limit'] = activeIdsLimit;
    data['profile_session'] = profileSession;
    data['profile_collectors'] = profileCollectors;
    data['profile_params'] = profileParams;
    data['max_file_upload_size'] = maxFileUploadSize;
    data['home_action_id'] = homeActionId;
    return data;
  }
}

class UserSettings {
  int? id;
  int? userId;
  bool? isDiscussSidebarCategoryChannelOpen;
  bool? isDiscussSidebarCategoryChatOpen;
  bool? pushToTalkKey;
  int? voiceActiveDuration;

  UserSettings(
      {this.id,
        this.userId,
        this.isDiscussSidebarCategoryChannelOpen,
        this.isDiscussSidebarCategoryChatOpen,
        this.pushToTalkKey,
        this.voiceActiveDuration});

  UserSettings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    isDiscussSidebarCategoryChannelOpen =
    json['is_discuss_sidebar_category_channel_open'];
    isDiscussSidebarCategoryChatOpen =
    json['is_discuss_sidebar_category_chat_open'];
    pushToTalkKey = json['push_to_talk_key'];
    voiceActiveDuration = json['voice_active_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['is_discuss_sidebar_category_channel_open'] =
        isDiscussSidebarCategoryChannelOpen;
    data['is_discuss_sidebar_category_chat_open'] =
        isDiscussSidebarCategoryChatOpen;
    data['push_to_talk_key'] = pushToTalkKey;
    data['voice_active_duration'] = voiceActiveDuration;
    return data;
  }
}

class Currencies {
  String? symbol;
  String? position;

  Currencies({this.symbol, this.position});

  Currencies.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['position'] = position;
    return data;
  }
}
