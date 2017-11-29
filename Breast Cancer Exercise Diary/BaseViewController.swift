//
//  BaseViewController.swift
//  Breast Cancer Exercise Diary
//
//  Created by Victor Lesk on 10/11/2017.
//  Copyright © 2017 Digital Stitch. All rights reserved.
//

import UIKit
import vilcore

class BaseViewController: UIViewController {
    var titleView: UIView!
    var titleLabel: InsetLabel!
    var infoButton:UIButton!
    var backButton: UIButton!;

    var bannerView: UIView!
    var bannerLabel: InsetLabel!

    @IBOutlet weak var mainView:UIView!
    
    var appSection:AppSection = .physicalActivity;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        titleView = UIView(frame: CGRect(x:0,y:0,width:0,height:0));
        titleLabel = InsetLabel(frame: CGRect(x:0,y:0,width:0,height:0));
        bannerView = UIView(frame: CGRect(x:0,y:0,width:0,height:0));
        bannerLabel = InsetLabel(frame: CGRect(x:0,y:0,width:0,height:0));
        infoButton = UIButton(type: .infoLight);
        backButton = UIButton(frame: CGRect(x:0,y:0,width:0,height:0));
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);

        titleView = UIView(frame: CGRect(x:0,y:0,width:0,height:0));
        titleLabel = InsetLabel(frame: CGRect(x:0,y:0,width:0,height:0));
        bannerView = UIView(frame: CGRect(x:0,y:0,width:0,height:0));
        bannerLabel = InsetLabel(frame: CGRect(x:0,y:0,width:0,height:0));
        infoButton = UIButton(type: .infoLight);
        backButton = UIButton(frame: CGRect(x:0,y:0,width:0,height:0));
    }
    

    
    weak var introVc:IntroViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func willMove(toParentViewController _parent: UIViewController?) {
        super.willMove(toParentViewController: _parent);
        
        guard let _parent:IntroViewController = _parent as? IntroViewController else {return;}
        
        introVc = _parent;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);

        for v:UIView! in [titleView, bannerView]{
            view.addSubview(v);
        }
        
        for v:UIView! in [titleLabel, infoButton,backButton]{
            titleView.addSubview(v);
            titleView.bringSubview(toFront: v);
        }

        bannerView.addSubview(bannerLabel);
        
        for v:UIView! in [titleView,titleLabel, infoButton,backButton,bannerView,bannerLabel]{
            v.fillParent();
        }
        
        titleLabel.text = title;
        titleLabel.textAlignment = .center;
        titleLabel.font = UIFont.latoBold?.withSize(26);
        titleLabel.textColor = UIColor.black;
        titleLabel.setPadding(12);
        
        backButton.setTitle("<", for: .normal);
        backButton.setTitleColor(UIColor.black,for: .normal)
        backButton.titleLabel?.font = UIFont.latoBold?.withSize(22);
        
        for v:UIView! in [titleLabel,backButton,infoButton]{
            v.sizeToFit();
            infoButton.centreVerticallyIn(titleLabel);
        }

        titleLabel.stretchHorizontallyToFillParent();
        infoButton.alignParentRightBy(.moving,margin:8);
        backButton.centreVerticallyIn(titleLabel);
        backButton.alignParentLeftBy(.moving,margin:8);
        titleView.hugChildrenVertically();
        titleView.stretchHorizontallyToFillParent();
        titleView.alignParentTopBy(.moving,margin:20);

        bannerLabel.text = title;
        bannerLabel.textAlignment = .left;
        bannerLabel.font = UIFont.latoBold?.withSize(22);
        bannerLabel.backgroundColor = appSection.backgroundColor;
        bannerLabel.setPadding(8);
        bannerLabel.sizeToFit();
        bannerLabel.stretchHorizontallyToFillParent();
        bannerView.hugChildrenVertically();
        bannerView.moveToBelow(titleView);
        
        mainView.fillParentBelow(bannerView);
        
        backButton.addTarget(self, action:#selector(buttonHandler(_:)), for: .touchUpInside);
        infoButton.addTarget(self, action:#selector(buttonHandler(_:)), for: .touchUpInside);
        
        refreshViews();
    }
    
    func refreshViews(){
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @objc func buttonHandler(_ sender:UIView){
        if(sender == backButton){
            print("B");
        }else if(sender == infoButton){
                        print("I");
        }
        
    }
}
