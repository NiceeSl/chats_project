//
//  ViewController.swift
//  new_project
//
//  Created by work on 12.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBAction func homeButton(_ sender: Any) {
    }
    @IBAction func NotificationsButton(_ sender: Any) {
    }
    @IBAction func CreateButton(_ sender: Any) {
    }
    @IBAction func ChatsButton(_ sender: Any) {
    }
    @IBAction func AccountButton(_ sender: Any) {
    }
    
    var chats = [Chat]()
    var sections = [Section]()
    
    func loadSection() {
        sections.append(Section(chats: [chats[0], chats[1], chats[2]], section: "Сегодня", isExpandable: true))
        sections.append(Section(chats: [chats[3]], section: "В субботу 12 марта", isExpandable: true))
        sections.append(Section(chats: [chats[4], chats[5]], section: "Завершенные", isExpandable: true))
    }
    
    func loadChat() {
        chats.append(Chat(name: "Бетмен", login: "alina.loon, 27", message: "Отлично, встретимся там...", image: "photo_1", emotion: "cherry", timeOfEvent: "17:00", lastMessage: "14:41" ))
        chats.append(Chat(name: "Стиль", login: "cristina, 23", message: "ок", image: "photo_2", emotion: "icon.emotion", timeOfEvent: "20:00", lastMessage: "12:41" ))
        chats.append(Chat(name: "Ужин", login: "ann.aeom, 25", message: "ок", image: "photo_3" , emotion: "icon.emotion3", timeOfEvent: "23:00", lastMessage:  "12:41" ))
        chats.append(Chat(name: "Kaif", login: "ann.aeom, 25", message: "Отлично, встретимся там...", image: "photo_3", emotion: "icon.emotion3", timeOfEvent: "", lastMessage: "14:41" ))
        chats.append(Chat(name: "Whiteikeo", login: "angelika, 23", message: "Отлично, встретимся там...", image: "photo_4", emotion: "icon.emotion5",  timeOfEvent: "12 января", lastMessage: "14:41" ))
        chats.append(Chat(name: "Макияждлясебя", login: "olaeiue, 25", message: "Отлично, встретимся там...", image: "photo_5", emotion: "icon.emotion6", timeOfEvent: "9 декабря", lastMessage: "14:41" ))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadChat()
        loadSection()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

        //tableView.sectionHeaderHeight = UITableView.automaticDimension
        //tableView.estimatedSectionHeaderHeight = 36;
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(sections[section].isExpandable) {
          return sections[section].chats.count
        }
        else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].section
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //let header = Bundle.main.loadNibNamed("Header", owner: Header.self , options: nil)?.first as! Header
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 35))
        headerView.backgroundColor = .systemGray6
        headerView.delegate = self
        headerView.secIndex = section
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 30))
        lbl.text = sections[section].section
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerView.btn.addSubview(lbl)
        
        if (sections.count - 1 != section && sections[section].isExpandable) {

            headerView.secIndex = nil
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35//UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! MyCell
        //let chat = chats[indexPath.row]
        cell.configureImage(chat: chats[indexPath.row])
        cell.nameLabel.text = sections[indexPath.section].chats[indexPath.row].name
        cell.accountLabel.text = sections[indexPath.section].chats[indexPath.row].login
        cell.messageLabel.text = sections[indexPath.section].chats[indexPath.row].message
        cell.timeOfEventLbl.text = sections[indexPath.section].chats[indexPath.row].timeOfEvent
        cell.lastMessageLbl.text = sections[indexPath.section].chats[indexPath.row].lastMessage
        if (chats.count - 4 == indexPath.section)  {
            cell.backView.isHidden = true
        }
        print("indexPath.section = ",indexPath.section)
        if (sections.count - 1 == indexPath.section) {
            cell.timeOfEventLbl.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            cell.timeOfEventLbl.textColor = .red
            cell.timeOfEventLbl.text = "Test"
            //print(sections.count - 1)
        }
//        if (sections.count - 2 == indexPath.section) {
//            cell.timeOfEventLbl.textColor = .white
//        }
//        if (sections.count == indexPath.section) {
//            cell.accountLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
//        }
        return cell
    }
}

extension ViewController: HeaderDelegate {
    func callHeader(idx: Int) {
        sections[idx].isExpandable = !sections[idx].isExpandable
        tableView.reloadSections([idx], with: .automatic)
    }
}

