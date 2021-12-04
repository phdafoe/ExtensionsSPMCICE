/*
Copyright, everisSL
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/

import Foundation
import CoreGraphics

public extension Optional where Wrapped == String {

    var unwrapEmpty: String {
        return self ?? ""
    }

    var unwrapSpace: String {
        return self ?? " "
    }

    func unwrapDefault(_ value: String) -> String {

        return self ?? value
    }
}

public extension Optional where Wrapped == Int {

    var unwrapZero: Int {
        return self ?? 0
    }

    var unwrapIdentity: Int {
        return self ?? 1
    }

    func unwrapDefault(_ value: Int) -> Int {

        return self ?? value
    }
}

public extension Optional where Wrapped == Float {

    var unwrapZero: Float {
        return self ?? 0.0
    }

    var unwrapIdentity: Float {
        return self ?? 1.0
    }

    func unwrapDefault(_ value: Float) -> Float {

        return self ?? value
    }
}

public extension Optional where Wrapped == Double {

    var unwrapZero: Double {
        return self ?? 0.0
    }

    var unwrapIdentity: Double {
        return self ?? 1.0
    }

    func unwrapDefault(_ value: Double) -> Double {

        return self ?? value
    }
}

public extension Optional where Wrapped == CGFloat {

    var unwrapZero: CGFloat {
        return self ?? 0.0
    }

    var unwrapIdentity: CGFloat {
        return self ?? 1.0
    }

    func unwrapDefault(_ value: CGFloat) -> CGFloat {

        return self ?? value
    }
}

public extension Optional where Wrapped == Bool {

    var unwrapFalse: Bool {
        return self ?? false
    }

    var unwrapTrue: Bool {
        return self ?? true
    }

    func unwrapDefault(_ value: Bool) -> Bool {

        return self ?? value
    }
}

public extension Optional where Wrapped == Date {

    var unwrapToday: Date {
        return self ?? Date()
    }

    func unwrapDefault(_ value: Date) -> Date {

        return self ?? value
    }
}
