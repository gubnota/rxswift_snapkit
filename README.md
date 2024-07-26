# UIKit + SnapKit with Xcode SwiftUI previews

[video_preview](https://github.com/user-attachments/assets/771019d8-1037-48e7-9e03-a3fe0d7f01f8)

## Initialization

This project is fully created by `xcodegen` (`brew install xcodegen`):

1. Initialize `project.yml`:

```sh
chmod a+x init.sh
./init.sh tld.your-bundle-id your_project_name
```

2. Run

```sh
xcodegen generate
```

3. Add `RxCocoa` to deps:
   3.1. Targets > rxswift_snapkit
   3.2. Build Phases > Link Binary with Libraries
   3.3. + RxCocoa

- no need to run `swift package resolve`

TODO: Take a look at [xcodegen alternative](https://docs.tuist.io/guides/quick-start/install-tuist)

This project doesn't include storyboards, the only LaunchScreen.storyboard is required to get rid of ugly black padding and to fill up whole screen.
