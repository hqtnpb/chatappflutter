import 'package:googleapis_auth/auth_io.dart';

class AccessTokenFirebase {
  static String firebaseMessagingScope =
      'https://www.googleapis.com/auth/firebase.messaging';

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "chatappbtl-e2c94",
          "private_key_id": "d34ecdd649f15fba5834fb1a8b628d3f268d782e",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZ+zy5pA4BELU5\nwBc5xQNlZaDHGLL1Va7DgCbGwan86wWaVmDZiyY1EuT2YzQKW+Gm+2uLZ+B1pGCQ\nauAfcA6TGB4Z9VBqxS6dJRXtWpmXTAqa1LLLWSYcaOx//2cUeB+Ztf9y0NCerfc6\nCXLy7DjozUe3o2FSvi74TjPwSlWqbRMQu9YWBK/shgizaH3TtSkZ3kb8dOjGKyGV\nTQuiy1amU+k8OJe6lmfLmJ3K2zebFWqNTqvEV1PpXUJ6nV5BjtiRA7M+Bpqo9/5d\n8fpJIfVfSOfYatKQhVeJUxdesL20feXAVWmWZgiqahHRp5C3YVU854NDU6W+Xg2q\nc96yOQfXAgMBAAECggEABqujBJVKHms5+H3x2AE45OHyxRTy6QIJuo7R4PQtNQGm\nJr5s8UtKTIZ6/jUz8vsz0Q3RkS8JFeCFWfYDTML7lzG+PhIdN184WXO4k45Zs+EO\nVAWdQQ7F1Um6rwIMT/qLEQOaQRO1xp1ROvPuEhP7e9hIUQzNXiBWxJ90BG7p5zCn\n1ZrOJenHkVbP+gfSKxN79gdAKVgjh7DNQ4JnHru/rQS1iZ3Jw4ao3lDOmD7XZ36J\nPMT56sqZNBNA2XWC55T41EO0X46XROzc2iqfWpv4F06/rqqr+PGSQT8nGqty0hkv\nCFr1FzqwlNcD1gsISJ1qEADWgP1H34mc3WqplQBNyQKBgQDyz8fNqwnreg9JnMem\nptvxI2nbs0n0kQ9CeMMPuuuiCSNX8/ALFXdzkDVCa5WZ2rhVy+n3kXzo++D0i0tG\nIX/04SGk9p8Whf+KN2PDQom7VPjKZylfhS3JJsO2Z8JYTJ47jIMr3Vc37EIYDqQh\nR8Piw2r3szSuJMI/rBAsctXYqQKBgQDl0jMv1WJbYHsL01G8ktIQxdt4rUUjVOo4\nzxlA4fR1xtFl52uKXvzSR8++CcFaT1aKmarSvIVGx+YB5I1XPFkg7akrqyqmWC7s\npcLNv+ZSg3jmb74Usm3OO5M6LpRXS2hL3Wd4OeI56/hGugfs1RIYfhg2UMVPs3WW\nFGfH/amsfwKBgQDx5YI+KSlmyGE2itRz+EOhhhBN6d3Boko7hKd/ok5hTQ1C8Ciy\nQh6QqJgGpbuSXU3LW6ypEO4KBfTka2kAYxtg0HB+MZvoCnK8NdZTjpQ8Zri8m+2h\n1cH5ZX8Q12nMIfh5htCfAJGFiv+FjACDj0VdQiXsw0G2Q7SpTjeGsJjOkQKBgFJf\njx07/G8IG9JXQdq3PTfp0wpkAH3zd6g5ArIwyvBT/MXrtq338eJk/t78nCMEgN5Y\nydOS4qpGB/jxtH9qEAAvbw1J4pWQ0fDcUQByIdm9ad4eeyDr+1OKIvEdtOm9C3r1\ntppvFNjx7SFcmG6YyE2jFIaTWMWCa0kJs1EJaIF9AoGAUdIcdbtTAe3BH9MtPJjD\nfrKtmJS1GEuanfHVrZoEwEKPWgt0N/yjS1TLVxhxi2HQEQKrL6iXEqS3zoqCDwYv\n69kK7AP1uu+c//5r1Xy8f5VnilfLmjQunhHulAcwwZq5xmTrA3peQ3X89zXfcqgJ\nSkRFFto35VThxEhzOgkTYyI=\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-mux0j@chatappbtl-e2c94.iam.gserviceaccount.com",
          "client_id": "117975964188530261116",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-mux0j%40chatappbtl-e2c94.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        [firebaseMessagingScope]);

    final accessToken = client.credentials.accessToken.data;

    return accessToken;
  }
}
