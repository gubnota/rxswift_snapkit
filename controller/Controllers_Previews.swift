//
//  Controllers_Previews.swift
//
//  Created by Vladislav Muravyev on 31.07.2024.
//
#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct EntryViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: EntryViewController()).toPreview { vc in
            if let vc = vc as? EntryViewController {
                vc.configureForPreview()
            }
        }
    }
}

@available(iOS 13.0, *)
struct LoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        LoginViewController().toPreview()
    }
}

@available(iOS 13.0, *)
struct ProfileViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ProfileViewController(username: "admin", password: "admin").toPreview()
    }
}

@available(iOS 13.0, *)
struct ScrollViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ScrollViewController().toPreview()
    }
}

@available(iOS 13.0, *)
struct SetNotificationViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SetNotificationViewController().toPreview()
    }
}

#endif

