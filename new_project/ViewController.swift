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
    var photos = [Photo]()
    var emotions = [Emotion]()
    
    func loadEmotion() {
        emotions.append(Emotion(emotion: "cherry"))
        emotions.append(Emotion(emotion: "icon.emotion"))
        emotions.append(Emotion(emotion: "icon.emotion3"))
        emotions.append(Emotion(emotion: "icon.emotion5"))
        emotions.append(Emotion(emotion: "image6"))
    }

    func loadImage() {
        photos.append(Photo(photo: "photo_1"))
        photos.append(Photo(photo: "photo_2"))
        photos.append(Photo(photo: "photo_3"))
        photos.append(Photo(photo: "photo_4"))
        photos.append(Photo(photo: "photo_5"))
    }
    
    func loadSection() {
        sections.append(Section(chats: [chats[0], chats[1], chats[2]], section: "Сегодня", isExpandable: true))
        sections.append(Section(chats: [chats[3]], section: "В субботу 12 марта", isExpandable: true))
        sections.append(Section(chats: [chats[4], chats[5]], section: "Завершенные", isExpandable: true))
    }
    
    func loadChat() {
        chats.append(Chat(name: "Бетмен", login: "alina.loon, 27", message: "Отлично, встретимся там...", image: photos[0], emotion: emotions[0], timeOfEvent: "17:00", lastMessage: "14:41", isOnline: true ))
        chats.append(Chat(name: "Стиль", login: "cristina, 23", message: "ок", image: photos[1], emotion: emotions[1], timeOfEvent: "20:00", lastMessage: "12:41", isOnline: false ))
        chats.append(Chat(name: "Ужин", login: "ann.aeom, 25", message: "ок", image: photos[2] , emotion: emotions[2], timeOfEvent: "23:00", lastMessage:  "12:41", isOnline: false ))
        chats.append(Chat(name: "Kaif", login: "ann.aeom, 25", message: "Отлично, встретимся там...", image: photos[2], emotion: emotions[2], timeOfEvent: "", lastMessage: "14:41", isOnline: false ))
        chats.append(Chat(name: "Whiteikeo", login: "angelika, 23", message: "Отлично, встретимся там...", image: photos[3], emotion: emotions[3],  timeOfEvent: "12 января", lastMessage: "14:41", isOnline: false ))
        chats.append(Chat(name: "Макияждлясебя", login: "olaeiue, 25", message: "Отлично, встретимся там...", image: photos[4], emotion: emotions[4], timeOfEvent: "9 декабря", lastMessage: "14:41", isOnline: false ))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadImage()
        loadEmotion()
        loadChat()
        loadSection()
        
        
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }

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
        return 35 //UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! MyCell
        cell.updateContent(sections[indexPath.section].chats[indexPath.row])
        
        if(sections[indexPath.section].section == "Завершенные") {
            cell.accountLabel.textColor = .systemGray2
            cell.timeOfEventLbl.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
        
        func isFirstRowInSection() {
            if(indexPath.row == 0){
                cell.view.roundCorners([.topLeft, .topRight], radius: 15)
            }
        }
        
        func isLastRowInSection() {
            if(indexPath.row == sections[indexPath.section].chats.count - 1) {
                cell.view.roundCorners([.bottomLeft, .bottomRight], radius: 15)
            }
        }
        
        isFirstRowInSection()
        isLastRowInSection()
        
        if((indexPath.row == 0) && (indexPath.row == sections[indexPath.section].chats.count - 1)) {
            cell.view.roundCorners(.allCorners, radius: 15)
        }
        
        if(indexPath.section == 0) {
            cell.backView.isHidden = false
        }
        
        if(sections[indexPath.section].chats[indexPath.row].isOnline == true) {
        }
        return cell
    }
}

extension ViewController: HeaderDelegate {
    func callHeader(idx: Int) {
        sections[idx].isExpandable = !sections[idx].isExpandable
        tableView.reloadSections([idx], with: .automatic)
    }
}

