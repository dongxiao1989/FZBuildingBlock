//
//  ImageRotationViewController.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/2/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ImageRotationViewController: UIViewController {
    
    let originSize = CGSize(width: 250, height: 200)
    
    var image: UIImage!
    var imageView: UIImageView!
    var cutImageView: UIImageView!
    
    var rotation: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let image = UIImage.fz.image(withColor: UIColor.fz.randomColor(), size: CGSize(width: 250, height: 200)) {
            self.image = image
        }else{
            self.image = UIImage()
        }
        
        self.setUpView()
    }
    
    func setUpView() {
        let btn = UIButton(type: .custom)
        btn.fz.x = 100
        btn.fz.y = 100
        btn.fz.width = 200
        btn.fz.height = 50
        btn.fz.touchAreaEdge = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
        btn.setTitle("旋转当前图片", for: .normal)
        btn.addTarget(self, action: #selector(ImageColorViewController.btnClickAction(sender:)), for: .touchUpInside)
        
        btn.addTarget(self, action: #selector(forAllEvents(sender:)), for: .allEvents)

        btn.fz.addAction(block: { (button) in
            print("fz_addAction touchUpInside")
            btn.fz.showIndicator()
        })

        btn.fz.addAction(block: { (button) in
            print("fz_addAction touchUpInside repeat")
        })

        btn.fz.addAction(block: { (button) in
            print("touchUpOutside")
//            button.fz_removeAction(forEvent: .touchUpInside)
            btn.fz.hideIndicator()
        }, for: .touchUpOutside)
        
        btn.fz.addAction(block: { (button) in
            print("allEvents1")
        }, for: .allEvents)
                
        self.view.addSubview(btn)
        
        self.imageView = UIImageView()
        self.view.addSubview(imageView)
        
        self.cutImageView = UIImageView()
        self.view.addSubview(cutImageView)
        
        self.changeImageToShow(withImage: self.image)
    }
    
    
    @objc func btnClickAction(sender: Any){
        guard let image = self.image.fz.rotate(withRotation: rotation) else {
            return
        }
        rotation += 30
        
        self.changeImageToShow(withImage: image)
        
    }
    
    @objc func forAllEvents(sender: Any){
        print("allEvents2")
    }
    
    func changeImageToShow(withImage image: UIImage){
        imageView!.image = image
        imageView!.fz.size = image.size
        imageView!.fz.outerCenterX = self.view.fz.outerCenterX
        imageView!.fz.outerCenterY = self.view.fz.innerCenterY - 50
        
        let originSize = CGSize(width: 250, height: 200)
        guard let cutImage = image.fz.cut(withRect: CGRect(origin: CGPoint(x: (image.size.width - originSize.width) / 2.0, y: (image.size.height - originSize.height) / 2.0), size: originSize)) else {
            return
        }
        
        cutImageView!.image = cutImage
        cutImageView!.fz.size = cutImage.size
        cutImageView!.fz.outerCenterX = self.view.fz.outerCenterX
        cutImageView!.fz.y = view.fz.height - cutImageView.fz.height - 50
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
