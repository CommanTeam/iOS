//
//  NetworkModel.swift
//  Comman
//
//  Created by 김지우 on 2018. 1. 8..
//  Copyright © 2018년 havetherain. All rights reserved.
//

import Foundation

class NetworkModel {
    var view : NetworkCallback

    init(_ vc : NetworkCallback){
        self.view = vc
    }
    
    let baseURL = "http://comman.cf"
}
