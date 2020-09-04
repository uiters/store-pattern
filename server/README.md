### Store pattern server ✈

#### Getting start 👍

+ Step 1: Add username and password of MySQL in file `server/docker-compose.yml`

+ Step 2: Run script

```
docker-compose up -d
```

+ Step 3:

* Edit line 1 ```evn.dart``` at ```store-pattern/admin_app/lib/Constants/```
and ```store-pattern/order_app/lib/Constants/```

```dart
const String URL_EXECUTE = "your domain/";
```

* Edit line 17 ```store-pattern/kitchen_app/src/Constants/Constant.java```

```java
public static String urlConnect = "your domain/";
```

⚠ Becareful '/' at the last url