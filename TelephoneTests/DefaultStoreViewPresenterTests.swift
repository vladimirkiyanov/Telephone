//
//  DefaultStoreViewPresenterTests.swift
//  Telephone
//
//  Copyright (c) 2008-2016 Alexey Kuznetsov
//  Copyright (c) 2016 64 Characters
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import XCTest

final class DefaultStoreViewPresenterTests: XCTestCase {
    fileprivate var output: StoreViewSpy!
    fileprivate var sut: DefaultStoreViewPresenter!

    override func setUp() {
        super.setUp()
        output = StoreViewSpy()
        sut = DefaultStoreViewPresenter(output: output)
    }

    // MARK: - Purchase check

    func testShowsPurchaseCheckProgressOnShowPurchaseCheckProgress() {
        sut.showPurchaseCheckProgress()

        XCTAssertTrue(output.didCallShowPurchaseCheckProgress)
    }

    func testDisablesPurchaseRestorationOnShowPurchaseCheckProgress() {
        sut.showPurchaseCheckProgress()

        XCTAssertTrue(output.didCallDisablePurchaseRestoration)
    }

    // MARK: - Fetch

    func testShowsProductsSortedByPriceOnShowProducts() {
        let product1 = Product(identifier: "123", name: "abc", price: NSDecimalNumber(string: "3"), localizedPrice: "$3")
        let product2 = Product(identifier: "456", name: "def", price: NSDecimalNumber(string: "1"), localizedPrice: "$1")
        let product3 = Product(identifier: "789", name: "ghi", price: NSDecimalNumber(string: "2"), localizedPrice: "$2")

        sut.showProducts([product1, product2, product3])

        XCTAssertEqual(
            output.invokedProducts,
            [PresentationProduct(product2), PresentationProduct(product3), PresentationProduct(product1)]
        )
    }

    func testShowsErrorOnShowProductsFetchError() {
        let error = "any"
        let expected = "Could not fetch products. \(error)"

        sut.showProductsFetchError(error)

        XCTAssertEqual(output.invokedProductsFetchError, expected)
    }

    func testShowsProductsFetchProgressOnShowProductsFetchProgress() {
        sut.showProductsFetchProgress()

        XCTAssertTrue(output.didCallShowProductsFetchProgress)
    }

    func testDisablesPurchaseRestorationOnShowProductsFetchProgress() {
        sut.showProductsFetchProgress()

        XCTAssertTrue(output.didCallDisablePurchaseRestoration)
    }

    func testEnablesPurchaseRestorationOnShowProducts() {
        sut.showProducts([])

        XCTAssertTrue(output.didCallEnablePurchaseRestoration)
    }

    func testEnablesPurchaseRestorationOnShowProductsFetchError() {
        sut.showProductsFetchError("any")

        XCTAssertTrue(output.didCallEnablePurchaseRestoration)
    }

    // MARK: - Purchase

    func testShowsPurchaseProgressOnShowPurchaseProgress() {
        sut.showPurchaseProgress()

        XCTAssertTrue(output.didCallShowPurchaseProgress)
    }

    func testDisablesPurchaseRestorationOnShowPurchaseProgress() {
        sut.showPurchaseProgress()

        XCTAssertTrue(output.didCallDisablePurchaseRestoration)
    }

    func testShowsPurchaseErrorOnShowPurchaseError() {
        let error = "any"
        sut.showPurchaseError(error)

        XCTAssertEqual(output.invokedPurchaseError, error)
    }

    func testEnablesPurchaseRestorationOnShowPurchaseError() {
        sut.showPurchaseError("any")

        XCTAssertTrue(output.didCallEnablePurchaseRestoration)
    }

    // MARK: - Restoration

    func testShowsPurchaseRestorationProgressOnShowPurchaseRestorationProgress() {
        sut.showPurchaseRestorationProgress()

        XCTAssertTrue(output.didCallShowPurchaseRestorationProgress)
    }

    func testDisablesPurchaseRestorationOnShowPurchaseRestorationProgress() {
        sut.showPurchaseRestorationProgress()

        XCTAssertTrue(output.didCallDisablePurchaseRestoration)
    }

    func testShowsPurchaseRestorationErrorOnShowPurchaseRestorationError() {
        let error = "any"

        sut.showPurchaseRestorationError(error)

        XCTAssertEqual(output.invokedPurchaseRestorationError, error)
    }

    func testEnablesPurchaseRestorationOnShowPurchaseRestorationError() {
        sut.showPurchaseRestorationError("any")

        XCTAssertTrue(output.didCallEnablePurchaseRestoration)
    }

    // MARK: - Purchased

    func testShowsPurchasedOnShowPurchased() {
        sut.showPurchased(until: Date())

        XCTAssertTrue(output.didCallShowPurchased)
    }

    func testShowsSubscriptionManagementOnShowPurchased() {
        sut.showPurchased(until: Date())

        XCTAssertTrue(output.didCallShowSubscriptionManagement)
    }
}
