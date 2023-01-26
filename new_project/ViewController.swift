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
    var messages = [Message]()
    
    func takeDate(year: Int,mounth: Int, day: Int, hour: Int, minute: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.day = day
        components.month = mounth
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components)!
    }
    
    func loadEmotion() {
        emotions.append(Emotion(emotion: "cherry"))
        emotions.append(Emotion(emotion: "icon.emotion"))
        emotions.append(Emotion(emotion: "icon.emotion3"))
        emotions.append(Emotion(emotion: "icon.emotion5"))
        emotions.append(Emotion(emotion: "image6"))
    }
    
    func loadMessage() {
        messages.append(Message(text: "Отлично, встретимся там...", messageDate: takeDate(year: 2023, mounth: 1, day: 12, hour: 14, minute: 41)))
        messages.append(Message(text: "ок", messageDate: takeDate(year: 2023, mounth: 1, day: 12, hour: 12, minute: 41)))
        messages.append(Message(text: "ок", messageDate: takeDate(year: 2023, mounth: 1, day: 12, hour: 12, minute: 41)))
        messages.append(Message(text: "Отлично, встретимся там...", messageDate: takeDate(year: 2023, mounth: 3, day: 12, hour: 14, minute: 41)))
        messages.append(Message(text: "Отлично, встретимся там...", messageDate: takeDate(year: 2023, mounth: 1, day: 12, hour: 14, minute: 41)))
        messages.append(Message(text: "Отлично, встретимся там...", messageDate: takeDate(year: 2023, mounth: 12, day: 9, hour: 14, minute: 41)))
        
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
        chats.append(Chat(name: "Бетмен", login: "alina.loon, 27", message: messages[0], image: photos[0], emotion: emotions[0], startedAt: takeDate(year: 2023, mounth: 1, day: 12,hour: 17,minute: 0), completedAt: takeDate(year: 2024, mounth: 1, day: 12, hour: 17, minute: 0), isOnline: true ))
        
        
        chats.append(Chat(name: "Стиль", login: "cristina, 23", message: messages[1], image: photos[1], emotion: emotions[1], startedAt: takeDate(year: 2023, mounth: 1, day: 12, hour: 20, minute: 0), completedAt: takeDate(year: 2024, mounth: 1, day: 12, hour: 20, minute: 0), isOnline: false ))
        
        
        chats.append(Chat(name: "Ужин", login: "ann.aeom, 25", message: messages[2], image: photos[2] , emotion: emotions[2], startedAt: takeDate(year: 2023, mounth: 1, day: 12, hour: 23, minute: 0), completedAt: takeDate(year: 2024, mounth: 1, day: 12, hour: 23, minute: 0), isOnline: false ))
        
        
        chats.append(Chat(name: "Kaif", login: "ann.aeom, 25", message: messages[3], image: photos[2], emotion: emotions[2], startedAt: takeDate(year: 2023, mounth: 3, day: 12, hour: 17, minute: 0), completedAt: takeDate(year: 2024, mounth: 3, day: 12, hour: 17, minute: 0), isOnline: false ))
        
        
        chats.append(Chat(name: "Whiteikeo", login: "angelika, 23", message: messages[4], image: photos[3], emotion: emotions[3], startedAt: takeDate(year: 2022, mounth: 1, day: 12, hour: 17, minute: 0), completedAt: takeDate(year: 2021, mounth: 1, day: 12, hour: 17, minute: 0), isOnline: false ))
        
        
        chats.append(Chat(name: "Макияждлясебя", login: "olaeiue, 25", message: messages[5], image: photos[4], emotion: emotions[4], startedAt: takeDate(year: 2022, mounth: 12, day: 12, hour: 17, minute: 0), completedAt: takeDate(year: 2022, mounth: 12, day: 9, hour: 17, minute: 0),  isOnline: false ))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadMessage()
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
        
//        if(sections[indexPath.section].section == "Завершенные") {
//            cell.accountLabel.textColor = .systemGray2
//            cell.timeOfEventLbl.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
//        }
        
//        func isFirstRowInsection(_: indexPath) -> Bool {
//           return indexPath.row == 0
//        }

        
        
        
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
            //GradientView.firstColor.cgColor = CGColor.init(srgbRed: 0, green: 255, blue: 0, alpha: 0.7)
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
