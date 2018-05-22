//
//  ViewController.swift
//  Stretch My Header
//
//  Created by Alejandro Zielinsky on 2018-05-22.
//  Copyright © 2018 Alejandro Zielinsky. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    struct NewsItem
    {
        enum Category {
            case World
            case Americas
            case Europe
            case MiddleEast
            case Africa
            case AsiaPacific
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    
    let newsItems = [NewsItem.Category.World,NewsItem.Category.Europe,NewsItem.Category.MiddleEast,NewsItem.Category.Africa,NewsItem.Category.AsiaPacific,NewsItem.Category.Americas,NewsItem.Category.World,NewsItem.Category.Europe]
    
    let headlines = ["Climate change protests, divestments meet fossil fuels realities","Scotland's 'Yes' leader says independence vote is 'once in a lifetime'","Airstrikes boost Islamic State, FBI director warns more hostages possible","Nigeria says 70 dead in building collapse; questions S. Africa victim claim","Despite UN ruling, Japan seeks backing for whale hunting","Officials: FBI is tracking 100 Americans who fought alongside IS in Syria","South Africa in $40 billion deal for Russian nuclear reactors","'One million babies' created by EU student exchanges"]
    
    var headerView : UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let numOfItems = 8;
    
    let kTableHeight : CGFloat = 300;
    
    private let kTableHeaderCutAway: CGFloat = 80.0
    
    var headerMaskLayer: CAShapeLayer!

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       self.navigationController?.isNavigationBarHidden = true
        
        tableView.rowHeight = UITableViewAutomaticDimension;
        
        let now = Date()
        let dateFormatter = DateFormatter()
        //  dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMM dd"
        dateLabel.text = dateFormatter.string(from: now)
        
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        
        
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil;
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0 , y: -kTableHeight);
        updateHeaderView();
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numOfItems
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func getTitleAndColor(category:NewsItem.Category) -> (String,UIColor)
    {
        switch category {
        case .World:
            return ("World",UIColor.red);
        case .Americas:
             return ("Americas",UIColor.blue);
        case .Europe:
             return ("Europe",UIColor.green);
        case .MiddleEast:
             return ("Middle East",UIColor.yellow);
        case .Africa:
             return ("Africa",UIColor.orange);
        case .AsiaPacific:
             return ("Asia Pacific",UIColor.purple);
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! NewsCell;
        
        let (title,color) = getTitleAndColor(category: newsItems[indexPath.row]);
        
        cell.CategoryLabel.text = title;
        cell.CategoryLabel.textColor = color;
        cell.HeadlineLabel.text = headlines[indexPath.row];
    
        return cell;
    }

}

extension ViewController : UIScrollViewDelegate
{
    func updateHeaderView()
    {
        var headerRect = CGRect(x:0,y:-kTableHeight,width:tableView.bounds.width,height:kTableHeight)
        if tableView.contentOffset.y < -kTableHeight
        {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect;
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0,y:0))
        path.addLine(to: CGPoint(x:headerRect.width,y:0))
        path.addLine(to: CGPoint(x:headerRect.width,y:headerRect.height))
        path.addLine(to: CGPoint(x:0,y:headerRect.height - kTableHeaderCutAway))
        headerMaskLayer?.path = path.cgPath
       headerView.layer.mask = headerMaskLayer
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
}

