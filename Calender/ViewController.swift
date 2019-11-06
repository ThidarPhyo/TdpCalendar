//
//  ViewController.swift
//  Calender
//
//  Created by Thidar Phyo on 10/7/19.
//  Copyright © 2019 Thidar Phyo. All rights reserved.
//

import UIKit
import FSCalendar

//class ClosureSleeve {
//    let closure: () -> ()
//
//    init(_ closure: @escaping () -> ()) {
//        self.closure = closure
//    }
//    @objc func invoke() {
//        closure
//    }
//}
class ViewController: UIViewController {
    
    fileprivate weak var calendar: FSCalendar!
    
    @IBOutlet weak var popupView: UIView!
//    var days = ["","一","二","三","四","五","六","七","八","九","十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","二十一","二十二","二十三","二十四","二十五","二十六","二十七","二十八","二十九","三十","三十一"]
    var days = ["","၁","၂","၃","၄","၅","၆","၇","၈","၉","၁၀","၁၁","၁၂","၁၃","၁၄","၁၅","၁၆","၁၇","၁၈","၁၉","၂၀","၂၁","၂၂","၂၃","၂၄","၂၅","၂၆","၂၇","၂၈","၂၉","၃၀","၃၁"]
    var datesWithEvent = ["2019-01-01", "2019-01-04", "2019-01-06", "2019-02-12", "2019-03-02", "2019-03-04", "2019-03-21", "2019-03-20", "2019-03-27", "2019-04-13", "2019-04-14", "2019-04-15", "2019-04-16", "2019-04-17", "2019-05-01", "2019-05-18", "2019-06-21", "2019-07-16", "2019-07-19", "2019-08-15", "2019-08-24", "2019-09-02", "2019-09-23", "2019-09-29", "2019-10-08", "2019-10-11","2019-10-12", "2019-10-13", "2019-10-14", "2019-10-15", "2019-11-10", "2019-11-11", "2019-12-22", "2019-12-25", "2019-12-26", "2019-12-31"]
    var eventMessages = [
        "New Year Holiday","Independence Day","Kayin New Year Day","Union Day",
        "Peasants' Day","Maha Shivaratri","March Equinox","Full Moon Day of Tabaung",
        "Armed Forces' Day","Maha Thingyan (Water Festival)","Maha Thingyan (Water Festival)","Maha Thingyan (Water Festival)",
        "Maha Thingyan (Water Festival)","Maha Thingyan (Water Festival)","Labor Day / May Day","Full Moon Day of Kasong",
        "June Solstice","Full Moon Day of Waso (Beginning of Buddhist Lent)","Martyrs' Day","Raksha Bandhan",
        "Janmashtami","Ganesh Chaturthi","September Equinox","Navaratri",
        "Dussehra","Full Moon Day of Thadingyut (End of Buddhist Lent)","Full Moon Day of Thadingyut Holiday (End of Buddhist Lent)","Full Moon Day of Thadingyut Holiday (End of Buddhist Lent)","Full Moon Day of Thadingyut Holiday (End of Buddhist Lent)","Full Moon Day of Thadingyut Holiday (End of Buddhist Lent)",
        "Full Moon Day of Tazaungmone","Full Moon Day of Tazaungmone Holiday","December Solstice","Christmas Day",
        "Kayin New Year Day","New Year Holiday"]

    var datesWithMultipleEvents = ["2015-10-08", "2015-10-16", "2015-10-20", "2015-10-28"]
    //var scrollDirection: FSCalendarScrollDirection = .horizontal

    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.isHidden = true
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 90, width: view.frame.width, height: view.frame.height))
//        let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 400 : 600
//        let calendar = FSCalendar(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.frame.maxY, width: view.frame.size.width, height: height))
        //calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scrollDirection = .vertical
        //calendar.allowsMultipleSelection = true
        //calendar.scope = .week
        calendar.firstWeekday = 2
        //calendar.appearance.headerDateFormat = "MMM yy";
        calendar.scope = .month
        //calendar.clipsToBounds = true
        calendar.appearance.weekdayTextColor = UIColor.black
        calendar.appearance.weekdayFont = .boldSystemFont(ofSize: 20)
        calendar.appearance.headerTitleColor = UIColor.black
        calendar.appearance.headerTitleFont = .boldSystemFont(ofSize: 22)
        calendar.appearance.titleFont = .systemFont(ofSize: 20)
        //calendar.appearance.subtitleFont = .systemFont(ofSize: 18)
        calendar.appearance.eventDefaultColor = UIColor.red
        calendar.appearance.selectionColor = UIColor.blue
        calendar.appearance.todayColor = UIColor.orange
        calendar.appearance.todaySelectionColor = UIColor.black
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        let todayItem = UIBarButtonItem(title: "TODAY", style: .plain, target: self, action: #selector(self.todayItemClicked(sender:)))
        self.navigationItem.leftBarButtonItem = todayItem
        self.navigationItem.leftBarButtonItem?.tintColor = .blue
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        button.setImage(UIImage(named: "icon_setting"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(handleSettings), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        view.addSubview(calendar)
        calendar.addSubview(popupView)
        self.calendar = calendar
        

    }
    
    @objc func handleSettings() {
        let alert = UIAlertController(title: "About Us", message: "Developed by Thidar Phyo", preferredStyle: .alert)
//        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.yellow
//        alert.view.tintColor = .white
        let passAction = UIAlertAction(title: "Dismiss", style: .default) { (_) in
           
        }
        //let destriveAction = UIAlertAction(title: "Destory", style: .destructive, handler: nil)
        alert.addAction(passAction)
        //actionSheet.addAction(destriveAction)
        present(alert, animated: true, completion: nil)
    }
    @objc
    func todayItemClicked(sender: AnyObject) {
        self.calendar.setCurrentPage(Date(), animated: false)
    }
    
    func presentActionSheet(title: String, message: String) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let passAction = UIAlertAction(title: "OKAY", style: .default) { (_) in
            
        }
        //let destriveAction = UIAlertAction(title: "Destory", style: .destructive, handler: nil)
        actionSheet.addAction(passAction)
        //actionSheet.addAction(destriveAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    

}
extension ViewController: FSCalendarDataSource, FSCalendarDelegate {
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "io"
//    }
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        //print(components)
        let dayOfMonth = components.day
        //print(dayOfMonth)
        //return ""
        return days[dayOfMonth!]
        
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
        return cell
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        let dateString = self.dateFormatter2.string(from: date)

        if self.datesWithEvent.contains(dateString) {
            return 1
        }

        if self.datesWithMultipleEvents.contains(dateString) {
            return 3
        }

        return 0
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        print("SELECT")
        //performSegue(withIdentifier: "popup", sender: nil)
        let index = datesWithEvent.firstIndex(of: dateFormatter2.string(from: date))
        //print(index)
        if (index != nil) {
            presentActionSheet(title: "\(dateFormatter2.string(from: date))", message: "\(eventMessages[index!])")
            print(dateFormatter2.string(from: date))
        } else {
            presentActionSheet(title: "\(dateFormatter2.string(from: date))", message: "No Event")
        }
        
//        if (popupView.isHidden == true) {
//            popupView.isHidden = false
//            navigationController?.setNavigationBarHidden(true, animated: true)
//            navigationController?.popViewController(animated: true)
//
//        } else {
//            popupView.isHidden = true
//            navigationController?.setNavigationBarHidden(true, animated: true)
//        }
        return monthPosition == .current
    }
    
    

}

