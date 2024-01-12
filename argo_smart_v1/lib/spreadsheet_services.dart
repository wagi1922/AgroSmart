import 'package:gsheets/gsheets.dart';

class SpreadsheetService {
  static const _spreadsheetId = '1L2XX068YA6Uia-zw-123Ie0LbAfClNcQRyTHWcs9d8Y';
  static const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "evident-wind-410806",
    "private_key_id": "dc5f51fcdb1b446075bdf7822a7219b4c623ce5d",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCvfdlzaKrMCpT3\nWGqv9yo08Y6U+NrXvJZepNp1+ZYDCTVulyeyOzEMH6sapflSA1BSm1TzL9z19d2a\ntB5U7HImgCcIJrqGznAd9YjfGh7GJW0laCLpqK88gJCkegEd0pOXevW78kZ7QMce\ngzzBX0eg7R+IYdqMx9nlyNLhk+VEGL5jTZrL2iv/6wbTiu/xzZsd//cAHxftYQig\neYGUrqcu+yAh5Bl4aCu0FFX/+DqOassI4ZuPyLlXwgHGxhWko9DlO4SLlIfkwqM3\nj/MuN8rgFR8dDf6IMFEpa74oGLi3vh9alW1B0XgsiUShgM4sqm+/aOXN7I/LXtfX\n1jNmKD9pAgMBAAECggEACsXH7myzZ1kS8egMjIa4oY1eekiYbnvWIzMtceaDTeZn\n0EUZG7jEdwEOqNEdb+piKN/+I/uBLdwM4W1DG2V0UGa3fqmZ86KCgWRMJZ3d2736\naDxvQDapoyYlOuN+ZA1EIB1dLk9eAjzkvDvEI/6sT/WeZOnU16WA+7kLMOu6PCbK\nmYPfJM5ieAMRg6guFjPYCMKC5wY74OZYXX2OPueEWOHJzCOO+FW5QFSuh2NSQu6o\nFikO9Rc+xkIANLf3kg1Ig4MDpgsov3lgy/I9e0UVkN9IDCT3Otw1jMkpaFIbl2hx\npROs07VhlpVyk8tC6dR3Di/rlZxN18uTEtpAbsIdMQKBgQDkDqH/o09txcTeV/rs\n4CoQWsZdTNHQZ7NAkrsJC4mD1xGDK47C/Ri5heSlwcKu5HKUsBfjY7ScSz0akhJo\nhdaCSgOJIyRpuGccpLcKRfLDEy9Cdl3V0AHEIjDbAI4qrzb+2/E1Opr8CeyLyP5q\n/UOvij2gkSRJBeZUofzJIbJxFQKBgQDE/mqHtPLlBMocF2wC6tOSGxGo3/be1eg+\njQRr6Cp3ohnui7k8hpfTBy7Odvr1+vsjZUBDI7rHnrN0LFrTG9ILKs6oTFLsTrZA\nLHUq/Z1ddGR/t95VZtRa8tJjSGhC+dN8B/GKWKa3ccVPc8lr9fq1GAayBJm7Jt41\nS4ceOVpiBQKBgH35/07hfXzb5HYWD4xN/65tFmpvhu8ieYhQBXVnpBzp7siQhRn9\nCW1iIv3VXJ+Tnh+4blmzuA8mGKjWy8hlNiteizlz6idkL8FI07ufDAzqSg7ip872\nSiN355jyY5X8l9qM0F9g8kALk1lcO/4JzRvot0Y9JtgXpDZYDPVl4dZJAoGAGlTH\neIw/S01wloCq91jcHtNvcNs+7Fo7SOEgjiviQUtxm+khQW3cLWDwaLiOowKBPyHx\njQfhl30nD4g+O6mkUcnPBb/t9Zgv1DQdFToBJtS/+jJhjZjJGb8LUCoFha5PDm0h\nZBSldC/I5+3aJowijsI/YtwqkFGJsiX+UZPo+OECgYEAiyhgwL979fsTw6a/OVc7\nKVywfcu0XrEatK4X26jnYY+Ya5Pb5TQ68BradVuYMbBRn2PLM55Uf0ztya5EpuFf\n3A2RUVietJw9F+fkRJ6iy2iAopTJ9bxLMVgwaRuOt5+MvPcru/qYZorR8AVCOvF7\n/tV6E69Ig1d4Y+xPGmnS7Dg=\n-----END PRIVATE KEY-----\n",
    "client_email": "flutter-google-sheets@evident-wind-410806.iam.gserviceaccount.com",
    "client_id": "110282848375286388211",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-google-sheets%40evident-wind-410806.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }''';

  static Future<List<String>> getNewestData() async {
    final gsheets = GSheets(_credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);

    // Assuming 'Sensor Datalog' is the first sheet, you can change the index accordingly
    final sensorSheet = spreadsheet.sheets[0];

    // Assuming you want to fetch the last row of data from columns D, E, and F
    final dataFromD = (await sensorSheet.values.column(4)).toList();
    final dataFromE = (await sensorSheet.values.column(5)).toList();
    final dataFromF = (await sensorSheet.values.column(6)).toList();

    // Get the last values from each column
    final latestDataFromD =
        dataFromD.isNotEmpty ? dataFromD.last.toString() : null;
    final latestDataFromE =
        dataFromE.isNotEmpty ? dataFromE.last.toString() : null;
    final latestDataFromF =
        dataFromF.isNotEmpty ? dataFromF.last.toString() : null;

    return [
      latestDataFromD ?? '',
      latestDataFromE ?? '',
      latestDataFromF ?? ''
    ];
  }
}
