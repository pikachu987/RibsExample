//
//  LoggedOutViewController.swift
//  TicTacToe
//
//  Created by 김관호 on 2021/12/05.
//  Copyright © 2021 Uber. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol LoggedOutPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func login(withPlayer1Name player1Name: String?, player2Name: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    
    private let player1TextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width - 40, height: 60))
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let player2TextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 160, width: UIScreen.main.bounds.width - 40, height: 60))
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("Login", for: .normal)
        button.frame = CGRect(x: 20, y: 240, width: UIScreen.main.bounds.width - 40, height: 60)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(player1TextField)
        view.addSubview(player2TextField)
        view.addSubview(actionButton)
        
        player1TextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        player2TextField.snp.makeConstraints {
            $0.top.equalTo(player1TextField.snp.bottom).inset(-20)
            $0.leading.trailing.equalTo(player1TextField)
        }
        
        actionButton.snp.makeConstraints {
            $0.top.equalTo(player2TextField.snp.bottom).inset(-20)
            $0.leading.trailing.equalTo(player1TextField)
        }
        
        actionButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    @objc private func didTapLoginButton() {
        listener?.login(withPlayer1Name: player1TextField.text, player2Name: player2TextField.text)
    }
}
