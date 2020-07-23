//  DeviceInformer.swift
//  Created by Dmitry Samartcev on 23.07.2020.

import Foundation
#if os(iOS)
import UIKit
#endif

public struct DeviceInformer {
    
    public init() {}

    // MARK: Public functions
    /// Provides information about disk space on current device.
    /// - Parameters:
    ///   - unit: Unit for output values.
    ///   - numbOfDecimalPlaces: Number of decimal places for output values.
    /// - Throws: Error of type DeviceInformerError.
    /// - Returns: Returns total / free / used amount of disk space.
    /// - Remark: Wrapper for private func getDiskSpacing(unit:,numbOfDecimalPlaces:)
    public func diskSpacing(unit: UnitInformation, numbOfDecimalPlaces: Int) throws -> (total: String, free: String, used: String) {
        do {
            return try self.getDiskSpacing(unit: unit, numbOfDecimalPlaces: numbOfDecimalPlaces)
        }
        catch {
            throw error
        }
    }
    
    /// Provides model name of current device.
    /// - Returns: Device model name as string.
    public func deviceModelName () -> String {
        return getModelName()
    }
    
    /// Returns the current physical memory for device.
    /// - Parameters:
    ///   - unit: Unit for output value.
    ///   - numbOfDecimalPlaces: Number of decimal places for output value.
    /// - Returns: Current physical memory value as a string indicating the output units.
    public func devicePhysicalMemory (unit: UnitInformation, numbOfDecimalPlaces: Int) -> String {
        let physicalMemory = Int64(ProcessInfo.processInfo.physicalMemory)
        return self.outputValueFormat(value: physicalMemory, unit: unit, numbOfDecimalPlaces: numbOfDecimalPlaces)
    }
    
    /// Returns current IsLowPowerModeEnabled value for device.
    /// - Returns: Boolean flag for performing operation.
    public func deviceIsLowPowerModeEnabled () throws -> Bool {
        #if os(iOS)
        return ProcessInfo.processInfo.isLowPowerModeEnabled
        #else
        throw SHCErrors.DeviceInformerError.requestIsAvailableOnlyForDevicesSupportingIOS
        #endif
    }
    
    /// Returns battery state and battery level for the device.
    /// - Throws: Error of type DeviceInformerError.
    /// - Returns: Battery state and battery level values as a tuple of strings.
    public func deviceBatteryStateAndLevel () throws -> (batteryState: String, batteryLevel: String) {
        #if os(iOS)
        defer {
            UIDevice.current.isBatteryMonitoringEnabled = false
        }
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        let batteryState: String!
        
        switch UIDevice.current.batteryState {
        case .unknown:
            batteryState = "Unknown"
        case .unplugged:
            batteryState = "Unplugged"
        case .charging:
            batteryState = "Charging"
        case .full:
            batteryState = "Full"
        @unknown default:
            batteryState = "Unknown"
        }

        return (batteryState, "\(String(format: "%.2",  UIDevice.current.batteryLevel)) %")
        #else
        throw SHCErrors.DeviceInformerError.requestIsAvailableOnlyForDevicesSupportingIOS
        #endif
    }

    // MARK: Private functions
    /// Formats value according to suggested conditions.
    /// - Parameters:
    ///   - value: Input value to format.
    ///   - unit: Unit of information for output value.
    ///   - numbOfDecimalPlaces: Required number of decimal places in output value.
    /// - Returns: A string of formatted output value (optional).
    private func outputValueFormat(value: Int64, unit: UnitInformation, numbOfDecimalPlaces: Int) -> String {

        let value = Double(value)
        let format = "%.\(numbOfDecimalPlaces)f"

        switch unit {
        case .byte:
            let outputValue = String(format: format, value)
            return "\(outputValue) bytes"
        case .kbyte:
            let outputValue = String(format: format, value / 1000)
            return "\(outputValue) kilobytes"
        case .mbyte:
            let outputValue = String(format: format, value / 1000000)
            return "\(outputValue) megabytes"
        case .gbyte:
            let outputValue = String(format: format, value / 1000000000)
            return "\(outputValue) gigabytes"
        }
    }

    private func getDiskSpacing(unit: UnitInformation, numbOfDecimalPlaces: Int) throws -> (total: String, free: String, used: String) {
        guard
            let totalDiskSpaceInBytes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())[FileAttributeKey.systemSize] as? Int64,
            let totalDiskFreeSpaceInBytes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())[FileAttributeKey.systemFreeSize] as? Int64
            else {
            throw SHCErrors.DeviceInformerError.unableToCalculateDiskSpace
        }

        let totalDiskSpace = outputValueFormat(value: totalDiskSpaceInBytes, unit: unit, numbOfDecimalPlaces: numbOfDecimalPlaces)
        let totalDiskFreeSpace = outputValueFormat(value: totalDiskFreeSpaceInBytes, unit: unit, numbOfDecimalPlaces: numbOfDecimalPlaces)
        let usedDiskSpace = outputValueFormat(value: totalDiskSpaceInBytes - totalDiskFreeSpaceInBytes, unit: unit, numbOfDecimalPlaces: numbOfDecimalPlaces)

        return (totalDiskSpace, totalDiskFreeSpace, usedDiskSpace)
    }
    
    private func getModelName() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd generation)"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #else
            return "Unknown"
            #endif
        }

        return mapToDevice(identifier: identifier)
    }

}
