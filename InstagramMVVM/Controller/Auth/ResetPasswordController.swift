//
//  ResetPasswordController.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/10.
//

import UIKit

final class ResetPasswordController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: ResetPasswordViewModel
    
    weak var delegate: ResetPasswordControllerDelegate?
    
    var email: String?
    
    
    // MARK: - Layout
    private let emailTextField: UITextField = UITextField().loginTextField(placeholerText: "Email")
    
    private let iconImg: UIImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))

    private let resetPasswordBtn: UIButton = UIButton().loginButton(title: "password")
    
    
    private let backBtn: UIButton = UIButton().ImgBtnConfig(img: UIImage(systemName: "chevron.left")!,
                                                            tintColor: UIColor.white)
    
    
    // MARK: - StackView
    private lazy var stackView: UIStackView = UIStackView().stackView(arrangedSubviews:
                                                                        [self.emailTextField,
                                                                         self.resetPasswordBtn],
                                                                      axis: .vertical,
                                                                      spacing: 13)
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.addSelectors()
    }
    init(email: String?, viewModel: ResetPasswordViewModel) {
        self.email = email
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper_Funcions
    private func configureUI() {
        // Background_Color
        self.configureGradientLayer()
        
        if let email = email {
            self.emailTextField.text = email
            self.viewModel.email = email
            self.updateForm()
        }
        
        // [Auto_Layout]
        // backBtn
        self.view.addSubview(self.backBtn)
        self.backBtn.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 16,
                            leading: self.view.leadingAnchor, paddingLeading: 16)
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
        
        
    }
    private func addSelectors() {
        self.resetPasswordBtn.addTarget(self, action: #selector(self.handleResetPassword), for: .touchUpInside)
        self.backBtn.addTarget(self, action: #selector(self.handleDismissal), for: .touchUpInside)
        self.emailTextField.addTarget(self, action: #selector(self.textDidChange(sender:)), for: .editingChanged)
    }
    
    
    
    
    // MARK: - Selectors
    @objc private func handleResetPassword() {
        guard let email = self.emailTextField.text else { return }
        self.showLoader(true)
        
        AuthService.resetPassword(withEmail: email) { error in
            self.showLoader(false)
            if error == true {
                self.showMessage(withTitle: "Error", message: "다시 시도해보세요.")
            } else {
                self.delegate?.controllerDidSendResetPasswordLink(self)
            }
        }
    }
    
    @objc private func handleDismissal() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        self.viewModel.email = sender.text
        self.updateForm()
    }
    
    
    // MARK: - API
}





// MARK: - FormViewModel
extension ResetPasswordController: FormViewModel {
    func updateForm() {
        self.resetPasswordBtn.isEnabled = self.viewModel.formIsValid
        self.resetPasswordBtn.backgroundColor = self.viewModel.btnBackgroundColor
        self.resetPasswordBtn.setTitleColor(self.viewModel.btnTitleColor, for: .normal)
    }
}
