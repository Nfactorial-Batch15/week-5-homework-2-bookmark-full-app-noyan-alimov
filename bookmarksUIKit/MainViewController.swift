//
//  MainViewController.swift
//  bookmarksUIKit
//
//  Created by Noyan Alimov on 23/01/2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var bookmarks: [Bookmark] = Storage.bookmarks {
        didSet {
            checkLinks()
        }
    }
    
    private let headerTitle: UILabel = {
        let title = UILabel()
        title.text = "Bookmark App"
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
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.register(LinkTableViewCell.self, forCellReuseIdentifier: "LinkTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self

        showHeaderTitle()
        
        showCenterText()
        showBookmarksTable()
        
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
            self.bookmarks.append(bookmark)
            Storage.bookmarks.append(bookmark)
            self.tableView.reloadData()
        }
        alert.addAction(loginAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
        }
        alert.addAction(cancelAction)
        
        // PRESENT
        present(alert, animated: true)
    }
    
    func checkLinks() {
        if self.bookmarks.isEmpty {
            centerText.isHidden = false
            tableView.isHidden = true
        } else {
            centerText.isHidden = true
            tableView.isHidden = false
        }
    }
    
    func showBookmarksTable() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(42)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LinkTableViewCell", for: indexPath) as? LinkTableViewCell else { return UITableViewCell() }
        cell.configure(model: bookmarks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
