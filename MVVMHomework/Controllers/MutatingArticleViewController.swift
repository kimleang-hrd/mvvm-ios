//
//  AddArticleViewController.swift
//  MVVMHomework
//
//  Created by Kimleang Kea on 12/24/19.
//  Copyright © 2019 Kimleang Kea. All rights reserved.
//

import UIKit

class MutatingArticleViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    let floatingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemOrange
        button.tintColor = .white
        return button
    }()
    
    let imagePickerController = UIImagePickerController()
    
    let articleViewModel = ArticleViewModel()
    var articleDelegate: ArticleDelegate?
    var isAdding = true
    var articleModel: ArticleModel?
    
    var isImageNotChanged = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(floatingButton)
        
        setupFloatingActionButton()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imagePickerClicked))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(singleTap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.layer.cornerRadius = 0.5 * floatingButton.bounds.width
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initEditData()
    }
    
    @objc func imagePickerClicked() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
            self.getImage(fromSourceType: .camera)
        })
        alert.addAction(UIAlertAction(title: "Photo", style: .default) { _ in
            self.getImage(fromSourceType: .photoLibrary)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            print("SourceType is not available")
        }
    }
    
    func initEditData() {
        if let article = articleModel {
            titleTextField.text = article.articleTitle
            descriptionTextField.text = article.description
            imageView.kf.setImage(with: article.imageUrl)
        }
    }
    
    func setupFloatingActionButton() {
        NSLayoutConstraint.activate([
            self.floatingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            self.floatingButton.heightAnchor.constraint(equalToConstant: 50),
            self.floatingButton.widthAnchor.constraint(equalToConstant: 50),
        ])
        self.floatingButton.clipsToBounds = true
        self.floatingButton.setImage(UIImage(systemName: "plus"), for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.floatingButton.transform = CGAffineTransform(translationX: -16, y: -16)
        }
        if isAdding {
            floatingButton.setImage(UIImage(systemName: "plus"), for: .normal)
        } else {
            floatingButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        }
        floatingButton.addTarget(self, action: #selector(floatingButtonClicked), for: .touchUpInside)
    }
    
    @objc func floatingButtonClicked() {
        if self.isAdding {
            self.insertArticle()
         } else {
            self.updateArticle()
        }
    }
    
    func insertArticle() {
        var article = Article()
        article.articleTitle = self.titleTextField.text
        article.description = self.descriptionTextField.text
        SweetAlert().showLoadingScreen(self)
        self.articleViewModel.addArticle(image: self.imageView.image ?? UIImage(), article: article) { [weak self] (articleModel) in
            guard let self = self else {
                return
            }
            SweetAlert().showAlert("Success", subTitle: "You have inserted successfully.", style: .success, buttonTitle: "Ok") { [weak self] (_) in
                guard let self = self else {
                    return
                }
                self.articleDelegate?.didFinishInsertingArticle(articleModel)
                self.navigationController?.popViewController(animated: true)
            }.animateAlert()
            SweetAlert().dismissLoadingScreen(self)
        }
    }
    
    func updateArticle() {
        var article = Article()
        article.articleTitle = self.titleTextField.text
        article.description = self.descriptionTextField.text
        article.imageUrl = self.articleModel?.imageUrl?.absoluteString
        article.id = self.articleModel?.hiddenId
        SweetAlert().showLoadingScreen(self)
        self.articleViewModel.updateArticle(isImageNotChanged: self.isImageNotChanged, image: self.imageView.image ?? UIImage(), article: article) { [weak self] (articleModel) in
            guard let self = self else {
                return
            }
            SweetAlert().showAlert("Success", subTitle: "You have updated successfully.", style: .success, buttonTitle: "Ok") { [weak self] (_) in
                guard let self = self else {
                    return
                }
                self.articleDelegate?.didFinishUpdatingArticle(articleModel)
                self.navigationController?.popViewController(animated: true)
            }.animateAlert()
            SweetAlert().dismissLoadingScreen(self)
        }
    }
    
}
extension MutatingArticleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        self.imageView.image = image
        self.isImageNotChanged = false
    }
}

