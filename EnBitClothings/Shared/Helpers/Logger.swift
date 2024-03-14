//
//  Logger.swift
//  EnBitClothings
//
//  Created by Yashmi Aruksha on 2024-03-13.
//

import Foundation

enum LogType: String{
case error
case warning
case success
case info
case action
case canceled
}

class Logger{

 static func log( logType:LogType, message:String){
        switch logType {
        case LogType.error:
            print("\n❤️Error-------------------------------------------❤️\n\(message)\n❤️-------------------------------------------❤️")
            
        case LogType.warning:
            print("\n📙 Warning: \(message)\n")
            
        case LogType.success:
            print("\n💚Success-------------------------------------------💚\n\(message)\n💚-------------------------------------------💚")
            
        case LogType.info:
            print("\n📘Info-------------------------------------------💚\n\(message)\n📘-------------------------------------------💚")
            
        case LogType.action:
            print("\n📘 Action: \(message)\n")
            
        case LogType.canceled:
            print("\n📓 Cancelled: \(message)\n")
        }
    }

}

