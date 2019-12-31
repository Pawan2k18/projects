//
//  RealmHelper.swift
//  Travanada2
//
//  Created by Pawan Dey on 29/08/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import Foundation
import RealmSwift

func getRealm(completion  :  @escaping (Realm) -> Void){
    
    do{
        let realm = try Realm()
        completion(realm)
    }catch{
        print(error)
    }
    
}
