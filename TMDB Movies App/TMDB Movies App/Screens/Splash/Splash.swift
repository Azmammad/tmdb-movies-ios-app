//
//  Splash.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 09/01/2026.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splashImage")
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateLogo()
    }
    
    private func setupUI() {
        view.backgroundColor = .appbackground
        addSubviews()
        setupConstarints()
    }
    
    private func addSubviews(){
        view.addSubview(logoImageView)
    }

    private func setupConstarints() {
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(120)
        }
    }
    
    private func animateLogo() {
        UIView.animate(
            withDuration: 0.8,
            delay: 0.2,
            options: .curveEaseOut
        ) {
            self.logoImageView.alpha = 1
            self.logoImageView.transform = .identity
        } completion: { _ in
            self.goToMain()
        }
    }

    private func goToMain() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let mainTabBar = MainTabBarController()
            mainTabBar.modalTransitionStyle = .crossDissolve
            mainTabBar.modalPresentationStyle = .fullScreen
            self.present(mainTabBar, animated: true)
        }
    }
}

