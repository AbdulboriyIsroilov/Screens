class Routers {
  static const splash = "/splash";
  static const onboarding = "/onboarding";

  static const signUp = "/sign-up";
  static const login = "/login";

  static const forgotPassword = "/forget-password";
  static const enterDigitCode = "/enter-digit-code";
  static const resetPassword = "/reset-password";

  static const home = "/home";
  static const search = "/search";
  static const saved = "/saved";
  static const cart = "/card";
  static const account = "/account";

  static const notifications = "/notifications";
  static const productDetail = "/product-detail/:id";
  static String productDetailsById({required int id}){
    return '/product-detail/$id';
  }
}
