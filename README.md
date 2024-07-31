# UIKit + SnapKit with Xcode SwiftUI previews

Now UIKit works with iOS 12 version including Xcode previews! The only requirement is no place previews to separate files.

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

3. You can always adjust deps in:
   3.1. Targets > rxswift_snapkit
   3.2. Build Phases > Link Binary with Libraries
   3.3. +

- no need to run `swift package resolve`!

This project doesn't include storyboards or SceneDelegate (in order to work with iOS < 13), the only LaunchScreen.storyboard is required to get rid of ugly black padding and to fill up whole screen.

## TODOs

- [ ] make it possible to configure deps semi-interactively
- [ ] easily build modules then combine into one executable
