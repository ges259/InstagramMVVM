//
//  LoginController.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/06.
//

import UIKit

final class LoginController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = LoginViewModel()
    
    
    weak var delegate: AuthenticationDelegate?
    
    
    
    
    
    // MARK: - Image_View
    private let iconImg: UIImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
    
    
    
    
    // MARK: - TextField
    private lazy var emailTextField: UITextField = UITextField().loginTextField(keyboardType: .emailAddress,
                                                                                placeholerText: "Email")
    
    private lazy var passwordTextField: UITextField = UITextField().loginTextField(keyboardType: .emailAddress,
                                                                                   placeholerText: "Password",
                                                                                   isSecure: true)
    
    
    
    
    // MARK: - StackView
    private lazy var stackView: UIStackView = UIStackView().stackView(arrangedSubviews: [self.emailTextField,
                                                                                         self.passwordTextField,
                                                                                         self.loginBtn],
                                                                      axis: .vertical,
                                                                      spacing: 13)
    
    
    
    
    // MARK: - Button
    private lazy var loginBtn: UIButton = UIButton().loginButton(title: "Log In")
    
    private lazy var forgotPasswordBtn: UIButton = {
        let btn = UIButton()
            btn.setAttributedTitle(NSMutableAttributedString().attributedText(
                type1TextString: "Forgot you password?  ",
                type1FontSize: 13,
                type2TextString: "Get help sign in.",
                type2FontSize: 13), for: .normal)
        return btn
    }()
    
    private lazy var dontHaveAcccoutBtn: UIButton = {
        let btn = UIButton()
            btn.setAttributedTitle(NSMutableAttributedString().attributedText(
                type1TextString: "Don't Have an account?   ",
                type2TextString: "Sign Up"), for: .normal)
        return btn
    }()
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.addSelectors()
    }
    
    
    
    
    
    // MARK: - Helper_Functions
    private func configureUI() {
        // Nav_Config
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        // Background_Color
        self.configureGradientLayer()
        // Auto_Layout
        // iconImg
        self.view.addSubview(self.iconImg)
        self.iconImg.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                            paddingTop: 32,
                            width: 250, height: 80,
                            centerX: self.view)
        // stackView
        self.view.addSubview(self.stackView)
        self.stackView.anchor(top: self.iconImg.bottomAnchor, paddingTop: 32,
                              leading: self.view.leadingAnchor, paddingLeading: 32,
                              trailing: self.view.trailingAnchor, paddingtrailing: 32)
        // forgotPasswordBtn
        self.view.addSubview(self.forgotPasswordBtn)
        self.forgotPasswordBtn.anchor(top: self.stackView.bottomAnchor, paddingTop: 15,
                                      leading: self.stackView.leadingAnchor,
                                      trailing: self.stackView.trailingAnchor)
        // dontHaveAcccoutBtn
        self.view.addSubview(self.dontHaveAcccoutBtn)
        self.dontHaveAcccoutBtn.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                       centerX: self.view)
    }
    
    
    
    private func addSelectors() {
        self.emailTextField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.textDidChange), for: .editingChanged)
        
        self.loginBtn.addTarget(self, action: #selector(self.handleLogin), for: .touchUpInside)
        
        self.dontHaveAcccoutBtn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        self.forgotPasswordBtn.addTarget(self, action: #selector(self.handleShowResetPassword), for: .touchUpInside)
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func handleShowSignUp() {
        let controller = RegisterationController()
            controller.delegate = self.delegate
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == self.emailTextField {
            self.viewModel.email = sender.text
        } else {
            self.viewModel.password = sender.text
        }
        self.updateForm()
    }
    
    @objc private func handleShowResetPassword() {
        let controller = ResetPasswordController(email: self.emailTextField.text,
                                                 viewModel: ResetPasswordViewModel())
            controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func handleLogin() {
        guard let email = self.emailTextField.text,
              let password = self.passwordTextField.text else { return }
        AuthService.logUserIn(email: email, password: password) {
            self.delegate?.authenticationComplete()
        }
    }
}





// MARK: - FormViewModel
extension LoginController: FormViewModel {
    func updateForm() {
        self.loginBtn.isEnabled = self.viewModel.formIsValid
        self.loginBtn.backgroundColor = self.viewModel.btnBackgroundColor
        self.loginBtn.setTitleColor(self.viewModel.btnTitleColor, for: .normal)
    }
}




// MARK: - ResetPasswordControllerDelegate
extension LoginController: ResetPasswordControllerDelegate {
    func controllerDidSendResetPasswordLink(_ controller: ResetPasswordController) {
        self.navigationController?.popViewController(animated: true)
        self.showMessage(withTitle: "Success",
                        message: "We sent a Link yout email to reset your password")
    }
}
