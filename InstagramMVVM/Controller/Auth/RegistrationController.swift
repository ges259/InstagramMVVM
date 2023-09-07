//
//  RegistrationController.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/06.
//

import UIKit

final class RegisterationController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = RegisterationViewModel()
    
    
    private var profileImg: UIImage?
    
    weak var delegate: AuthenticationDelegate?
    
    
    
    
    
    // MARK: - Button
    private lazy var plusPhotoBtn: UIButton = {
        let btn = UIButton().ImgBtnConfig(img: #imageLiteral(resourceName: "plus_photo"), tintColor: UIColor.white)
            btn.addTarget(self, action: #selector(self.handlePhotoTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var alreadyHaveAcccoutBtn: UIButton = {
        let btn = UIButton()
            btn.setAttributedTitle(NSMutableAttributedString().attributedText(
                type1TextString: "Already Have an account?   ",
                type2TextString: "Sign In"), for: .normal)
            btn.addTarget(self, action: #selector(self.handleShowLogin),
                          for: .touchUpInside)
        return btn
    }()
    
    private lazy var signUpBtn: UIButton = {
        let btn = UIButton().loginButton(title: "Sign Up")
            btn.addTarget(self, action: #selector(self.handleSignUp), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    // MARK: - TextField
    private lazy var emailTextField: UITextField = {
        return UITextField().loginTextField(keyboardType: .emailAddress,
                                            placeholerText: "Email")
    }()
    
    private lazy var passwordTextField: UITextField = {
        return UITextField().loginTextField(keyboardType: .emailAddress,
                                            placeholerText: "Password",
                                            isSecure: true)
    }()
    
    private lazy var fullNameTextField: UITextField = {
        return UITextField().loginTextField(keyboardType: .emailAddress,
                                            placeholerText: "FullName")
    }()
    
    private lazy var userNameTextField: UITextField = {
        return UITextField().loginTextField(keyboardType: .emailAddress,
                                            placeholerText: "Password")
    }()
    
    
    
    
    // MARK: - StackView
    private lazy var stackView: UIStackView = {
        return UIStackView().stackView(arrangedSubviews: [self.emailTextField,
                                                          self.passwordTextField,
                                                          self.fullNameTextField,
                                                          self.userNameTextField,
                                                          self.signUpBtn],
                                       axis: .vertical,
                                       spacing: 15)
    }()
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.configureNotificationObservers()
    }
    
    
    
    
    
    // MARK: - Helper_Functions
    private func configureUI() {
        // [Background_Color]
        self.configureGradientLayer()
        
        // [Auto_Layout]
        // plusPhotoBtn
        self.view.addSubview(self.plusPhotoBtn)
        self.plusPhotoBtn.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                                 paddingTop: 32,
                                 width: 140, height: 140,
                                 centerX: self.view)
        // stackView
        self.view.addSubview(self.stackView)
        self.stackView.anchor(top: self.plusPhotoBtn.bottomAnchor, paddingTop: 32,
                              leading: self.view.leadingAnchor, paddingLeading: 32,
                              trailing: self.view.trailingAnchor, paddingtrailing: 32)
        
        
        // dontHaveAcccoutBtn
        self.view.addSubview(self.alreadyHaveAcccoutBtn)
        self.alreadyHaveAcccoutBtn.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                       centerX: self.view)
    }
    
    
    private func configureNotificationObservers() {
        self.emailTextField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
        self.fullNameTextField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
        self.userNameTextField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
    }
    
    
    
    
    
    // MARK: - Seletors
    @objc private func handleShowLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleSignUp() {
        guard let email = self.emailTextField.text,
              let password = self.passwordTextField.text,
              let fullName = self.fullNameTextField.text,
              let userName = self.userNameTextField.text?.lowercased(),
              let profileImg = self.profileImg else { return }
              
        let credentials = AuthCredentials(email: email, password: password, fullName: fullName,
                                          userName: userName, profileImg: profileImg)
        
        AuthService.register(withCredentials: credentials) {
            self.delegate?.authenticationComplete()
        }
    }
    
    @objc private func handlePhotoTap() {
        let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == self.emailTextField { self.viewModel.email = sender.text
        } else if sender == self.passwordTextField { self.viewModel.password = sender.text
        } else if sender == self.fullNameTextField { self.viewModel.fullName = sender.text
        } else { self.viewModel.userName = sender.text
        }
        self.updateForm()
    }
}



// MARK: - Form_View_Mocel
extension RegisterationController: FormViewMocel {
    func updateForm() {
        self.signUpBtn.isEnabled = self.viewModel.formIsValid
        self.signUpBtn.backgroundColor = self.viewModel.btnBackgroundColor
        self.signUpBtn.setTitleColor(self.viewModel.btnTitleColor, for: .normal)
    }
}



// MARK: - Picker_Delegate
extension RegisterationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImg = info[.editedImage] as? UIImage else { return }
        
        self.plusPhotoBtn.layer.cornerRadius = plusPhotoBtn.frame.width / 2
        self.plusPhotoBtn.layer.masksToBounds = true
        self.plusPhotoBtn.layer.borderColor = UIColor.black.cgColor
        self.plusPhotoBtn.layer.borderWidth = 2
        self.plusPhotoBtn.setImage(selectedImg.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.profileImg = selectedImg
        self.dismiss(animated: true)
    }
}
