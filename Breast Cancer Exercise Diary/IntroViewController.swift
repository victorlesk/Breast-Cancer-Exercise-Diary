//
//  IntroViewController.swift
//  Breast Cancer Exercise Diary
//
//  Created by Victor Lesk on 10/11/2017.
//  Copyright © 2017 Digital Stitch. All rights reserved.
//

import UIKit
import vilcore

class IntroViewController: UIViewController {

    @IBOutlet weak var titlePCLabel: InsetLabel!
    @IBOutlet weak var titlePALabel: InsetLabel!
    
    @IBOutlet weak var containerPCView: UIView!
    @IBOutlet weak var containerPAView: UIView!

//    var apexPCViewController:UIViewController?
//    var apexPAViewController:UIViewController?

    var titleLabels = [AppSection:InsetLabel]();
    var containerViews = [AppSection:UIView]();
    var apexControllers = [AppSection:ApexViewController]();
    var apexTitles = [AppSection.mobilisationAndStrengtheningExercises:"Mobandstren",AppSection.physicalActivity:"Physicalactexe"];

    var paTouchView : IntroControl?
    var pcTouchView : IntroControl?
    var div :UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titlePCLabel.text = NSLocalizedString("pcintrotitle",comment:"");
        titlePALabel.text = NSLocalizedString("paintrotitle",comment:"");
        
        for l:InsetLabel! in [titlePALabel,titlePCLabel]{
            l.font = UIFont.latoHeavy!.withSize(36);
            l.textColor = UIColor.diaBlack;
            l.textAlignment = .center;
            l.isUserInteractionEnabled = true;
        }
        
        titlePCLabel.backgroundColor = UIColor.pinkbg;
        titlePALabel.backgroundColor = UIColor.cyanbg;
        
        titleLabels  = [.mobilisationAndStrengtheningExercises:titlePCLabel,.physicalActivity:titlePALabel];
        containerViews = [.mobilisationAndStrengtheningExercises:containerPCView,.physicalActivity:containerPAView];
        
        for appSection:AppSection in [.mobilisationAndStrengtheningExercises,.physicalActivity]{

            guard let vc = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "apex") as? ApexViewController else {continue;}

            vc.appSection = appSection;
            vc.title = NSLocalizedString(apexTitles[appSection] ?? "", comment:"");
            apexControllers[appSection] = vc;
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        for l:InsetLabel! in [titlePALabel,titlePCLabel]{

            l.setPadding(view.frame.width * 0.1);
            
            l.fillParent();
            l.sizeToFit();
            l.fillParent();
            l.setHeightOfParent(0.5);
        }
        titlePALabel.moveToBelow(titlePCLabel);
        
        div = UIView(frame:CGRect());
        view.addSubview(div!);
        div!.backgroundColor = UIColor.diaBlack;
        div!.stretchHorizontallyToFillParent();
        div!.setHeight(1.0);
        div!.centreInParent();

        paTouchView = IntroControl(frame:CGRect(),direction:.down);
        pcTouchView = IntroControl(frame:CGRect(),direction:.up);

        titlePALabel.addSubview(paTouchView!);
        titlePCLabel.addSubview(pcTouchView!);

        for i:IntroControl! in [paTouchView, pcTouchView]{
            i.backgroundColor = UIColor.clear;
            i.setWidthOfParent(0.3);
            i.setHeightToWidth(0.5);
            i.centreHorizontallyInParent();
            i.isUserInteractionEnabled = true;
            i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(controlHandler(_:))));
        }
        
        pcTouchView!.alignParentBottomBy(.moving);
        paTouchView!.alignParentTopBy(.moving);
        
        containerPCView.fill(titlePCLabel);
        containerPAView.fill(titlePALabel);
        
        fadeIn();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Execute revert to closed stated
    func revert(){
        UIView.animate(withDuration: 0.3, delay:0.0,options:.curveEaseOut, animations: {
            self.titlePALabel.alignParentBottomBy(.moving);
            self.titlePCLabel.alignParentTopBy(.moving);
        });
    }
    
    // MARK: Interaction handlers
    @objc func controlHandler(_ _gesture:UIGestureRecognizer){
        guard let v = _gesture.view else {return;}

        let chosenSection:AppSection = (v.superview == titlePCLabel ? .mobilisationAndStrengtheningExercises : .physicalActivity);
        
        guard let newVc = self.apexControllers[chosenSection] else {return;}
        
        self.addChildViewController(newVc);
        newVc.view.frame = self.view.frame;
        self.view.addSubview(newVc.view);
        self.view.bringSubview(toFront: newVc.view);
        for (_,i) in self.titleLabels{
            self.view.bringSubview(toFront: i);
        }
        
        UIView.animate(withDuration: 0.3, delay:0.0,options:.curveEaseOut, animations: {
            self.titleLabels[chosenSection]!.banishVertically();
        }, completion: {
            (complete) in
            self.div?.alpha = 0.0;

            UIView.animate(withDuration: 0.5, delay:0.0, options:.curveEaseIn, animations: {
                (self.titleLabels[chosenSection.otherSection])!.banishVertically();
            });
        });
        
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
