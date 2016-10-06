//
//  AddServerViewController.swift
//  OrangeIRC
//
//  Created by Andrew Hyatt on 7/5/16.
//
//

import UIKit
import OrangeIRCCore

class AddServerViewController : UITableViewController {
    
    struct CellIdentifiers {
        static let TextFieldCell = "TextFieldCell"
        static let SwitchCell = "SwitchCell"
    }
    
    static let REQUIRED = NSLocalizedString("REQUIRED", comment: "Required")
    static let OPTIONAL = NSLocalizedString("OPTIONAL", comment: "Optional")
    
    var hostCell: TextFieldCell?
    var portCell: TextFieldCell?
    var nicknameCell: TextFieldCell?
    var usernameCell: TextFieldCell?
    var realnameCell: TextFieldCell?
    var passwordCell: TextFieldCell?
    var autoJoinCell: SwitchCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("ADD_SERVER", comment: "Add Server")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tempFieldCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.TextFieldCell)
        if tempFieldCell == nil {
            tempFieldCell = TextFieldCell()
        }
        let textFieldCell = tempFieldCell as! TextFieldCell
        
        var tempSwitchCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.SwitchCell)
        if tempSwitchCell == nil {
            tempSwitchCell = SwitchCell()
        }
        textFieldCell.textField.autocorrectionType = .no
        textFieldCell.textField.autocapitalizationType = .none
        
        let switchCell = tempSwitchCell as! SwitchCell
        
        var returnValue: UITableViewCell = textFieldCell
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                textFieldCell.textLabel!.text = NSLocalizedString("HOSTNAME", comment: "Hostname")
                textFieldCell.textField.placeholder = NSLocalizedString("IRC_DOT_EXAMPLE_DOT_COM", comment: "irc.example.com")
                textFieldCell.textField.keyboardType = .URL
                self.hostCell = textFieldCell
            case 1:
                textFieldCell.textLabel!.text = NSLocalizedString("PORT", comment: "Port")
                textFieldCell.textField.placeholder = "6667"
                textFieldCell.textField.keyboardType = .numberPad
                self.portCell = textFieldCell
            case 2:
                textFieldCell.textLabel!.text = NSLocalizedString("PASSWORD", comment: "Password")
                textFieldCell.textField.placeholder = AddServerViewController.OPTIONAL
                textFieldCell.textField.isSecureTextEntry = true
                self.passwordCell = textFieldCell
            case 3:
                self.autoJoinCell = switchCell
                switchCell.textLabel!.text = NSLocalizedString("AUTOMATICALLY_JOIN", comment: "Automatically Join")
                returnValue = switchCell
            default:
                break
            }
        case 1:
            switch  indexPath.row {
            case 0:
                textFieldCell.textLabel!.text = NSLocalizedString("NICKNAME", comment: "Nickname")
                textFieldCell.textField.placeholder = AddServerViewController.REQUIRED
                self.nicknameCell = textFieldCell
            case 1:
                textFieldCell.textLabel!.text = NSLocalizedString("USERNAME", comment: "Username")
                textFieldCell.textField.placeholder = AddServerViewController.REQUIRED
                self.usernameCell = textFieldCell
            case 2:
                textFieldCell.textLabel!.text = NSLocalizedString("REAL_NAME", comment: "Real Name")
                textFieldCell.textField.placeholder = AddServerViewController.REQUIRED
                textFieldCell.textField.autocapitalizationType = .words
                self.realnameCell = textFieldCell
            default:
                break
            }
        default:
            break
        }
        
        return returnValue
    }
    
    @IBAction func doneBarButton(_ sender: UIBarButtonItem) {
        // TODO: Implement sanity checks
        
        let server = self.appDelegate.addServer(host: (self.hostCell?.textField.text)!, port: Int((self.portCell?.textField.text)!)!, nickname: (self.nicknameCell?.textField.text)!, username: (self.usernameCell?.textField.text)!, realname: (self.realnameCell?.textField.text)!, password: (self.passwordCell?.textField.text)!)
        server.autoJoin = self.autoJoinCell!.switch.isOn
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
