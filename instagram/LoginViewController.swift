//
//  LoginViewController.swift
//  instagram
//
//  Created by 三木一樹 on 2021/04/28.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    
    
    @IBAction func handleLoginBUtton(_ sender: Any) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text {

                    // アドレスとパスワード名のいずれかでも入力されていない時は何もしない
                    if address.isEmpty || password.isEmpty {
                        SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
                        return
                    }

                    // HUDで処理中を表示
                    SVProgressHUD.show()
            
            Auth.auth().signIn(withEmail: address, password: password) { authResult, error in
                if let error = error {
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "サインインに失敗しました。")
                    return
                }
                print("DEBUG_PRINT: ログインに成功しました。")

                // HUDを消す
                SVProgressHUD.dismiss()

                // 画面を閉じてタブ画面に戻る
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
       
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text, let displayName = displayNameTextField.text{
            if address.isEmpty || password.isEmpty || displayName.isEmpty {
                print("DEBUG_PRINT: 何かが空文字です。")
                    SVProgressHUD.showError(withStatus: "必須項目を入力して下さい")
                return
            }
            
            SVProgressHUD.show()
            
            Auth.auth().createUser(withEmail: address, password: password){authResult, error in
                if let error = error{
                    print("DEBUG_PRINT:" + error.localizedDescription)
                    return
                }
                print("DEBUG_PRINT: ユーザ作成に成功しました。")
                
                SVProgressHUD.dismiss()
                
                let user = Auth.auth().currentUser
                if let user = user{
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges { error in
                        if let error = error  {
                            print("DEBUG_PRINT: "+error.localizedDescription)
                            return}
                        print("DEBUG_PRINT:[displayName=\(user.displayName!)]の設定に成功しました")
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
