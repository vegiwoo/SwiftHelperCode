import XCTest
@testable import SwiftHelperCode

final class SwiftHelperCodeTests: XCTestCase {
    
    func testDiskSpacing() {
        do {
            // Get total disk space in bytes directly
            let totalDiskSpaceInBytes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())[FileAttributeKey.systemSize] as? Int64
            
            // Get total disk space in bytes from function
            let testTotalDiskSpaceInBytes = try UIDevice.current.diskSpacing(unit: .byte, numbOfDecimalPlaces: 0)
            
            // Testing
            if let testTotalDiskSpaceInBytesinInt64 = Int64(testTotalDiskSpaceInBytes.total.split(separator: " ").first!) {
                XCTAssertEqual(totalDiskSpaceInBytes, testTotalDiskSpaceInBytesinInt64)
            } else {
                XCTAssertThrowsError(NSError(domain: "SwiftHelperCode", code: 0, userInfo: ["Error" : "Error getting or converting disk space data"]))
            }
        } catch {
            XCTAssertThrowsError(error.localizedDescription)
        }
        
    }

    static var allTests = [
        ("testDiskSpacing", testDiskSpacing),
    ]
}
