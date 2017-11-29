//
//  ApexViewController.swift
//  Breast Cancer Exercise Diary
//
//  Created by Victor Lesk on 29/11/2017.
//  Copyright © 2017 Digital Stitch. All rights reserved.
//

import UIKit

class ApexViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @objc override func buttonHandler(_ sender:UIView){
        if(sender == backButton && introVc != nil){
            introVc?.revert();
        }else{
            super.buttonHandler(sender);
        }
        
    }
}
