//
//  MovieInfoCell.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 10.01.26.
//

import UIKit
import SnapKit

class MovieInfoCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: MovieInfoCell.self)
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let ratingView = IconLabelView()
    private let genreView = IconLabelView()
    private let yearView = IconLabelView()
    private let durationView = IconLabelView()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .appbackground
        selectionStyle = .none
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [titleLabel, ratingView, genreView, yearView, durationView].forEach(infoStackView.addArrangedSubview)
        contentView.addSubview(posterImageView)
        contentView.addSubview(infoStackView)
        
    }
    
    private func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.verticalEdges.equalToSuperview().inset(12)
            make.width.equalTo(100)
            make.height.equalTo(130)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        
        ratingView.configure(
            icon: UIImage(systemName: "star.fill"),
            text: String(format: "%.1f", movie.voteAverage),
            tintColor: .systemOrange
        )
        
        if let genreIds = movie.genreIds, !genreIds.isEmpty {
            let genreName = GenreHelper.getFirstGenreName(from: genreIds)
            genreView.configure(
                icon: UIImage(systemName: "film"),
                text: genreName,
                tintColor: .systemGray
            )
        } else {
            genreView.configure(
                icon: UIImage(systemName: "film"),
                text: "Unknown",
                tintColor: .systemGray
            )
        }
        
        if let releaseDate = movie.releaseDate, !releaseDate.isEmpty {
            let year = String(releaseDate.prefix(4))
            yearView.configure(
                icon: UIImage(systemName: "calendar"),
                text: year,
                tintColor: .systemGray
            )
        } else {
            yearView.configure(
                icon: UIImage(systemName: "calendar"),
                text: "N/A",
                tintColor: .systemGray
            )
        }
        
        durationView.configure(
            icon: UIImage(systemName: "clock"),
            text: "139 minutes",
            tintColor: .systemGray
        )
        
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            loadImage(from: posterURL)
        } else {
            posterImageView.image = nil
        }
    }
    
    private func loadImage(from url: URL?) {
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self?.posterImageView.image = image
            }
        }.resume()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
    }
    
}
