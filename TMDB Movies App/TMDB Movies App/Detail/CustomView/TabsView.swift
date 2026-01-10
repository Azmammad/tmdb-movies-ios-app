
//
//  TabsView.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 10/01/2026.
//

//import UIKit
//import SnapKit
//
//final class TabsView: UIView {
//
//    var tabButtons: [UIButton] = []
//
//    let tabsStack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.spacing = 40
//        return stack
//    }()
//
//    let indicatorView = AppIndicatorView()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) { fatalError() }
//
//    private func setupUI() {
//        addSubview(tabsStack)
//        addSubview(indicatorView)
//
//        indicatorView.backgroundColor = UIColor(named: "indicatorView")
//        indicatorView.layer.cornerRadius = 2
//
//        setupConstraints()
//    }
//
//    private func setupConstraints() {
//
//       
//        tabsStack.snp.makeConstraints {
//            $0.leading.trailing.top.equalToSuperview()
//        }
//
//        indicatorView.snp.makeConstraints {
//            $0.top.equalTo(tabsStack.snp.bottom).offset(2)
//            $0.centerX.equalToSuperview()
//            $0.height.equalTo(4)
//            $0.width.equalTo(0)
//            $0.bottom.equalToSuperview()
//        }
//    }
//}
