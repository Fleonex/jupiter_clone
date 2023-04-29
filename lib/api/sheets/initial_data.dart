import 'package:gsheets/gsheets.dart';
class InitialData{
    static const _credentials = r'''{
  "type": "service_account",
  "project_id": "helical-analyst-385205",
  "private_key_id": "14f616c2a9a9faf52d60877a5f2cb8fa2e221f40",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDL2yqAXIs2UEWs\nXiJ9kak17jOTOoTQICYierfh68wxzHZdvytgpgsSjXTFGAM/2pz1P8nqoriNtDFB\ncLB74xYgixt+Y2Eo9LVUCQLw+t4JMbuLjloRNDw2K+RXqSjvZo9yiKgg4F2fnDCP\ncDH9a5A2KF5kXW0N8YXUEeW2n5pS1lzVMqDFwrgjEwo0b5R7klKfaDd9qEKlFh4/\nOjKAhEfG9cvfcwUOHDBGdotdxb/SosXMBkiOM4rxCozQOehjVvX4rX0nyEYS+rzE\nfRkXAmmpP80mj2MXkK0/SD8qMKQ07nKv/VEMgrPDjDCZpnZaMCNz7CTRUUDiDTH+\nXtC8Hvx9AgMBAAECggEAJxK7iz3xuvfY2uhyIPJV5g3hmdMqGMBIvuwZqbZp/ZOM\njnxxYoWA8s3lN0/ac5dB5WoUGCKXUCXdGQdx9FT67ULsgqWmvlRlGxXdF/Zlr4p2\nQZIH5mtGLTXtfvXf8D8OuKvD2gVXPJwR3LRrCIFg81h6ey9DE1ybQ6Iojv/5cu3m\nXX6SAaCadaL1oJnprV7H9zvE0VnukZ3zFtZYx2wJR+QKesagtlHhQo83jobJ+leP\nQGNCqdChSNnptVslrVTj8HdEdpirxSc0fN3CSelOhUXz+PBsZQBu5feiWSXWeChn\nF06pgxNmbe9Xz1sSXHl7eYnKy4p4ao9FRejr8LrmIQKBgQD/opmMP/E6xzPHR1ln\noxiUZ+QQhfo8sRqXPrfdcaNZRtcgXal69dp4kHAwX89XoCSJVufhFJtaa9Jo/iNz\nMiH+/OxST9Wh86Z3bJELE+nTJ2Tg8elxY2xgTlFpoQel7brT+OUbUjoDkhsx73uL\nM6RIe6MvNZUUHSYANfgQLaDVEQKBgQDMJaXg7WqcbEJSadm7wLF5iXAeLm9eDbtg\nwOpbtOVMiLaniWL/whl56SXZlgI3jFOCFf8CGC7/XWdJhyJO0+rT9roLzDynHy1F\neXZMKBfv6VgPNcVvKa93MMMlCqOTMWNDQcNnPt23BhFZA6MX6ejb+m37itCBKTfx\nPykJA38ArQKBgQD+ZQ7PDnb+mmyBvRRQ2XLFhVnlw56SNWET8FtDaSo41xGQ6QSX\nFAD1CDBNQ5twRTL25eBeEobDhhdfWsFmixZfzc1T4JTl1TXtFMKGtqtz8XknjjZV\nG68na+kC6DhXPOw2tDMzbDHFiem8WOmmTp8HbtqnSXhxCszdWtfhKbcrMQKBgQDI\nvUBmc66Aj+eLWHB0sZ8SLnYkB28VIhWdpzUL5k4POuO4zFyft4ILoZnJYjtd2cuH\nwA9YROV5z6Ov5oRy1Ok1cogw76y4fOysQypy6n3XODGSC0LP80KJxlYth0+fflHo\nIbN+Q5AK15mZWP03l5eVL6SUU0SBrUFIJN458ckhpQKBgCn98zJAQCJWZXYHUb1Y\nLfE2yy6nybPn8sMvnxDrSdKa7zgHsCwXotG+Kzf2B0mX3hiL+glC0pLoAoTwqbKC\nG6L4vdKWHW3YV6T3ofEuBB63vJpnyZJd0YgiI+F+VKVGIljsUza2BUTTtrxim6LZ\nAZNoUKbj4FhCTbER3Rn6u8HP\n-----END PRIVATE KEY-----\n",
  "client_email": "googlesheets@helical-analyst-385205.iam.gserviceaccount.com",
  "client_id": "106740072547733420158",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/googlesheets%40helical-analyst-385205.iam.gserviceaccount.com"
}''';

    static final _spreadsheetId = '1L5rlnCC3c3lf1MnqyFuYkQRT2gVfmEB2GYtPZfG_uG8';
    static final _gsheets = GSheets(_credentials);
    static Worksheet? _userSheet;
    static Future init() async {
        final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
        _userSheet = await _getWorkSheet(spreadsheet, title : 'Jupiter');
    }

    static Future<Worksheet> _getWorkSheet(
        Spreadsheet spreadsheet, {
            required String title,
        }
    ) async {
        try{

            return await spreadsheet.addWorksheet(title);
        } catch(e){
            return spreadsheet.worksheetByTitle(title)!;
        }
    }
}