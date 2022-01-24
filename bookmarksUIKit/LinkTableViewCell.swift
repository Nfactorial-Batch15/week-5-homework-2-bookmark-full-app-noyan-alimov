//
//  LinkTableViewCell.swift
//  bookmarksUIKit
//
//  Created by Noyan Alimov on 24/01/2022.
//

import UIKit

class LinkTableViewCell: UITableViewCell {
    
    private let lineView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let linkImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "link")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Bookmark) {
        self.titleLabel.text = model.title
    }
    
    func setUI() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(linkImageView)
        linkImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(80)
        }
        
        linkImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hanleIv)))
    }
    
    
    @objc func hanleIv() {
        print("DEBUG: Hello ")
    }
}
