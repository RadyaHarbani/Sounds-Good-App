class ApiEndpoints {
  static String baseUrl =
      'https://raion-battlepass-2026-production.up.railway.app';

  //POST Requests
  static String loginUser = '$baseUrl/auth/login';
  static String signUpUser = '$baseUrl/auth/signup';
  static String uploadSong = '$baseUrl/songs/upload';

  //GET Requests
  static String currentUserData = '$baseUrl/auth/';
  static String getAllSongs = '$baseUrl/songs/getall';
  static String getUserSongs = '$baseUrl/songs/me';

  //PUT Requests
  static String updateSong = '$baseUrl/songs/update';

  //DELETE Requests
  static String deleteSong = '$baseUrl/songs/delete';
}
