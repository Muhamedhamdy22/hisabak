class EndPoint {
  static const String login    = '/login';
  static const String register = '/register';
  static const String customers = '/customers';
  static String customerTransactions(int id) => '/customers/$id/transactions';
  static String updateCustomer(int id) => '/customers/$id';
  static String deleteCustomer(int id) => '/customers/$id';
  static const String transactions = '/transactions';
  static String deleteTransaction(int id) => '/transactions/$id';
  static const String dashboard = '/dashboard';
}