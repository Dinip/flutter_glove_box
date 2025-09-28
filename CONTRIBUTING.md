# Feels Golden Contributing Guidelines

Thank you for your interest in contributing to Feels Golden! This project is a fork of the golden_toolkit package from the abandoned [flutter_glove_box](https://github.com/ebay/flutter_glove_box) repository.

## About This Fork

This repository continues the development of golden_toolkit as **Feels Golden** after the original flutter_glove_box repository was discontinued in December 2024. We aim to maintain and improve this valuable testing tool for the Flutter community.

## Contributing Process

1. **Fork the repository** and create a feature branch
2. **Make your changes** following the guidelines below
3. **Run tests** to ensure everything works correctly
4. **Submit a pull request** with a clear description of your changes

## General Guidelines

- Only one logical change per commit
- Do not mix whitespace changes with functional code changes
- Do not mix unrelated functional changes
- Any significant changes should be accompanied by tests
- Look at existing tests for guidance on testing patterns
- Please squash all commits for a change into a single commit

## Commit Message Guidelines

- Provide a brief description of the change in the first line (limit to 50 characters)
- Insert a single blank line after the first line
- Provide a detailed description in the following lines, wrapping at 72 characters
- The first line should not end in a period
- Put `Closes #XXX` at the end if fixing a tracked issue

Example:
```
Add support for custom device configurations

This change allows users to define their own device configurations
beyond the predefined ones, enabling more flexible testing scenarios
for apps with specific device requirements.

Closes #123
```

## Code Quality

- Follow Dart/Flutter style guidelines
- Ensure code is properly formatted (`dart format`)
- Run static analysis (`dart analyze`) and fix any issues
- Add appropriate documentation for public APIs
- Include tests for new functionality

## Testing

- Run existing tests: `flutter test`
- Add tests for new features or bug fixes
- Ensure golden tests pass consistently across platforms
- Test on multiple Flutter versions when possible

## Documentation

- Update README.md if adding new features
- Add dartdoc comments for new public APIs
- Include code examples in documentation when helpful
- Update CHANGELOG.md following semantic versioning

## Questions?

If you have questions about contributing, please open an issue for discussion before starting work on larger changes.

Thank you for helping to maintain this valuable testing tool for the Flutter community!
