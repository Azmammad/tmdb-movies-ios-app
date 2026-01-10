//
//  EmptyStateView.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 11.01.26.
//


import UIKit
import SnapKit

final class EmptyStateView: UIView {

    private let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "emptySearch"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "We Are Sorry, We Can\nNot Find The Movie :("
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Find your movie by Type title,\ncategories, years, etc"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
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
        setupConstarints()

    }
    
    private func addSubviews() {
        [imageView, titleLabel, subtitleLabel].forEach(addSubview)
    }
    
    private func setupConstarints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(32)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(32)
        }
    }
}
