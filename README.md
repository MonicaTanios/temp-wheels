# temp-wheels

## Coding Guidelines

<!-- TOC depthFrom:3 -->

- [1. Naming Conventions](#1-naming-conventions)
- [2. Imports Ordering](#2-imports-ordering)
- [3. Programming Practices](#3-programming-practices)
    - [3.1. Never Use `new` Keyword](#31-never-use-new-keyword)
    - [3.2. Always Use Relative Imports](#32-always-use-relative-imports)
- [4. Formatting](#4-formatting)
    - [4.1. Always Use Trailing Commas](#41-always-use-trailing-commas)

<!-- /TOC -->

### 1. Naming Conventions

| Item                       | Case & Naming              |
| :------------------------- | :------------------------- |
| Files & Packages           | lowercase_with_underscores |
| Import Prefixes            | lowercase_with_underscores |
| Classes & Enums            | UpperCamelCase             |
| Typedefs & Type Parameters | UpperCamelCase             |
| Other Identifiers          | lowerCamelCase             |
| Constants                  | SCREAMING_CAPS             |

### 2. Imports Ordering

Order your imports in the following order, separated with a **blank line** and sorted **alphabetically** within each section:

1. `dart:` imports.
1. `package:` imports.
1. Relative imports.

```dart
import 'dart:async';
import 'dart:html';

import 'package:bar/bar.dart';
import 'package:foo/foo.dart';

import 'util.dart';
```

### 3. Programming Practices

#### 3.1. Never Use `new` Keyword

The `new` keyword is optional in dart, so just don't use it.

```dart
var x = new Foo();   // bad
var y = Foo();       // good
```

#### 3.2. Always Use Relative Imports

```dart
import 'package:tazkrtak/util/foo.dart';   // bad
import '../util/foo.dart';                 // good
```

### 4. Formatting

#### 4.1. Always Use Trailing Commas

Using [trailing commas](https://flutter.dev/docs/development/tools/formatting#using-trailing-commas) helps the automatic formatter to insert an appropriate amount of line breaks for Flutter-style code.

```dart
// bad
ButtonTheme(height: 56, child: Text('foo', style: TextStyle(fontSize: 20)));
                                                                        ^^^
// good
ButtonTheme(
  height: 56,
  child: Text(
    'foo',
    style: TextStyle(
      fontSize: 20,
    ),            ^
  ), ^
); ^
```
