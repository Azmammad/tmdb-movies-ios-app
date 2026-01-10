
//
//  DetailsView.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 10/01/2026.
//

//import UIKit
//import SnapKit
//
//final class DetailsView: UIView {
//    let scrollView: UIScrollView = {
//        let scroll = UIScrollView()
//        scroll.showsVerticalScrollIndicator = false
//        scroll.backgroundColor = .appbackground
//        return scroll
//    }()
//    
//    private let contentView = UIView()
//    
//    let backdropView = BackdropView()
//    let headerView = HeaderView()
//    let tabsView = TabsView()
//    let contentBlockView = ContentView()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        
//        [backdropView, headerView, tabsView, contentBlockView]
//            .forEach { contentView.addSubview($0) }
//        
//        setupConstraints()
//    }
//    
//   
//    private func setupConstraints() {
//        
//        scrollView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        
//        contentView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//            $0.width.equalTo(scrollView)
//        }
//    
//        backdropView.snp.makeConstraints {
//            $0.top.leading.trailing.equalToSuperview()
//            $0.height.equalTo(211)
//        }
//        
//        headerView.snp.makeConstraints {
//            $0.top.equalTo(backdropView.snp.bottom)
//            $0.leading.trailing.equalToSuperview()
//        }
//        
//        tabsView.snp.makeConstraints {
//            $0.top.equalTo(headerView.snp.bottom).offset(32)
//            $0.leading.trailing.equalToSuperview().inset(24)
//        }
//        
//
//        contentBlockView.snp.makeConstraints {
//            $0.top.equalTo(tabsView.snp.bottom).offset(24)
//            $0.leading.trailing.equalToSuperview().inset(24)
//            $0.bottom.equalToSuperview().offset(-40)
//        }
//    }
//}
