//
//  ImageViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2018/8/30.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class ImageViewController: UIViewController {

    @IBOutlet weak var testImageView: UIImageView!

    lazy var myImageView = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535603627176&di=7306e64883f758f4a7f138ac5e4ab0bd&imgtype=0&src=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Farchive%2F763293ce06bf1e684ef0ea3da43ae5008d8564b8.jpg")

        testImageView.kf.setImage(with: url);


        self.view.addSubview(myImageView);

        myImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(200)
            make.center.equalTo(self.view)
        }

        myImageView.kf.setImage(with: url);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
