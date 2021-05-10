//
//  ViewController.swift
//  instagram
//
//  Created by 三木一樹 on 2021/05/07.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var postdata:PostData!
    let name = Auth.auth().currentUser?.displayName
    @IBOutlet weak var commentBox: UITextField!
    
    @IBAction func completeButton(_ sender: Any) {
        if let myid = Auth.auth().currentUser?.uid {
            var updateValue: FieldValue
            updateValue = FieldValue.arrayUnion([name! + ":" + commentBox.text!]) // ここでmyidの代わりにコメントしたユーザー名とコメントを保存
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postdata.id)
            postRef.updateData(["comments": updateValue]) // likesというフィールドではなくcommentsなどのフィールドに保存
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
