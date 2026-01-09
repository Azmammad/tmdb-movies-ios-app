//
//  CategoryCell.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 06.01.26.
//

import UIKit
import SnapKit

final class CategoryCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: CategoryCell.self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        //label.numberOfLines = 0
        //label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
        setupAppearance()
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setupAppearance() {
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        updateAppearance()
    }
    
    private func updateAppearance() {
        if isSelected {
            contentView.backgroundColor = .systemBlue
            titleLabel.textColor = .white
        } else {
            contentView.backgroundColor = .clear
            titleLabel.textColor = .white
        }
    }
    
    func configure(with category: MovieCategory) {
        titleLabel.text = category.title
    }
}
