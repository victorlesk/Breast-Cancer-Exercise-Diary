//
//  Indexing.swift
//  Breast Cancer Exercise Diary
//
//  Created by Victor Lesk on 10/11/2017.
//  Copyright © 2017 Digital Stitch. All rights reserved.
//

import Foundation
//
//  Indexing.swift
//  Chemo Diary II
//
//  Created by Victor Lesk on 07/11/2017.
//  Copyright © 2017 Digital Stitch. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices

class Indexing{
    
    public static func updateSpotlightIndex(){
        /*
        CSSearchableIndex.default().deleteSearchableItems(withDomainIdentifiers: ["chemo"], completionHandler:  { (error) in
            if(nil != error ){NSLog("Error removing core spotlight items: %@",error!.localizedDescription);}
            else{
                let domainPrefix = Bundle.main.bundleIdentifier!
                
                for (key,title,text) in [("inputsideeffects","Record Chemo Side Effects","Record daily side effects and symptoms associated with your treatment")
                    ]{
                        
                        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeData as String);
                        
                        // Add metadata that supplies details about the item.
                        
                        attributeSet.title = NSLocalizedString(title,comment:"");
                        attributeSet.contentDescription = NSLocalizedString(text,comment:"");
                        //        attributeSet.thumbnailData  =
                        
                        // Create an item with a unique identifier, a domain identifier, and the attribute set you created earlier.
                        let item = CSSearchableItem(uniqueIdentifier: "\(domainPrefix).\(key)", domainIdentifier: "chemo", attributeSet: attributeSet)
                        
                        // Add the item to the on-device index.
                        CSSearchableIndex.default().indexSearchableItems([item]) { error in
                            if error != nil {
                                if(nil != error ){NSLog("Error removing core spotlight items: %@",error!.localizedDescription);}
                            }
                        }
                }
            }
        });*/
        
        
    }
    
    public static func updateNativeSearchIndex(){
        /*
        SearchNode.index.removeAll();
        
        SearchNode.index.append(SearchNode(text: "Chemo cycles", page: "cyclessummary"));
        SearchNode.index.append(SearchNode(text: "Notes", page: "cyclessummary"));
        SearchNode.index.append(SearchNode(text: "Send report", page: "cyclessummary"));
        
        for catKey in Link.sortedLinkCatKeys(){
            guard let linkCat = Link.lookUp(linkCat: catKey), let linkName = linkCat.name else {continue;}
            
            SearchNode.index.append(SearchNode(text: NSLocalizedString(linkName,comment:""), page:"linksandnumbers", section:catKey));
        }
 */
        
    }
    
}
