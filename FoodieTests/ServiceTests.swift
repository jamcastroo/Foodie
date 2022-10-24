//
//  ServiceTests.swift
//  FoodieTests
//
//  Created by Jamile Castro on 20/10/22.
//

import XCTest
@testable import Foodie

class ServiceTests: XCTestCase {
    var sut: FreeMealDBService!
    let fakeURL = URL(string: "https://www.fake.com/text.txt")!

    override func setUpWithError() throws {
        sut = FreeMealDBService()
    }

    override func tearDownWithError() throws {
        guard let path = sut.createPath(for: fakeURL) else { return }
        try FileManager.default.removeItem(at: path)
        sut = nil
    }

    func test_save_data() {
        guard let path = sut.createPath(for: fakeURL), let fakeData = "fake".data(using: .utf8) else {
            XCTFail("Deveria funcionar")
            return
        }
        sut.saveToFileManager(data: fakeData, fileURL: fakeURL)
        XCTAssertTrue(FileManager.default.fileExists(atPath: path.path))
    }

    func test_retrieve_data() {
        guard let fakeData = "fake".data(using: .utf8) else {
            XCTFail("Deveria funcionar")
            return
        }
        sut.saveToFileManager(data: fakeData, fileURL: fakeURL)
        XCTAssertNotNil(sut.retrieveFromFileManager(fileURL: fakeURL))
    }
}
