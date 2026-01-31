class ConstantApi {
  static const String BASE_URL = 'https://waysa.rplrus.com';
  static const String API_PREFIX = '/api';
  static const String FULL_URL = '$BASE_URL$API_PREFIX';

  static const String API_VERSION = '/v1';

  // AUTH
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String LOGOUT = '/logout';

  // PLANT
  static const String API_GROUP_PLANT = '/plant';
  static const String ANALYZE = '/analyze';

  // ARTICLE
  static const String ARTICLE_LIST = '/articles';
  static const String PROFILE='/profile';
  static const String PRODUCT='/products';
  static const String MYPRODUCT='/my-products/';
  static const String JOURNALS='/journals';
}
