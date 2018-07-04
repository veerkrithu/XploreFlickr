//
//  XFImageDetailView.swift
//  XploreFlickr
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 6/14/18.
//  Copyright © 2018 Ganesan, Veeramani - Contractor {BIS}. All rights reserved.
//

import UIKit

class XFImageDetailView: UIView {
    
    let xfImageDetailViewModel = XFImageDetailViewModel()
    
    var imageView:UIImageView?
    var nameLabel:UILabel?
    var nameValueLabel:UILabel?
    var descLabel:UILabel?
    var descValueLabel:UILabel?
    var dateLabel:UILabel?
    var dateValueLabel:UILabel?
    var viewsLabel:UILabel?
    var viewsValueLabel:UILabel?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.alpha = 0
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector (zoomOut)))
        
        setUpImageViewandConstraints()
        setUpNameLabelViewandConstraints()
        setUpDateLabelViewandConstraints()
        setUpViewsLabelViewandConstraints()
        setUpDescLabelViewandConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc func zoomOut() {
        
        UIView.animate(withDuration: 0.6, animations: {
            self.transform = CGAffineTransform.identity
            self.alpha = 0
            
        }) { (isCompleted) in
            self.removeFromSuperview()
        }
    }
    
    func setUpImageViewandConstraints() {
        
        imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))
        imageView?.backgroundColor = UIColor.blue
        self.addSubview(imageView!)
        
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        imageView?.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        imageView?.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        imageView?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.40).isActive = true
        imageView?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.60).isActive = true
    }
    
    func setUpNameLabelViewandConstraints() {
        
        nameLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 40, height: 15))
        nameLabel?.text = "Name"
        nameLabel?.font = nameLabel?.font.withSize(7.0)
        nameLabel?.textColor = UIColor.white
        self.addSubview(nameLabel!)
        
        nameLabel?.translatesAutoresizingMaskIntoConstraints = false
        nameLabel?.topAnchor.constraint(equalTo: (self.imageView?.bottomAnchor)!, constant:20.0).isActive = true
        nameLabel?.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        nameLabel?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameValueLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 40, height: 15))
        nameValueLabel?.text = "Name Value ame Value ame Value ame Value"
        nameValueLabel?.font = nameValueLabel?.font.withSize(7.0)
        nameValueLabel?.textColor = UIColor.white
        self.addSubview(nameValueLabel!)
        
        nameValueLabel?.translatesAutoresizingMaskIntoConstraints = false
        nameValueLabel?.topAnchor.constraint(equalTo: (self.imageView?.bottomAnchor)!, constant:20.0).isActive = true
        nameValueLabel?.leadingAnchor.constraint(equalTo: (self.nameLabel?.trailingAnchor)!, constant:10.0).isActive = true
        nameValueLabel?.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant:-5.0).isActive = true
    }
    
    func setUpDateLabelViewandConstraints() {
        
        dateLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 40, height: 15))
        dateLabel?.text = "Date Taken"
        dateLabel?.font = dateLabel?.font.withSize(7.0)
        dateLabel?.textColor = UIColor.white
        self.addSubview(dateLabel!)
        
        
        dateLabel?.translatesAutoresizingMaskIntoConstraints = false
        dateLabel?.topAnchor.constraint(equalTo: (self.nameLabel?.bottomAnchor)!, constant:8.0).isActive = true
        dateLabel?.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        dateLabel?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        dateValueLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 40, height: 15))
        dateValueLabel?.text = "2016-06-02 02:56:27"
        dateValueLabel?.font = dateValueLabel?.font.withSize(7.0)
        dateValueLabel?.textColor = UIColor.white
        self.addSubview(dateValueLabel!)
        
        dateValueLabel?.translatesAutoresizingMaskIntoConstraints = false
        dateValueLabel?.topAnchor.constraint(equalTo: (self.nameValueLabel?.bottomAnchor)!, constant:8.0).isActive = true
        dateValueLabel?.leadingAnchor.constraint(equalTo: (self.dateLabel?.trailingAnchor)!, constant:10.0).isActive = true
    }
    
    func setUpViewsLabelViewandConstraints() {
        
        viewsLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 40, height: 15))
        viewsLabel?.text = "Views"
        viewsLabel?.font = viewsLabel?.font.withSize(7.0)
        viewsLabel?.textColor = UIColor.white
        self.addSubview(viewsLabel!)
        
        
        viewsLabel?.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel?.topAnchor.constraint(equalTo: (self.dateLabel?.bottomAnchor)!, constant:8.0).isActive = true
        viewsLabel?.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        viewsLabel?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        viewsValueLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 40, height: 15))
        viewsValueLabel?.text = "155786"
        viewsValueLabel?.font = viewsValueLabel?.font.withSize(7.0)
        viewsValueLabel?.textColor = UIColor.white
        self.addSubview(viewsValueLabel!)
        
        viewsValueLabel?.translatesAutoresizingMaskIntoConstraints = false
        viewsValueLabel?.topAnchor.constraint(equalTo: (self.dateValueLabel?.bottomAnchor)!, constant:8.0).isActive = true
        viewsValueLabel?.leadingAnchor.constraint(equalTo: (self.viewsLabel?.trailingAnchor)!, constant:10.0).isActive = true
    }
    
    func setUpDescLabelViewandConstraints() {
        
        descLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 50, height: 0))
        descLabel?.text = "Description"
        descLabel?.font = descLabel?.font.withSize(7.0)
        descLabel?.textColor = UIColor.white
        self.addSubview(descLabel!)
        
        descLabel?.translatesAutoresizingMaskIntoConstraints = false
        descLabel?.topAnchor.constraint(equalTo: (self.viewsLabel?.bottomAnchor)!, constant:8.0).isActive = true
        descLabel?.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        descLabel?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        descValueLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 50, height: 0))
        descValueLabel?.lineBreakMode = .byWordWrapping
        descValueLabel?.numberOfLines = 0
        descValueLabel?.text = "Name Value ame Value ame Value ame Value Name Value ame Value ame Value ame Value Name Value ame Value ame Value ame Value Name Value ame Value ame Value ame Value"
        descValueLabel?.font = descValueLabel?.font.withSize(7.0)
        descValueLabel?.textColor = UIColor.white
        self.addSubview(descValueLabel!)
        
        descValueLabel?.translatesAutoresizingMaskIntoConstraints = false
        descValueLabel?.topAnchor.constraint(equalTo: (self.descLabel?.bottomAnchor)!, constant:5.0).isActive = true
        descValueLabel?.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant:10.0).isActive = true
        descValueLabel?.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    func animateView(withDuration: TimeInterval, toSuperView: UIView) {
        
        toSuperView.addSubview(self)
        UIView.animate(withDuration: withDuration, animations: {
            
            self.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.alpha = 1
            
        }) { (isCompleted) in
            
        }
    }
    
    deinit {
        print("In XFImageDetailView DeInt")
    }
}
