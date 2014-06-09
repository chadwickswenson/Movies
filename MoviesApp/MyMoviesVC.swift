//
//  MyMoviesVC.swift
//  MoviesApp
//
//  Created by chad swenson on 6/2/14.
//  Copyright (c) 2014 Chad Swenson. All rights reserved.
//

import Foundation
import UIKit

var posters = String[]()
var posters2 = String[]()
var cellState = 0.0
var listNumber = 0
var seenMovies = [("poster1.png", "Lord of the Rings", "2003")]

class MyMoviesVC: UICollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet var moviesCollectionView : UICollectionView = nil
    
    
    @IBAction func listToggleHandler(sender : AnyObject) {
        if(listNumber == 0){
            listNumber = 1;
        }
        else{
            listNumber = 0;
        }
        
        moviesCollectionView.reloadData()
    }
    @IBAction func cellOverlayHandler(sender : AnyObject) {
        if(cellState > 0){
            cellState = 0.0;
        }
        else{
            cellState = 1.0;
        }
        
        moviesCollectionView.reloadData()
    }
   
    @IBAction func toggleListHandler(sender : AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        posters = ["poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8","poster9","poster10","poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8","poster9","poster10","poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8","poster9","poster10","poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8","poster9","poster10","poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8","poster9","poster10","poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8","poster9","poster10"]
         posters2 = ["poster3","poster1","poster11","poster2","poster4","poster5","poster7","poster9","poster12","poster13","poster3","poster1","poster11","poster2","poster4","poster5","poster7","poster9","poster12","poster13","poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8","poster9","poster10","poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8","poster9","poster10","poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8","poster9","poster10","poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8","poster9","poster10"]
        
       // var seenMovies = [("poster1.png", "Lord of the Rings", "2003")]
        
        for i in 1...20 {
            seenMovies += ("poster\(i).png", "lotr", "2004")
        }
        
       println(seenMovies[2].0)
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return posters.count
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        let id: String = "MovieCell"
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(id, forIndexPath: indexPath) as MovieCell
        if(listNumber == 1){
            cell.posterImageView.image = UIImage(named:posters2[indexPath.row])
        }
        else{
            cell.posterImageView.image = UIImage(named:seenMovies[indexPath.row].0)
        }
        var f = cell.posterImageView.frame
        f.size.width = 0
        f.size.height = 0
        f.origin.x = 50
        f.origin.y = 75
        cell.posterImageView.frame = f
        
        cell.infoView.alpha = Float(cellState)
        
        var cellAni = POPSpringAnimation()
        
        cellAni.property = POPAnimatableProperty.propertyWithName(kPOPLayerSize) as POPAnimatableProperty
        
        cellAni.toValue = NSValue(CGSize: CGSizeMake(105, 152))
        
        cellAni.springBounciness = CGFloat(arc4random()%6+5)
        cellAni.springSpeed = CGFloat(arc4random()%20+10)
        
        
        cell.posterImageView.layer.pop_addAnimation(cellAni,forKey:"back")
        
        return cell
    }
    
    
    
}