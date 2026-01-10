//
//  HeaderView.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 07/01/2026.
//

//import UIKit
//import SnapKit
//
//final class HeaderView: UIView {
//    
//    let posterImage: UIImageView = {
//        let iv = UIImageView()
//        iv.layer.cornerRadius = 16
//        iv.clipsToBounds = true
//        iv.contentMode = .scaleAspectFill
//        return iv
//    }()
//    
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "Poppins-SemiBold", size: 18)
//        label.textColor = .white
//        label.numberOfLines = 2
//        return label
//    }()
//    
//    private lazy var yearItem = createInfoItem(iconName: "calendar")
//    private lazy var durationItem = createInfoItem(iconName: "clock")
//    private lazy var genreItem = createInfoItem(iconName: "ticket")
//    
//    private let infoStack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.spacing = 20
//        return stack
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
//        [yearItem.0, createSeparator(), durationItem.0, createSeparator(), genreItem.0].forEach(infoStack.addArrangedSubview)
//        [posterImage, titleLabel, infoStack].forEach(addSubview)
//    }
//    
//    private func setupConstraints() {
//        posterImage.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(24)
//            make.top.equalToSuperview()
//            make.width.equalTo(95)
//            make.height.equalTo(120)
//        }
//        
//        titleLabel.snp.makeConstraints { make in
//            make.leading.equalTo(posterImage.snp.trailing).offset(16)
//            make.trailing.equalToSuperview().inset(24)
//            make.top.equalTo(posterImage.snp.top)
//        }
//        
//        infoStack.snp.makeConstraints { make in
//            make.top.equalTo(posterImage.snp.bottom).offset(24)
//            make.leading.equalToSuperview().inset(40)
//            make.bottom.equalToSuperview()
//        }
//    }
//    
//    private func createInfoItem(iconName: String) -> (UIStackView, UILabel) {
//        let stack = UIStackView(); stack.spacing = 4
//        let icon = UIImageView(image: UIImage(systemName: iconName)); icon.tintColor = .lightGray
//        icon.snp.makeConstraints { make in make.size.equalTo(16) }
//        let label = UILabel()
//        label.font = UIFont(name: "Montserrat-Medium", size: 12)
//        label.textColor = .lightGray
//        stack.addArrangedSubview(icon)
//        stack.addArrangedSubview(label)
//        return (stack, label)
//    }
//    
//    private func createSeparator() -> UIView {
//        let view = UIView()
//        view.backgroundColor = UIColor(named: "indicatorView")
//        view.snp.makeConstraints { make in
//            make.width.equalTo(2)
//            make.height.equalTo(16)
//        }
//        return view
//    }
//    
//    func setInfo(year: String, duration: String, genre: String) {
//            yearItem.1.text = year
//            durationItem.1.text = duration
//            genreItem.1.text = genre
//        }
//}
