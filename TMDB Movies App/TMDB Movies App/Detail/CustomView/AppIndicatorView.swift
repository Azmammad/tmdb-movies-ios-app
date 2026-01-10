//
//  AppIndicatorView.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 07/01/2026.
//

import UIKit
import SnapKit

final class AppIndicatorView: UIView {
    
    init(color: UIColor? = UIColor(named: "indicatorView"), height: CGFloat = 4) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.clipsToBounds = true
        
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
