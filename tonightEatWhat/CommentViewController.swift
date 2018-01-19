//
//  CommentViewController.swift
//  tonightEatWhat
//
//  Created by Sam on 25/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = ["1","2","3","4","5","1","2","3","4","5"]
    var username = ["Sam Ho", "Ronald Chan", "john Chung", "Jo ker", "Ivan Kwong","Sam Ho", "Ronald Chan", "john Chung", "Jo ker", "Ivan Kwong"]
    var comment =
        ["好食 好好食",
         "難道故事終結早已注定 沒法制止",
         "其實我不理一切 挑戰拼命試",
         "攀險峰千次萬次",
         "沿路滿地佈著刺 也沒有在意",
         "六國破滅，非兵不利，戰不善，弊在賂秦。賂秦而力虧，破滅之道也。或曰：「六國互喪，率賂秦耶？」曰：「不賂者以賂者喪，蓋失強援，不能獨完，故曰弊在賂秦也。」",
         "回望最初 漆黑裡緊張的碰撞",
         "雷電重擊 在一刻交錯",
         "不安神情驚慌 還覺驚嘆徬徨",
         "然後某刻 靜默時簡單的對望"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! CommentCollectionViewCell
        cell.propic.image = UIImage(named: images[indexPath.row])
        cell.propic.layer.cornerRadius = cell.propic.frame.height/2
        cell.propic.layer.masksToBounds = true
        
        //add constraint
        cell.comment.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.comment.numberOfLines = 0
        let additional_height = CGFloat(comment[indexPath.row].characters.count/15*20)
        print("Height:",additional_height)
        
        cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: cell.frame.size.width, height: cell.frame.size.height+additional_height)
        
        cell.comment.text = comment[indexPath.row] //input comment content
        
        cell.username.text = username[indexPath.row]
        cell.posttime.text = String(arc4random_uniform(59)+1) + "分鐘"
        return cell
    }
    


}
