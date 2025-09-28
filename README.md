# Feels Golden

**This is a fork of the golden_toolkit package from the abandoned [flutter_glove_box](https://github.com/ebay/flutter_glove_box) repository.**

## About

Feels Golden provides common patterns for screenshot-based widget testing using Goldens. It was originally developed by the eBay Motors App team as part of their flutter_glove_box testing toolkit.

## Original Repository Notice

The original flutter_glove_box repository was discontinued on 09/12/2024 with the following message from the eBay Motors App team:

> Unfortunately we have made the tough decision to no longer actively maintain this repository. While the package has served us and the community well, we don't have the capacity to give it the attention it deserves.

This fork aims to continue maintaining and improving the golden testing toolkit for the Flutter community.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  feels_golden: ^0.16.9
```

## Usage

Feels Golden makes it easy to generate and compare golden files for your Flutter widgets. Here's a simple example:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:feels_golden/feels_golden.dart';

void main() {
  group('Golden tests', () {
    testGoldens('MyWidget golden test', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [
          Device.phone,
          Device.iphone11,
          Device.tabletPortrait,
        ])
        ..addScenario(
          widget: MyWidget(),
          name: 'default',
        );
      
      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'my_widget');
    });
  });
}
```

## Features

- **Multi-device testing**: Test your widgets across multiple device configurations
- **Consistent golden generation**: Ensures consistent font rendering across different platforms
- **Flexible device configurations**: Predefined device configurations or create your own
- **Easy integration**: Works seamlessly with Flutter's existing test framework

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project maintains the same BSD 3-Clause License as the original flutter_glove_box repository.

Copyright 2019-2023 eBay Inc.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above
copyright notice, this list of conditions and the following disclaimer
in the documentation and/or other materials provided with the
distribution.
* Neither the name of eBay Inc. nor the names of its
contributors may be used to endorse or promote products derived from
this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
