//
//  UserData.swift
//  Breast Cancer Exercise Diary
//
//  Created by Victor Lesk on 10/11/2017.
//  Copyright © 2017 Digital Stitch. All rights reserved.
//

import Foundation

class PersonalData:XMLSerializable{
    var name:String? = "Victor Lesk";
    var phone:String? = "";
    var email:String? = "";
    var dateOfBirth:Date? = "09/07/74 1300".DDMMYYTTDate();
    var gender:String? = "m";
    var hospitalNumber:String? = "HS123";
    
    let XMLName:String = "personaldata";
    var version:Int = 0;
    static let writeVersion = 0;
    
    override func XMLElementString(indent:String)->String{
        let nmxml   = (nil != name ? "\(indent) <name><![CDATA[\(name!)]]></name>\n" : "");
        let dobxml  = (nil != dateOfBirth ? "\(indent) <dob val=\"\(dateOfBirth!.DDMMYYString())\" />\n" : "");
        let genxml  = (nil != gender ? "\(indent) <gender val=\"\(gender!)\" />\n" : "");
        let hospxml = (nil != hospitalNumber ?"\(indent) <hospnum val=\"\(hospitalNumber!)\" />\n" : "");
        let emxml   = (nil != email ? "\(indent) <email><![CDATA[\(email!)]]></email>\n" : "");
        let phxml   = (nil != phone ? "\(indent) <phone><![CDATA[\(phone!)]]></phone>\n" : "");
        
        let result = "\(indent)<\(XMLName) v=\"\(version)\">\n\(nmxml)\(dobxml)\(genxml)\(hospxml)\(emxml)\(phxml)\(indent)</\(XMLName)>";
        
        return result;
    }
    
    override init(){super.init();}
    
    required init?(xmlElement _xmlElement:GDataXMLElement){
        guard let versionAttr = attrforxpath(".", root: _xmlElement, attr: "v"), let versionIntAttr = Int(versionAttr), PersonalData.writeVersion >= versionIntAttr else {return nil;}
        version = versionIntAttr;
        
        name  = textforxpath("./name" , root: _xmlElement);
        email = textforxpath("./email", root: _xmlElement);
        phone = textforxpath("./phone", root: _xmlElement);
        
        if let dobAttr = attrforxpath("./dob", root: _xmlElement, attr: "val") {
            guard let dobDateAttr = dobAttr.DDMMYYDate() else {return nil;};
            dateOfBirth = dobDateAttr;
        }
        
        gender = attrforxpath("./gender", root: _xmlElement, attr: "val");
        hospitalNumber = attrforxpath("./hospnum", root: _xmlElement, attr: "val");
        
        super.init();
    }
    
}

class SettingsData:XMLSerializable{
    var colourScheme:String = "gyorb";
    var tableOrientation:String = "h";
    
    let XMLName:String = "settingsdata";
    var version:Int = 0;
    static let writeVersion = 1;
    
    static let validTableOrientations = ["h","v"];
    
    override func XMLElementString(indent:String)->String{
        let csxml   = "\(indent) <cs val=\"\(colourScheme)\"/>\n";
        
        let toxml   = "\(indent) <to val=\"\(tableOrientation)\"/>\n";
        
        let result = "\(indent)<\(XMLName) v=\"\(version)\">\n\(csxml)\(toxml)\(indent)</\(XMLName)>";
        
        return result;
    }
    
    override init(){super.init();}
    
    required init?(xmlElement _xmlElement:GDataXMLElement){
        guard let versionAttr = attrforxpath(".", root: _xmlElement, attr: "v"), let versionIntAttr = Int(versionAttr), SettingsData.writeVersion >= versionIntAttr else {return nil;}
        version = versionIntAttr;
        
        if(version < 1){
            tableOrientation = "h";
        }else{
            guard let toAttr = attrforxpath("./to", root: _xmlElement, attr: "val"), SettingsData.validTableOrientations.contains(toAttr) else {return nil;}
            tableOrientation = toAttr;
        }
        
        guard let csAttr = attrforxpath("./cs", root: _xmlElement, attr: "val") else {return nil;}
        colourScheme = csAttr;
        
        version = SettingsData.writeVersion;
        
        super.init();
    }
    
}

class MeasurementsRecord :XMLSerializable{
    var weightString:String;
    var kgWeight:Double = -1 {
        didSet{
            recalculateBMIBSA();
        }
    };
    
    var heightString:String;
    var cmHeight:Double = -1 {
        didSet{
            recalculateBMIBSA();
        }
    };
    
    var bmi:Double = -1;
    var bsa:Double = -1;
    
    var recordDate:Date?
    
    let XMLName:String = "mrec";
    var version:Int = 0;
    static let writeVersion = 0;
    
    override func XMLElementString(indent:String)->String{
        let rdxml = (nil != recordDate ? " rd=\"\(recordDate!.DDMMYYString())\"" : "");
        
        return "\(indent)<\(XMLName) v=\"\(version)\"\(rdxml) wt=\"\(weightString)\" kgwt=\"\(kgWeight)\" ht=\"\(heightString)\" cmht=\"\(cmHeight)\" bmi=\"\(bmi)\" bsa=\"\(bsa)\" />";
    }
    
    init?(weight:String, height:String, date _recordDate:Date?){
        weightString = weight.trim();
        heightString = height.trim();
        
        super.init();
        
        guard let wtWords = weightString.split(" ") else {return nil;}
        guard let htWords = heightString.split(" ") else {return nil;}
        
        guard let wtFloat = Double(wtWords[0]) else {return nil;}
        guard let htFloat = Double(htWords[0]) else {return nil;}
        
        if(wtWords.count > 0){
            kgWeight = wtFloat * (["kg":1.0, "lb":0.453592][wtWords[1]] ?? 1.0);
        }else { kgWeight = wtFloat; }
        if(htWords.count > 0){
            cmHeight = htFloat * (["cm":1.0,"in":2.54][htWords[1]] ?? 1.0);
        }else { cmHeight = htFloat; }
        
        recordDate = _recordDate;
    }
    
    func setHeightFromString(_ _heightString:String){
        heightString = _heightString.trim();
        
        guard let htWords = heightString.split(" ") else {return;}
        guard let htFloat = Double(htWords[0]) else {return;}
        
        if(htWords.count > 0){
            cmHeight = htFloat * (["cm":1.0,"in":2.54][htWords[1]] ?? 1.0);
        }else { cmHeight = htFloat; }
        
    }
    
    func setWeightFromString(_ _weightString:String){
        weightString = _weightString.trim();
        
        guard let wtWords = weightString.split(" ") else {return;}
        guard let wtFloat = Double(wtWords[0]) else {return ;}
        
        if(wtWords.count > 0){
            kgWeight = wtFloat * (["kg":1.0, "lb":0.453592][wtWords[1]] ?? 1.0);
        }else { kgWeight = wtFloat; }
    }
    
    private func recalculateBMIBSA(){
        if(cmHeight == -1 || kgWeight == -1){
            bmi = -1;
            bsa = -1;
        }else{
            bmi = 10000.0 * kgWeight / (cmHeight * cmHeight);
            bsa = sqrt(abs(kgWeight * cmHeight)) / 60.0;
        }
    }
    
    required init?(xmlElement _xmlElement:GDataXMLElement){
        guard let versionAttr = attrforxpath(".", root: _xmlElement, attr: "v"), let versionIntAttr = Int(versionAttr), MeasurementsRecord.writeVersion >= versionIntAttr else {return nil;}
        version = versionIntAttr;
        
        if let kgwtAttr = doubleattrforxpath(".", root: _xmlElement, attr: "kgwt") { kgWeight = kgwtAttr; }
        if let cmhtAttr = doubleattrforxpath(".", root: _xmlElement, attr: "cmht") { cmHeight = cmhtAttr; }
        
        guard let wtAttr = attrforxpath(".", root: _xmlElement, attr: "wt") else {return nil;}
        guard let htAttr = attrforxpath(".", root: _xmlElement, attr: "ht") else {return nil;}
        weightString = String(wtAttr);
        heightString = String(htAttr);
        
        if let bsaAttr = doubleattrforxpath(".", root: _xmlElement, attr: "bsa") { bsa = bsaAttr; }
        if let bmiAttr = doubleattrforxpath(".", root: _xmlElement, attr: "bmi") { bmi = bmiAttr; }
        
        if let rdAttr = attrforxpath(".", root: _xmlElement, attr: "rd") {
            guard let rdDateAttr = rdAttr.DDMMYYDate() else {return nil;}
            recordDate = rdDateAttr;
        }
        
        super.init();
        
        print(XMLString());
    }
}

class UserData:XMLSerializable{
    var personalData:PersonalData = PersonalData();

    var measurementsRecords = [MeasurementsRecord]();
    
    var settingsData:SettingsData = SettingsData();
    
    
    let XMLName:String = "userdata";

    var version:Int = 0;
    static let writeVersion = 0;
    
    var mostRecentMeasurementsDate:Date?{
        var result:Date?;
        
        for mRecord in measurementsRecords{
            guard let date = mRecord.recordDate else {continue;}
            
            if(nil == result){result = date;}
            else if(result!.daysIntervalSinceDate(date) >= 0){
                result = date;
            }
        }
        
        return result;
    }
    
    override func XMLElementString(indent:String)->String{
        var result = "<\(XMLName) v=\"\(version)\">\n <mrecs>\n";
        
        for measurementsRecord in measurementsRecords{
            result = "\(result)\(measurementsRecord.XMLElementString(indent:"  "))\n"
        }
        
        result = "\(result) </mrecs>\n\(personalData.XMLElementString(indent: " "))\n\(settingsData.XMLElementString(indent: " "))\n";
        
        return "\(result)</\(XMLName)>";
    }
    
    func write(){
        print(XMLString());
        
        UserDefaults.standard.set(XMLString(), forKey:"userdata");
        UserDefaults.standard.synchronize();
    }
    
    required init?(xmlElement _xmlElement:GDataXMLElement){
        print(_xmlElement);
        guard let versionAttr = attrforxpath(".", root: _xmlElement, attr: "v"), let versionIntAttr = Int(versionAttr), UserData.writeVersion >= versionIntAttr else {return nil;}
        version = versionIntAttr;
        
        guard let pdElem = elemforxpath("./personaldata", root: _xmlElement), let pdData = PersonalData(xmlElement:pdElem) else {return nil;}
        personalData = pdData;
        
        if let stElem = elemforxpath("./settingsdata", root: _xmlElement), let stData = SettingsData(xmlElement:stElem){
            settingsData = stData;
        }
        
        guard let measurementsRecordElems = elemsforxpath("./mrecs/mrec", root: _xmlElement) else {return nil;}
        
        for measurementsRecordElem in measurementsRecordElems{
            guard let measurementsRecordElem = measurementsRecordElem as? GDataXMLElement, let mrData = MeasurementsRecord(xmlElement: measurementsRecordElem) else {return nil;}
            measurementsRecords.append(mrData);
            }
        
        super.init();
        print(XMLString());
    }
    
    func lookUpMeasurementsRecord(day _date:Date)->MeasurementsRecord?{
        var result:MeasurementsRecord?;
        
        for mrItem in measurementsRecords{
            if(mrItem.recordDate?.DDMMYYString() == _date.DDMMYYString()){
                result = mrItem;
                break;
            }
        }
        
        return result;
    }
    
}
