<h1 align="center" id="home">
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors)
  <a href="https://github.com/cuongw/store-pattern">
    <img alt="store-pattern" src="https://user-images.githubusercontent.com/34389409/50757659-a7211880-1292-11e9-9e41-6621e988fff8.png" width="400">
  </a>
  <br>Store Pattern<br>
</h1>

<h4 align="center">
  👑 The prototype for management applications.
</h4>

<p align="center">
  <a href="https://travis-ci.org/cuongw/store-pattern">
    <img src="https://travis-ci.org/cuongw/store-pattern.svg?branch=master"/>
  </a>
  
   <a href="#">
    <img src="https://img.shields.io/badge/platform-android-lightgreen.svg"/>
  </a>
  
   <a href="#">
    <img src="https://img.shields.io/badge/platform-ios-lightgreen.svg"/>
  </a>
  
  <a href="#">
    <img src="https://img.shields.io/badge/platform-fuchsia-lightgreen.svg"/>
  </a>
  
  <a href="https://github.com/cuongw/store-pattern/blob/master/LICENSE">
    <img src="https://img.shields.io/github/license/jade28/store-pattern.svg"/>
  </a>
  
  <a href="https://github.com/cuongw/store-pattern/blob/master/LICENSE">
    <img src="https://img.shields.io/badge/contributions-welcome-orange.svg"/>
  </a>
</p>  

<div align="center">
  <h4>
    <a href="#features">Features</a> |
    <a href="#structure">Structure</a> |
    <a href="#install">Install</a> |
    <a href="#usage">Usage</a> |
    <a href="#documents">Documents</a> |
    <a href="#technologies">Technologies</a> |
    <a href="#some-screens">Some Screens</a> |
    <a href="#bugs-and-issues">Bugs and Issues</a> |
    <a href="#team">Team</a> |
    <a href="#license">License</a>
  </h4>
</div>

## Features

* Ordering foods by table.
* Checkout, preview & print invoice.
* Profile feature.
* Manage food & category.
* Manage table.
* Manage account.
* Sales report.

## Structure

<p align="center">
<img src="https://user-images.githubusercontent.com/34389409/51081838-39f70280-172c-11e9-9475-21eba19e7fe2.png" width="500"/>
</p>

## Install

Clone this project:
```sh
~$ git clone https://github.com/cuongw/store-pattern.git
```
cd `store-pattern`:
```sh
~$ cd store-pattern
```
Install packages for `flutter` apps:
```sh
~$ flutter packages get
```
Setup API:

* Upload file: ```index.php``` at ```store-pattern/server/Normal``` to your host.
* Edit ```index.php```
  ```php
  $servername = "Your servername";
  $username = "your username";
  $password = "your password";
  $dbname = "database name";
  ```
* Edit line 1 ```evn.dart``` at ```store-pattern/admin_app/lib/Constants/```
and ```store-pattern/order_app/lib/Constants/```

    ```dart
    const String URL_EXECUTE = "your domain/index.php";
    ```

* Edit line 17 ```store-pattern/kitchen_app/src/Constants/Constant.java```

    ```java
    public static String urlConnect = "your domain/index.php";
    ```
* Run script sql in your PhpMyAdmin ```store-pattern/database/script/mysql.sql```

Run:

* Requrie install ```ant```

	```sh
  ~$ sudo apt install ant
  ```

* Run admin_app:

	```sh
	~$ cd admin_app
	~$ flutter run
	```

* Run kitchen_app

	```sh
	~$ cd kitchen_app
	~$ ant run
	```

* Run order_app
	```sh
	~$ cd order_app
	~$ flutter run
	```
  
## Usage

Using this account for testing:</br>
**`username`**: `test`</br>
**`password`**: `test`</br>

Using this account admin for testing:</br>
**`username`**: `tvc12`</br>
**`password`**: `tvc12`</br>

Enjoy 👍

## Documents

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

## Technologies

* [Flutter](https://flutter.io/)
* [Java](https://www.java.com/en/download/)
* [PHP](http://php.net/)
* [MySQL](https://www.mysql.com/)

## Some Screens

### `Order App`

<div style="text-align: center"><table><tr>
  <td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/order_app">
    <img src="https://user-images.githubusercontent.com/34389409/51075123-f8c60a80-16b9-11e9-9048-69f69a70cf1b.png" width="200"/></a>
</td>
<td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/order_app">
<img src="https://user-images.githubusercontent.com/34389409/51075120-f82d7400-16b9-11e9-85f0-61d491306451.png" width="200"/>
  </a>
</td>
<td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/order_app">
<img src="https://user-images.githubusercontent.com/34389409/51075119-f794dd80-16b9-11e9-9071-fdac81083b00.png" width="200" />
  </a>
</td>
<td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/order_app">
<img src="https://user-images.githubusercontent.com/34389409/51075121-f82d7400-16b9-11e9-8f82-d91cb7a2f588.png" width="200"/>
  </a>
</td>
</tr></table></div>

<div style="text-align: center"><table><tr>
<td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/order_app">
<img src="https://user-images.githubusercontent.com/34389409/51075168-a0433d00-16ba-11e9-9731-28030cfcab55.png" width="200"/>
  </a>
</td>
<td style="text-align: center">
<a href="https://github.com/cuongw/store-pattern/tree/master/order_app">
  <img src="https://user-images.githubusercontent.com/34389409/51075124-f8c60a80-16b9-11e9-8eac-6a26eb22be5a.png" width="200"/></a>
</td>
<td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/order_app">
<img src="https://user-images.githubusercontent.com/34389409/51075122-f82d7400-16b9-11e9-83c6-5d105a733f07.png" width="200" />
  </a>
</td>
<td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/order_app">
<img src="https://user-images.githubusercontent.com/34389409/51075124-f8c60a80-16b9-11e9-8eac-6a26eb22be5a.png" width="200"/>
  </a>
</td>

</tr></table></div>

### `Admin App`

<div style="text-align: center"><table><tr>
  <td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/admin_app">
    <img src="https://user-images.githubusercontent.com/34389409/51075202-2790b080-16bb-11e9-9e2b-faac61d0ef6c.png" width="200"/></a>
</td>
<td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/admin_app">
<img src="https://user-images.githubusercontent.com/34389409/51075203-2eb7be80-16bb-11e9-97d4-b5700089cef8.png" width="200"/>
  </a>
</td>
<td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/admin_app">
<img src="https://user-images.githubusercontent.com/34389409/51075207-32e3dc00-16bb-11e9-945f-6142c921fd48.png" width="200" />
  </a>
</td>
<td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/admin_app">
<img src="https://user-images.githubusercontent.com/34389409/51075209-38412680-16bb-11e9-8599-8a4568b7c416.png" width="200"/>
  </a>
</td>
</tr></table></div>

<div style="text-align: center"><table><tr>
<td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/admin_app">
<img src="https://user-images.githubusercontent.com/34389409/51075216-40996180-16bb-11e9-8bac-8ab7bea862b9.png" width="200"/>
  </a>
</td>
<td style="text-align: center">
<a href="https://github.com/cuongw/store-pattern/tree/master/admin_app">
  <img src="https://user-images.githubusercontent.com/34389409/51075220-45f6ac00-16bb-11e9-8c1b-0a90a3d8b994.png" width="200"/></a>
</td>
<td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/admin_app">
<img src="https://user-images.githubusercontent.com/34389409/51075223-4bec8d00-16bb-11e9-826a-82ddeeec328d.png" width="200" />
  </a>
</td>
<td style="text-align: center">
  <a href="https://github.com/cuongw/store-pattern/tree/master/admin_app">
<img src="https://user-images.githubusercontent.com/34389409/51075226-5018aa80-16bb-11e9-90d8-9dbf0ec52503.png" width="200"/>
  </a>
</td>

</tr></table></div>

### `Kitchen App`

 <a href="https://github.com/cuongw/store-pattern/tree/master/kitchen_app">
<img src="https://user-images.githubusercontent.com/34389409/51789162-b5d75d00-21b8-11e9-9e3f-b419ff3daf2f.png" width="900"/>
  </a>

## Bugs and Issues

Have a bug or an issue with this project? [Open a new issue](https://github.com/cuongw/store-pattern/issues) here on GitHub.

## Team

| [![Cuong Duy Nguyen](https://github.com/cuongw.png?size=120)](https://github.com/cuongw) | [![Thien Chi Vi](https://github.com/tvc12.png?size=120)](https://github.com/tvc12) | [![Thang Huu Le](https://github.com/lhthang1998.png?size=120)](https://github.com/lhthang1998) |
| :---: | :---: | :---: |
| [Cuong Duy Nguyen](https://github.com/cuongw) | [Thien Chi Vi](https://github.com/tvc12) | [Thang Huu Le](https://github.com/lhthang1998) |

**[⬆ back to top](#home)**

## License

MIT © [cuongw](https://github.com/cuongw) 🐢

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table><tr><td align="center"><a href="http://cuongw.me"><img src="https://avatars0.githubusercontent.com/u/34389409?v=4" width="100px;" alt="Cuong Duy Nguyen"/><br /><sub><b>Cuong Duy Nguyen</b></sub></a><br /><a href="https://github.com/cuongw/store-pattern/commits?author=cuongw" title="Code">💻</a> <a href="#ideas-cuongw" title="Ideas, Planning, & Feedback">🤔</a></td></tr></table>

<!-- ALL-CONTRIBUTORS-LIST:END -->
Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!