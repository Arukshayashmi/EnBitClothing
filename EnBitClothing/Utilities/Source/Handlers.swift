//
//  Handlers.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation

public typealias iBSActionHandler = (_ status: Bool, _ message: String) -> ()
public typealias iBSCompletionHandler = (_ status: Bool, _ code: Int, _ message: String) -> ()
public typealias iBSCompletionHandlerWithData = (_ status: Bool, _ code: Int, _ message: String, _ data: Any?) -> ()

public typealias CompletionHandlerBaseVM = (_ status: Bool, _ code: Int, _ message: String) -> ()
public typealias CompletionHandler = (_ status: Bool, _ message: String) -> ()
