//
//  WalkaboutTests.swift
//  WalkaboutTests
//
//  Created by Saurabh Khawase on 29.03.19.
//  Copyright © 2019 de.shunya. All rights reserved.
//

import XCTest
import Quick
import Nimble

class WalkaboutTests: QuickSpec {
    private let jsonData = """
                    {
                      "photos": {
                        "page": 1,
                        "pages": "733078",
                        "perpage": 1,
                        "photo": [
                          {
                            "farm": 8,
                            "id": "33596152888",
                            "isfamily": 0,
                            "isfriend": 0,
                            "ispublic": 1,
                            "owner": "48708043@N00",
                            "secret": "dd3a574ddb",
                            "server": "7819",
                            "title": "Blue In The Face"
                          }
                        ],
                        "total": "733078"
                      },
                      "stat": "ok"
                    }
                   """.data(using: .utf8)
    override func spec() {
        context("Test for JSON Parsing") {
            describe("This group tests the model parsing", closure: {
                it("should parse the data correctly", closure: {
                    // targetUrl is in format: https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg 
                    let targetUrl = "https://farm8.staticflickr.com/7819/33596152888_dd3a574ddb_c.jpg"
                    if let jData = self.jsonData,
                        let response = try? JSONDecoder().decode(Response.self, from:jData) {
                        expect(response).toNot(beNil())
                        expect(response.photos.first?.photoUrl).to(equal(targetUrl))
                    } else {
                        fail("photo can't be parsed")
                    }
                })
            })
        }
    }

}
