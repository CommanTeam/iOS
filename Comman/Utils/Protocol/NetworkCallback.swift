//
//  NetworkCallback.swift
//  Comman
//
//  Created by 김지우 on 2017. 12. 31..
//  Copyright © 2017년 havetherain. All rights reserved.
//

protocol NetworkCallback {
    func networkResult(resultData:Any, code:String)
    func networkFailed()
}
