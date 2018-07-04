//
//  XFListViewController.swift
//  XploreFlickr
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 6/13/18.
//  Copyright © 2018 Ganesan, Veeramani - Contractor {BIS}. All rights reserved.
//

import UIKit

class XFListViewController: UIViewController {

    @IBOutlet weak var galleryListView: UITableView!
    
    private static let kXFListViewCellID        = "XFListViewCellID"
    private static let kXFPhotoGallerySegueID   = "XFPhotoGallerySegueID"
    private var selectedGalleryId: String? = nil
    
    let xfListViewModel = XFListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        galleryListView.dataSource = self
        galleryListView.delegate = self
        
        xfListViewModel.galleryList.bind { (galleries) in
            self.galleryListView.reloadData()
        }
        
        xfListViewModel.setupGalleryList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let xfGalleryViewCntlr = segue.destination as? XFGalleryViewController
        xfGalleryViewCntlr?.galleryId = self.selectedGalleryId
    }
}

extension XFListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedGalleryId = xfListViewModel.galleryList.value[indexPath.row].id
        self.performSegue(withIdentifier: XFListViewController.kXFPhotoGallerySegueID, sender: self)
    }
}

extension XFListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return xfListViewModel.galleryList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let xfListViewCell = tableView.dequeueReusableCell(withIdentifier: XFListViewController.kXFListViewCellID, for: indexPath) as? XFListViewCell
        
        let gallery = xfListViewModel.galleryList.value[indexPath.row]
        
        let imageLoadObj = AsyncImageLoad(withURL: gallery.thumbnail)
        
        imageLoadObj.loadImage { (image, error) in
            
            DispatchQueue.main.async {
                
                if error == nil {
                    xfListViewCell?.thumbView.image = image
                }
                else
                {
                    print(error!)
                }
            }
        }
        xfListViewCell?.titleLabel.text = gallery.title
        xfListViewCell?.descLable.text = gallery.description
        
        return xfListViewCell!
    }
}
