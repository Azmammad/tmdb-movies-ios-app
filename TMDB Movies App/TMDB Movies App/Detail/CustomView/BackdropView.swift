//
//  BackdropView.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 07/01/2026.
//

//import UIKit
//import SnapKit
//import Kingfisher
//
//final class BackdropView: UIView {
//    
//    let backdropImage: UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFill
//        iv.layer.cornerRadius = 16
//        iv.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        iv.clipsToBounds = true
//        return iv
//    }()
//    
//    private let ratingContainer: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 8
//        view.backgroundColor = UIColor(named: "ratingView")
//        view.clipsToBounds = true
//        return view
//    }()
//    
//    private let blurEffectView: UIVisualEffectView = {
//        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
//        return blur
//    }()
//    
//    private let starIcon: UIImageView = {
//        let iv = UIImageView(image: UIImage(systemName: "star"))
//        iv.tintColor = UIColor(named: "ratingLabel")
//        return iv
//    }()
//    
//    let ratingLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor(named: "ratingLabel")
//        label.font = UIFont(name: "Montserrat-SemiBold", size: 12)
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubviews()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) { fatalError() }
//    
//    private func addSubviews() {
//        [blurEffectView, starIcon, ratingLabel].forEach(ratingContainer.addSubview)
//        backdropImage.addSubview(ratingContainer)
//        addSubview(backdropImage)
//    }
//    
//    private func setupConstraints() {
//        backdropImage.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.height.equalTo(211)
//        }
//        
//        ratingContainer.snp.makeConstraints { make in
//            make.trailing.bottom.equalToSuperview().inset(12)
//            make.height.equalTo(24)
//        }
//        
//        blurEffectView.snp.makeConstraints { make in make.edges.equalToSuperview() }
//        
//        starIcon.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(8)
//            make.centerY.equalToSuperview()
//            make.size.equalTo(16)
//        }
//        ratingLabel.snp.makeConstraints { make in
//            make.leading.equalTo(starIcon.snp.trailing).offset(4)
//            make.trailing.equalToSuperview().inset(8)
//            make.centerY.equalToSuperview()
//        }
//    }
//}
