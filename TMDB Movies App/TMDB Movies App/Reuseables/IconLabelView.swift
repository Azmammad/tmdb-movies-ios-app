//
//  IconLabelView.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 10.01.26.
//

import UIKit
import SnapKit

class IconLabelView: UIView {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [iconImageView, label].forEach(stackView.addArrangedSubview)
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(14)
        }
    }
    
    func configure(icon: UIImage?, text: String, tintColor: UIColor = .systemGray) {
        iconImageView.image = icon
        iconImageView.tintColor = tintColor
        label.text = text
        label.textColor = tintColor
    }

}
