//
//  ReviewCell.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 07/01/2026.
//
import UIKit
import SnapKit

final class ReviewCell: UITableViewCell {
    
    static let identifier = String(describing: ReviewCell.self)
    
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }()
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Medium", size: 12)
        label.textColor = UIColor(named: "selectedTabBar")
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with review: Review) {
        authorLabel.text = review.author
        contentLabel.text = review.content
        
        if let ratingValue = review.rating {
            ratingLabel.text = "\(ratingValue)"
        } else {
            ratingLabel.text = "N/A"
        }
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        [authorLabel, contentLabel].forEach(stackView.addArrangedSubview)
        [movieImage, stackView, ratingLabel].forEach(contentView.addSubview)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        movieImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview()
            make.size.equalTo(44)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerX.equalTo(movieImage)
            make.top.equalTo(movieImage.snp.bottom).offset(8)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.top)
            make.leading.equalTo(movieImage.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}


