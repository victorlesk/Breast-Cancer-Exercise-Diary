//
//  XMLFuncs.swift
//  Chemo Diary II
//
//  Created by Victor Lesk on 07/07/2017.
//  Copyright © 2017 Digital Stitch. All rights reserved.
//

import Foundation

func elemsforxpath(_ s:String,root:GDataXMLElement?)->[AnyObject]? {guard let elements = try! root?.nodes(forXPath: s) else {return nil;}
    return elements as [AnyObject]?};

func elemforxpath(_ s:String,i:Int,root:GDataXMLElement?)->GDataXMLElement? {guard let elements = elemsforxpath(s, root: root), elements.count > i else {return nil;}
    return (elements[i] as? GDataXMLElement);}

func elemforxpath(_ s:String,root:GDataXMLElement)->GDataXMLElement? {return elemforxpath(s,i:0,root:root);}

func textforxpath(_ s:String,i:Int,root:GDataXMLElement?)->String? {guard let elements = try! root?.nodes(forXPath: s), elements.count > i else {return nil;}
    return (elements[i] as? GDataXMLElement)?.stringValue();}

func textforxpath(_ s:String,root:GDataXMLElement)->String? {return textforxpath(s,i:0,root:root);}

func attrforxpath(_ s:String,i:Int,root:GDataXMLElement?,attr:String)->String? {guard let elements = try! root?.nodes(forXPath: s), elements.count > i else {return nil;}
    return (elements[i] as? GDataXMLElement)?.attribute(forName: attr)?.stringValue();}

func attrforxpath(_ s:String,root:GDataXMLElement,attr:String)->String? {return attrforxpath(s,i:0,root:root,attr:attr);}

func rootelement(xmlString _xmlString:String,tagName _tagName:String)->(GDataXMLDocument?,GDataXMLElement?)?{
    do{
        let doc = try GDataXMLDocument(xmlString: _xmlString, options: 0);

        let root = try doc.nodes(forXPath:"/\(_tagName)");

        if(root.count > 0){
            return (doc,root[0] as? GDataXMLElement);
        }else { return nil;}
    }catch{
        return nil;
    }
}

class XMLSerializable{
    public convenience init?(xmlString _xmlString:String,tagName:String) {
        guard let (doc,root) = rootelement(xmlString:_xmlString, tagName:tagName), let _ = doc, let rootElement = root else {return nil;}

        self.init(xmlElement:rootElement);
    }

    public convenience init?(xmlString _xmlString:String) {
        guard let (doc,root) = rootelement(xmlString:_xmlString, tagName:"*"), let _ = doc, let rootElement = root else {return nil;}

        self.init(xmlElement:rootElement);
    }
    
    public required init?(xmlElement _xmlElement:GDataXMLElement){
    }
    
    public init(){}
    
    public func XMLElementString(indent:String)->String{return ""}
    public func XMLElementString()->String{return XMLElementString(indent:"");}
    public func XMLString()->String{return String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n%@",XMLElementString(indent:""));}
    
}
