//
//  LoginVC.swift
//  PP4_Recipes
//
//  Created by Russell Churchwell on 12/2/20.
//

import UIKit
import AVKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var handle: AuthStateDidChangeListenerHandle?
    var user: User?

    @IBOutlet weak var errO: UILabel!
    @IBOutlet weak var tF2: UITextField!
    @IBOutlet weak var tF1: UITextField!
    @IBOutlet weak var lBO: UIButton!
    @IBOutlet weak var lO: UIImageView!
    @IBOutlet weak var iFO: UIView!
    @IBOutlet weak var cBO: UIButton!
    
    @IBAction func loginAct(_ sender: UIButton) {
        let email = (!tF1.text!.isEmpty) ? tF1.text : nil
        let password = (!tF2.text!.isEmpty) ? tF1.text : nil
        
        if email != nil && password != nil{
            signIn()
        }
        
        else{
            errO.text = "NOT ALL FIELDS ARE FILLED IN!"
            errO.alpha = 1
        }
    }
    
    @IBAction func dismissA(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tF1.delegate = self
        tF2.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLRBackground()
    }
    
    func setupLRBackground(){
        let vidRoot = Bundle.main.path(forResource: "Chef3", ofType: "mp4")
        let vidURL = URL(fileURLWithPath: vidRoot!)
        
        
        let vid = AVPlayerItem(url: vidURL)
        
        player = AVPlayer(playerItem: vid)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.view.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(playerLayer!)
        
        self.view.bringSubviewToFront(lO)
        self.view.bringSubviewToFront(iFO)
        self.view.bringSubviewToFront(lBO)
        self.view.bringSubviewToFront(cBO)
        
        player?.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func signIn(){
        Auth.auth().signIn(withEmail: tF1.text!, password: tF2.text!) { (result, error) in
            
            self.user = result?.user
            
            if error == nil{
                print(self.user!.uid.description)
                self.errO.alpha = 0
                
                self.performSegue(withIdentifier: "testTrans", sender: self)
            }
            else{
                self.errO.text = "INVALID LOGIN!"
                self.errO.alpha = 1
            }
        }
          
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let dest = segue.destination as! RecipesVCTableViewController
//    }
}
