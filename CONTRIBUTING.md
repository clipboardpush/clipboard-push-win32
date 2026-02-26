# Contributing to Clipboard Push — Windows Client

Thank you for your interest in contributing!

## Getting Started

1. Fork the repository and clone your fork.
2. Follow the **Build from Source** instructions in [README.md](README.md) to set up your build environment.
3. Create a new branch for your change: `git checkout -b my-feature`

## Code Style

- **C++17**, Win32 API, no STL exceptions in release paths.
- Keep the zero-dependency constraint: do not add new vcpkg dependencies without discussion.
- Use the existing `LOG_INFO` / `LOG_ERROR` macros for logging. Never use raw `printf` for user-visible messages.
- All user-visible strings must be in English (the project does not currently have an i18n layer for the Win32 client).
- Static linking is non-negotiable — always build with `x64-windows-static` triplet and `/MT` CRT.

## Submitting Changes

1. Make sure the project compiles cleanly in both `Debug` and `Release`.
2. Test manually on Windows 10 and/or Windows 11 if possible.
3. Open a Pull Request with a clear description of what you changed and why.

## Reporting Issues

Please open a GitHub Issue with:
- Windows version
- Steps to reproduce
- Expected vs. actual behavior
- Any relevant log output (visible in a debugger via `OutputDebugString`)

## Security Issues

For security vulnerabilities, please **do not** open a public issue. Contact the maintainers privately first.
