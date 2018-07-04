//
//  XFGalleryViewController.swift
//  XploreFlickr
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 6/12/18.
//  Copyright © 2018 Ganesan, Veeramani - Contractor {BIS}. All rights reserved.
//

import UIKit

class XFGalleryViewController: UIViewController {
    
    public var galleryId: String? = nil
    
    private static let kXFGalleryViewCellID = "XFGalleryViewCellID"
    private let xfGalleryViewModel = XFGalleryViewModel()

    @IBOutlet weak var galleryView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting data source and delegate for collection view
        galleryView.dataSource = self
        galleryView.delegate = self
        
        //Configure collection view cell size and spacing
        let flow = galleryView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flow.itemSize = CGSize(width: 90, height: 90)
        flow.minimumInteritemSpacing = 3
        flow.minimumLineSpacing = 3
        
        //Binding view model photo gallery object to view controller. Any change in photo gallery model will trigger this bind listener and gallery collection view update inside the closre will be triggered.
        xfGalleryViewModel.galleryPhotos.bind { (photos) in
            
             DispatchQueue.main.async {
                self.galleryView.reloadData()
            }
        }
    
        //Loading the default animals photo gallery from Flickr
        if let id = galleryId {
            xfGalleryViewModel.setupPhotoGallery(galleryId: id)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//Extension to handle all collection view delegate methods
extension XFGalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photoID = self.xfGalleryViewModel.galleryPhotos.value[indexPath.row].id
        self.loadPhotoDetailView(forCollectionView: collectionView, andPhotoId: photoID)
    }
}

//Extension to handle all collection view data source methods
extension XFGalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return xfGalleryViewModel.galleryPhotos.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let xfGalleryViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: XFGalleryViewController.kXFGalleryViewCellID, for: indexPath) as? XFGalleryViewCell
        
        let photo = xfGalleryViewModel.galleryPhotos.value[indexPath.row]
        
        let imageLoadObj = AsyncImageLoad(withURL: photo.thumbnail!)
        
        xfGalleryViewCell?.activityCntlr.startAnimating()
        imageLoadObj.loadImage { (image, error) in
            
            DispatchQueue.main.async {
                
                if error == nil {
                    xfGalleryViewCell?.imageView.image = image
                }
                else
                {
                    print(error!)
                }
                xfGalleryViewCell?.activityCntlr.stopAnimating()
            }
        }
        
        return xfGalleryViewCell!
    }
}

extension XFGalleryViewController {
    
    func loadPhotoDetailView(forCollectionView collectionView: UICollectionView, andPhotoId photoId:String) {
        
        let xfImageDetailViewModel = XFImageDetailViewModel()
        
        let contentOffSet = collectionView.contentOffset
        let width = collectionView.frame.width / 2
        let height = collectionView.frame.height / 2
        
        let detailViewFrame = CGRect(x: width / 2, y: contentOffSet.y + (height / 2), width: width, height: height)
        let deatilView = XFImageDetailView(frame: detailViewFrame)
        deatilView.animateView(withDuration: 0.6, toSuperView: collectionView)
        
        xfImageDetailViewModel.downloadPhotoInfo(url: xfImageDetailViewModel.urlForPhotosInfo(id: photoId))
        
        xfImageDetailViewModel.photoDescModel.bind {(photoDescModel) in
            
            let id = self.xfGalleryViewModel.galleryPhotos.value.filter {(photoId.contains($0.id))}
            let imageLoadObj = AsyncImageLoad(withURL: (id.first?.source)!)
            
            imageLoadObj.loadImage(imgData: { (image, error) in
                
                DispatchQueue.main.async {
                    
                    if error == nil {
                        deatilView.imageView?.image = image
                    }
                    else
                    {
                        print(error!)
                    }
                }
            })
        }
    }
}
