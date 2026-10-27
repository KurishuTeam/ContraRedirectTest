# ContraRedirect Test

Regular Xcode project converted from the Swift Playgrounds app package.

## Requirements
- Xcode 16 or newer
- iOS deployment target: 16.0

Open `My App.xcodeproj` in Xcode and run the `My App` scheme.

The GitHub Actions workflow builds the iOS Simulator target with code signing disabled and the deployment target pinned to iOS 16. The workflow uses the Xcode 16.4 image on `macos-15`.
