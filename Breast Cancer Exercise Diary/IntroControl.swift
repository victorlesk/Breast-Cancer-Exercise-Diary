//
//  IntroControl.swift
//  Breast Cancer Exercise Diary
//
//  Created by Victor Lesk on 10/11/2017.
//  Copyright © 2017 Digital Stitch. All rights reserved.
//

import UIKit

class IntroControl: UIView {
    public let normalColor:UIColor = UIColor.diaBlack;
    public let touchDownColor:UIColor = UIColor.diaWhite;
    public var paintColor: UIColor ;
    
    public enum Direction {
        case up;
        case down;
    };
    
    public var direction = Direction.up;
    
    public init(frame: CGRect,direction _direction:Direction) {
        paintColor = normalColor;
        direction = _direction;
        super.init(frame:frame);
    }

    public required init?(coder aDecoder: NSCoder) {
        paintColor = normalColor;
        super.init(coder:aDecoder);

    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        paintColor = touchDownColor;
        
        setNeedsDisplay();
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        paintColor = normalColor;
        setNeedsDisplay();
    }
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        paintColor = normalColor;
        setNeedsDisplay();
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {return;}
        
        context.setStrokeColor(paintColor.cgColor);
        context.setLineWidth(7.0);

        let r:CGFloat    = rect.height * 0.9;
        let midX:CGFloat = rect.width / 2.0;
        let midY:CGFloat = rect.height / 2.0;
        
        let m:CGFloat = (direction == .up ? -1.0 : 1.0);
        let a:CGFloat = (direction == .up ? .pi : 0.0);
        
        context.move(to:CGPoint(x:midX,y: midY + m * midY));

        context.beginPath();
        context.addArc(center: CGPoint(x:midX,y:midY - m * midY) , radius: r, startAngle: a, endAngle: a + .pi, clockwise: false);

        context.strokePath();
        
        context.setLineCap(.butt);
        
        context.move(to:CGPoint(x:midX + 0.3 * midX,y: midY - 0.1 * m * midY));
        context.addLine(to:CGPoint(x:midX,y: midY + 0.2 * m * midY));
        context.addLine(to:CGPoint(x:midX - 0.3 * midX,y: midY - 0.1 * m * midY));
        context.strokePath();
    }

}

