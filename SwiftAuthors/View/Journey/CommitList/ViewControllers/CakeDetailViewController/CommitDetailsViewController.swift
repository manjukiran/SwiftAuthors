//
//  CommitDetailsViewController.swift
//  SwiftAuthors
//
//  Created by Manju Kiran on 18/02/2021.
//  Copyright © 2021 Manju Kiran. All rights reserved.
//

import UIKit

class CommitDetailsViewController: UIViewController {
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var commitMessageLabel: UILabel!
    
    var commit: CommitElement?
    
    /// Function to instantiate view controller with dependency injection of a view model;
    /// this approach is used for VCs instantiated from the storyboard
    ///
    /// - Parameter CommitElement:  model object to act as the data source
    /// - Returns: CommitDetailsViewController object
    class func create(_ commit: CommitElement) -> CommitDetailsViewController? {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = storyBoard.instantiateViewController(withIdentifier: CommitDetailsViewController.storyboardIdentifier) as? CommitDetailsViewController {
            vc.commit = commit
            return vc
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(configureUI),
                                               name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureUI()
    }
    
    @objc private func configureUI() {
        UIView.runOnMainThread {
            self.authorNameLabel.text = self.commit?.commit.author.name
            self.commitMessageLabel.text = self.commit?.commit.message
            self.configureAuthorImageView()
        }
    }
    
    /// Configures Profile view to have a circular image mask and borders it with the theme color
    private func configureAuthorImageView() {
        let strokeColor = AppTheme.themeColor ?? .white
        self.authorImageView.applyStroke(strokeWidth: 5, strokeColor: strokeColor)
        if let url = URL(string: commit?.author?.avatarURL ?? ""){
            NetworkDataUtility.shared.fetchImageDataWithUrl(url: url) { [weak self] (result) in
                switch result {
                case .success(let image):
                    UIView.runOnMainThread {
                        self?.authorImageView.image = image
                    }
                case .failure(let error):
                    print("Image Fetch failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
}
