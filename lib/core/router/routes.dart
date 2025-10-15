class Routes {
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

  static const card = "/payment-method";
  static const newCard = "/new-card";
  static const chat = "/chat";

  static const address = "/address";
  static const addNewAddress = "/add-new-address";

  static const notifications = "/notifications";
  static const notificationSettings = "/notification-settings";
  static const myOrders = "/my-orders";
  static const helpCenter = "/help-center";
  static const myDetail = "/me-detail";
  static const checkout = "/checkout";
  static const faq = "/FAQs";
  static const productDetail = "/product-detail/:id";
  static String productDetailsById({required int id}){
    return '/product-detail/$id';
  }
}
