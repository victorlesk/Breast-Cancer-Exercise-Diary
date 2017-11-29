//
//  Auxiliary.swift
//  Breast Cancer Exercise Diary
//
//  Created by Victor Lesk on 29/11/2017.
//  Copyright © 2017 Digital Stitch. All rights reserved.
//

import Foundation
import UIKit

enum AppSection{
    case mobilisationAndStrengtheningExercises;
    case physicalActivity;
    
    var backgroundColor:UIColor {
        switch (self){
        case .mobilisationAndStrengtheningExercises:
            return UIColor.pinkbg;
        case .physicalActivity:
            return UIColor.cyanbg;
        }}
    var darkTextColor:UIColor {
        switch (self){
        case .mobilisationAndStrengtheningExercises:
            return UIColor.darkpink;
        case .physicalActivity:
            return UIColor.darkcyan;
        }}
    
    var otherSection:AppSection{
        switch (self){
        case .mobilisationAndStrengtheningExercises:
            return .physicalActivity;
        case .physicalActivity:
            return .mobilisationAndStrengtheningExercises;
        }}
};
