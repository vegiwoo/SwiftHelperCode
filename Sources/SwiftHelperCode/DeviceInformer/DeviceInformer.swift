//  DeviceInformer.swift
//  Created by Dmitry Samartcev on 23.07.2020.

import Foundation

public class DeviceInformer {
    
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
    
    
}
