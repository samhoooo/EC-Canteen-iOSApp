//
//  ViewController.swift
//  CollectionView Testing
//
//  Created by Sam on 25/7/2017.
//  Copyright © 2017年 Sam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = ["1","2","3","4","5","1","2","3","4","5"]
    var username = ["Sam Ho", "Ronald Chan", "john Chung", "Jo ker", "Ivan Kwong","Sam Ho", "Ronald Chan", "john Chung", "Jo ker", "Ivan Kwong"]
    var comment =
        ["難道我可以扭轉宿命 重遇你一次",
         "難道故事終結早已注定 沒法制止",
         "其實我不理一切 挑戰拼命試",
         "攀險峰千次萬次",
         "沿路滿地佈著刺 也沒有在意",
         "即使傷過無數次 仍會願意",
         "回望最初 漆黑裡緊張的碰撞",
         "雷電重擊 在一刻交錯",
         "不安神情驚慌 還覺驚嘆徬徨",
         "然後某刻 靜默時簡單的對望",]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection_cell", for: indexPath) as! CollectionViewCell
        cell.propic.image = UIImage(named:images[indexPath.row])
        cell.username.text = username[indexPath.row]
        cell.comment.text = comment[indexPath.row]
        cell.posttime.text = String(arc4random_uniform(59)+1) + "分鐘"
        return cell
    }


}

