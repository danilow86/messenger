//
//  RegisterViewController.swift
//  Messenger
//
//  Created by danilo on 08/10/2023.
//

import UIKit
import FirebaseAuth
import Foundation


class RegisterViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let firsNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First name..."
        
        field.leftView = UIView(frame: CGRect(x:0, y:0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.attributedPlaceholder = NSAttributedString(string: "First name...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(10.0)])
        return field
    }()
    
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name..."
        
        field.leftView = UIView(frame: CGRect(x:0, y:0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.attributedPlaceholder = NSAttributedString(string: "Last Name...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(10.0)])
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."
        field.leftView = UIView(frame: CGRect(x:0, y:0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.attributedPlaceholder = NSAttributedString(string: "Email Address...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(10.0)])
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x:0, y:0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        field.attributedPlaceholder = NSAttributedString(string: "Password...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(10.0)])
        
        return field
    }()
    
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        registerButton.addTarget(self,
                                 action: #selector(registerButtonTapped),
                                 for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //Add subviews
        view.addSubview(scrollView)
        view.addSubview(imageView)
        scrollView.addSubview(firsNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(registerButton)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target:self,
                                             action: #selector(didTapChangeProfilePic))
        
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeProfilePic(){
        presentPhotoActionSheet()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 100,
                                 width: size,
                                 height: size)
        
        imageView.layer.cornerRadius = imageView.width/2.0
        
        firsNameField.frame = CGRect(x: 30,
                                     y: imageView.bottom+10,
                                     width: scrollView.width-60,
                                     height: 52)
        lastNameField.frame = CGRect(x: 30,
                                     y: firsNameField.bottom+10,
                                     width: scrollView.width-60,
                                     height: 52)
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom+10,
                                     width: scrollView.width-60,
                                     height: 52)
        registerButton.frame = CGRect(x: 30,
                                      y: passwordField.bottom+10,
                                      width: scrollView.width-60,
                                      height: 52)
    }
    
    @objc private func registerButtonTapped(){
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firsNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        
        guard let firstName = firsNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
              !lastName.isEmpty,
              password.count >= 6 else{
            alertUserLoginError()
            return
        }
        
        //Firebase log in
        
        DatabaseManager.shared.userExists(with: email, completion:{[weak self] exists in
            guard let strongSelf = self else {
                return
            }
            
            guard !exists else{
                //user already exists
                strongSelf.alertUserLoginError(message: "Looks like a user account for that email address already exists")
                return
            }
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
                
                guard  authResult != nil, error == nil else {
                    print("Error creating user")
                    return
                }
                
                DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: String,
                                                                    lastName: String,
                                                                    emailAddress: String))
                
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            })
        })
        
        
    }
    
    func alertUserLoginError(message: String = "Please enter all information to create a new account"){
        let alert = UIAlertController(title: "Something wrong",
                                      message:"Please enter all information to create a new account",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Dismiss",
                                      style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension RegisterViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField{
            passwordField.becomeFirstResponder()
        }else if textField == passwordField{
            registerButtonTapped()
        }
        
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would like to select a picture",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title:"Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title:"Take Photo",
                                            style: .default,
                                            handler: {[weak self] _ in
            self?.presentCamera()}))
        actionSheet.addAction(UIAlertAction(title:"Choose Photo",
                                            style: .default,
                                            handler: {[weak self] _ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print(info)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


