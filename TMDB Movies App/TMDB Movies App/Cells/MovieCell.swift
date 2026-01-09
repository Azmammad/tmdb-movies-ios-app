//
//  MovieCell.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 06.01.26.
//

import UIKit
import SnapKit

final class MovieCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: MovieCell.self)
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        ratingLabel.text = nil
    }
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(ratingLabel)
    }
    
    private func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(40)
        }
    }
    
    func configure(with movie: Movie) {
        ratingLabel.text = String(format: "%.1f", movie.voteAverage)
        
        if let url = TMDBImage.poster(movie.posterPath) {
            loadImage(from: url)
        }
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.posterImageView.image = image
            }
        }.resume()
    }
}
