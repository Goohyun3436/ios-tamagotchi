//
//  UIViewController+Extension.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/23/25.
//

import UIKit

extension UIViewController {
    
    func presentVC(_ vc: BaseViewController) {
        self.present(vc, animated: true)
    }
    
    func dismissVC() {
        self.dismiss(animated: true)
    }
    
    func pushVC(_ vc: BaseViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rootVC(_ vc: BaseViewController) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first
        else { return }

        window.rootViewController = UINavigationController(rootViewController: vc)
    }
    
    func presentAlert(_ alertInfo: AlertInfo) {
        let alert = UIAlertController(
            title: alertInfo.title,
            message: alertInfo.message,
            preferredStyle: .alert
        )
        
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(ok)
        
        alert.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        
        present(alert, animated: true)
    }
    
    func presentAlertWithCancel(_ alertInfo: AlertInfo) {
        let alert = UIAlertController(
            title: alertInfo.title,
            message: alertInfo.message,
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction(title: "아냐!", style: .cancel)
        let ok = UIAlertAction(title: "웅", style: .default) { _ in
            alertInfo.submitHandler?()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        alert.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
        
        present(alert, animated: true)
    }
    
}
