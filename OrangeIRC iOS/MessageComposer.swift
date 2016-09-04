//
//  MessageComposer.swift
//  OrangeIRC
//
//  Created by Andrew Hyatt on 9/4/16.
//
//

import UIKit
import OrangeIRCCore

class MessageComposer : UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    var room: Room?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Link to the room
        room = (navigationController! as! ComposerNavigationController).room
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        navigationItem.title = "\(room!.name) @ \(room!.server!.host)"
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func done() {
        room!.send(message: textView.text)
        cancel()
    }
    
}
