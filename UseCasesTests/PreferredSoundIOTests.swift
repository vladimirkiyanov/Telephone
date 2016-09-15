//
//  PreferredSoundIOTests.swift
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

import Domain
import DomainTestDoubles
@testable import UseCases
import UseCasesTestDoubles
import XCTest

final class PreferredSoundIOTests: XCTestCase {
    fileprivate var factory: SystemAudioDeviceTestFactory!
    fileprivate var defaults: UserDefaultsFake!

    override func setUp() {
        super.setUp()
        factory = SystemAudioDeviceTestFactory()
        defaults = UserDefaultsFake()
    }

    // MARK: - Sound input

    func testInputIsDeviceWithNameFromUserDefaults() {
        let someDevice = factory.someInput
        defaults[kSoundInput] = someDevice.name

        let sut = createSoundIO()

        XCTAssertTrue(sut.input == someDevice)
    }

    func testInputIsBuiltInInputWhenThereIsNoSoundInputInUserDefaults() {
        let sut = createSoundIO()

        XCTAssertTrue(sut.input == factory.firstBuiltInInput)
    }

    func testInputIsBuiltInInputWhenSoundInputFromUserDefaultsCanNotBeFoundInSystemDevices() {
        defaults[kSoundInput] = kNonexistentDeviceName

        let sut = createSoundIO()

        XCTAssertTrue(sut.input == factory.firstBuiltInInput)
    }

    func testInputIsBuiltInInputWhenAudioDeviceMatchedByNameFromUserDefaultsDoesNotHaveInputChannels() {
        defaults[kSoundInput] = factory.outputOnly.name

        let sut = createSoundIO()

        XCTAssertTrue(sut.input == factory.firstBuiltInInput)
    }

    func testInputIsFirstInputWhenNotFoundInUserDefaultsAndThereIsNoBuiltInInput() {
        let sut = createSoundIO(devices: [factory.firstInput, factory.someOutput])

        XCTAssertTrue(sut.input == factory.firstInput)
    }

    // MARK: - Sound output

    func testOutputIsDeviceWithNameFromUserDefaults() {
        let someDevice = factory.someOutput
        defaults[kSoundOutput] = someDevice.name

        let sut = createSoundIO()

        XCTAssertTrue(sut.output == someDevice)
    }

    func testOutputIsBuiltInOutputWhenThereIsNoSoundOutputInUserDefaults() {
        let sut = createSoundIO()

        XCTAssertTrue(sut.output == factory.firstBuiltInOutput)
    }

    func testOutputIsBuiltInOutputWhenSoundOutputFromUserDefaultsCanNotBeFoundInSystemDevices() {
        defaults[kSoundOutput] = kNonexistentDeviceName

        let sut = createSoundIO()

        XCTAssertTrue(sut.output == factory.firstBuiltInOutput)
    }

    func testOutputIsBuiltInOutputWhenAudioDeviceMatchedByNameFromUserDefaultsDoesNotHaveOutputChannels() {
        defaults[kSoundOutput] = factory.inputOnly.name

        let sut = createSoundIO()

        XCTAssertTrue(sut.output == factory.firstBuiltInOutput)
    }

    func testOutputIsFirstOutputWhenNotFoundInUserDefaultsAndThereIsNoBuiltInOutput() {
        let sut = createSoundIO(devices: [factory.someInput, factory.firstOutput])

        XCTAssertTrue(sut.output == factory.firstOutput)
    }

    // MARK: - Ringtone output

    func testRingtoneOutputIsDeviceWithNameFromUserDefaults() {
        let someDevice = factory.someOutput
        defaults[kRingtoneOutput] = someDevice.name

        let sut = createSoundIO()

        XCTAssertTrue(sut.ringtoneOutput == someDevice)
    }

    func testRingtoneOutputIsBuiltInOutputWhenThereIsNoRingtoneOutputInUserDefaults() {
        let sut = createSoundIO()

        XCTAssertTrue(sut.ringtoneOutput == factory.firstBuiltInOutput)
    }

    func testRingtoneOutputIsBuiltInOutputWhenRingtoneOutputFromUserDefaultsCanNotBeFoundInSystemDevices() {
        let sut = createSoundIO()

        defaults[kRingtoneOutput] = kNonexistentDeviceName

        XCTAssertTrue(sut.ringtoneOutput == factory.firstBuiltInOutput)
    }

    func testRingtoneOutputIsBuiltInOutputWhenAudioDeviceMatchedByNameFromUserDefaultsDoesNotHaveOutputChannels() {
        defaults[kRingtoneOutput] = factory.inputOnly.name

        let sut = createSoundIO()

        XCTAssertTrue(sut.ringtoneOutput == factory.firstBuiltInOutput)
    }

    func testRingtoneOutputIsFirstOutputWhenNotFoundInUserDefaultsAndThereIsNoBuiltInOutput() {
        let sut = createSoundIO(devices: [factory.someInput, factory.firstOutput])

        XCTAssertTrue(sut.ringtoneOutput == factory.firstOutput)
    }

    // MARK: - Helper

    fileprivate func createSoundIO() -> UseCases.PreferredSoundIO {
        return createSoundIO(devices: factory.all)
    }

    fileprivate func createSoundIO(devices: [SystemAudioDevice]) -> UseCases.PreferredSoundIO {
        return PreferredSoundIO(devices: SystemAudioDevices(devices: devices), defaults: defaults)
    }
}

private let kNonexistentDeviceName = "Nonexistent"
