//
//  Device.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/24/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

enum DeviceType: Int {
    case unknownGroup = 0//"Unknown Group"
    case temperatureHumiditySensor = 2//"Temperature - Humidity sensor"
    case lightSwitch = 1//"Light Switch"
    case doorLockSensor = 3//"Door lock sensor"
    case rainDetectSensor = 4//"Rain detect sensor"
    case curtainControl = 5//"Curtain control"
    case smokeSensor = 6//"Smoke sensor"
    case motionDetectSensor = 7 //"Motion detect sensor"
    case iRDevice = 8//"IR Devices"
    case mce = 9//"MCE"
    case apollo = 10//"Apollo"
    case gwV2 = 11//"GW V2"
    case wifiSocket = 12//"Wifi Socket"
}
