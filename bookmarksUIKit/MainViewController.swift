//
//  MainViewController.swift
//  bookmarksUIKit
//
//  Created by Noyan Alimov on 23/01/2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let headerTitle: UILabel = {
        let title = UILabel()
        title.text = bookmarks.count == 0 ? "Bookmark App" : "List"
        title.textColor = .black
        title.font = UIFont.boldSystemFont(ofSize: 17)
        return title
    }()
    
    private let centerText: UILabel = {
        let text = UILabel()
        text.text = "Save your first bookmark"
        text.textColor = .black
        text.numberOfLines = 2
        text.textAlignment = .center
        text.font = UIFont.boldSystemFont(ofSize: 36)
        return text
    }()
    
    private let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add bookmark", for: .normal)
        btn.backgroundColor = .black
        btn.tintColor = .white
        btn.layer.cornerRadius = 16
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        showHeaderTitle()
        
//        if bookmarks.count == 0 {
            showCenterText()
//        } else {
//            showBookmarks()
//        }
        
        showButton()
    }
    
    func showHeaderTitle() {
        view.addSubview(headerTitle)
        headerTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(56)
            make.width.equalTo(130)
            make.height.equalTo(22)
        }
    }
    
    func showCenterText() {
        view.addSubview(centerText)
        centerText.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.equalTo(358)
            make.height.equalTo(92)
        }
    }
    
    func showButton() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-50)
            make.width.equalTo(358)
            make.height.equalTo(58)
        }
        button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
    }
    
    @objc func onButtonTap() {
        let alert = UIAlertController(title: "Add bookmark", message: nil, preferredStyle: .alert)
        
        // ADD TEXT FIELDS
        alert.addTextField { (textField) in
          textField.placeholder = "Title"
        }
        alert.addTextField { (textField) in
          textField.placeholder = "Link"
        }
        
        // ADD ACTIONS HANDLER
        let loginAction = UIAlertAction(title: "Add", style: .default) { (_) in
            let titleTextField = alert.textFields![0] as UITextField
            let linkTextField = alert.textFields![1] as UITextField
            
            let bookmark = Bookmark(title: titleTextField.text!, link: linkTextField.text!)
            bookmarks.append(bookmark)
        }
        alert.addAction(loginAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
        }
        alert.addAction(cancelAction)
        
        // PRESENT
        present(alert, animated: true)
    }
    
//    func showBookmarks() {
//
//    }
}
