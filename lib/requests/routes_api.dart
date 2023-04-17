class RoutesAPI {
  static const _baseUrl = 'https://sw-backend-project.vercel.app';
  static const _baseUrl2 = 'https://sw-backend-project.vercel.app';
  static const signUp = _baseUrl + '/auth/sign-up';
  static const login = _baseUrl + '/auth/login';
  static const forgotPassword = _baseUrl + '/auth/forgot-password';
  static const signinGoogle = _baseUrl + '/auth/google';
  static const signinGoogleCallBack = _baseUrl + '/auth/google/callback';
  static const createNewPassword = _baseUrl + '/auth/reset-password';
  static const getUser = _baseUrl + '/user';
  static const getEvents = _baseUrl + '/api/events';
  static const getAllCategories = _baseUrl + '/api/categories';
  static const searchEvents = _baseUrl + '/api/events/search';
  static const getAllTickets = _baseUrl2;
  static const checkPromo = _baseUrl2 + 'promocode/';
  static const placeOrder = _baseUrl2 + 'order/';
}
