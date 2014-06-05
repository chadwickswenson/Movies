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
        posters = ["poster1","poster2","poster3","poster4","poster5","poster6","poster7","poster8","poster9","poster10"]
         posters2 = ["poster3","poster1","poster11","poster2","poster4","poster5","poster7","poster9","poster12","poster13"]
       
       
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
            cell.posterImageView.image = UIImage(named:posters[indexPath.row])
        }
        
        
        cell.infoView.alpha = cellState
        
       var button1Animation = POPSpringAnimation()
        
        button1Animation.property = POPAnimatableProperty.propertyWithName(kPOPLayerPosition) as POPAnimatableProperty
        //let aRect: CGPoint = CGPointMake(50, 50)
        button1Animation.toValue = NSValue(CGPoint: CGPointMake(cell.frame.origin.x+50, cell.frame.origin.y+50))
        
        button1Animation.springBounciness = 21.0
        button1Animation.springSpeed = 10.0
        
        cell.layer.pop_addAnimation(button1Animation, forKey:"back")
        
        return cell
    }
    
    
    
}