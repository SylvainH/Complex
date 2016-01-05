//
//  Complex.swift
//
//  Created by Sylvain on 19/Mar/2015.
//  Copyright (c) 2015-2016 Sylvain. All rights reserved.
//  Updated 4/Jan/2016
/*  LICENSE
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/


import Foundation

public protocol ComplexType {
    typealias RealNumber
    
    var real: RealNumber { get }
    var imaginary: RealNumber { get }
    var radius: RealNumber { get }
    var angle: RealNumber { get }
    
    init(_ value: UInt8)
    init(_ value: Int8)
    init(_ value: UInt16)
    init(_ value: Int16)
    init(_ value: UInt32)
    init(_ value: Int32)
    init(_ value: UInt64)
    init(_ value: Int64)
    init(_ value: UInt)
    init(_ value: Int)
    
    init(_ value: Float)
    init(_ value: Double)
    
    init(real: RealNumber, imaginary: RealNumber)
    init(radius: RealNumber, angle: RealNumber)
    
    static var I: Self { get } // 0 + i
}

public protocol FloatingComplexType: ComplexType, Equatable  {
    typealias RealNumber: FloatingPointType
    
    /// The positive infinity.
    static var infinity: Self { get }
    /// A NaN.
    static var NaN: Self { get }
    /// A quiet NaN.
    static var quietNaN: Self { get }
    
    /// true iff self (real & imaginary) are finite
    var isFinite: Bool { get }
    /// true iff self (real or imaginary) is infinite
    var isInfinite: Bool { get }
    // true iff self (real & imaginary) are normal
    var isNormal: Bool { get }
    // true iff self (real or imaginary) is subnormal
    var isSubnormal: Bool { get }
    /// true iff self (real & imaginary) are +0.0 or -0.0
    var isZero: Bool { get }
    /// true iff self (real or imaginary) is NaN
    var isNaN: Bool { get }
    /// true iff self (real or imaginary) is a signaling NaN.
    var isSignaling: Bool { get }
    /// true iff self (real or imaginary) is negative.
    var isSignMinus: Bool { get }
}

extension FloatingComplexType {
    /// - returns: true iff self (real & imaginary) are finite
    public var isFinite: Bool {
        return real.isFinite && imaginary.isFinite
    }
    /// - returns: true iff self (real or imaginary) is infinite
    public var isInfinite: Bool {
        return real.isInfinite || imaginary.isInfinite
    }
    /// - returns: true iff self (real & imaginary) are normal
    public var isNormal: Bool {
        return real.isNormal && imaginary.isNormal
    }
    /// - returns: true iff self (real or imaginary) is subnormal
    public var isSubnormal: Bool {
        return real.isSubnormal || imaginary.isSubnormal
    }
    /// - returns: true iff self (real & imaginary) are +0.0 or -0.0
    public var isZero: Bool {
        return real.isZero && imaginary.isZero
    }
    /// - returns: true iff self (real or imaginary) is NaN
    public var isNaN: Bool {
        return real.isNaN || imaginary.isNaN
    }
    /// - returns: true iff self (real or imaginary) is a signaling NaN.
    public var isSignaling: Bool {
        return real.isSignaling || imaginary.isSignaling
    }
    /// - returns: true iff self (real or imaginary) is negative.
    public var isSignMinus: Bool {
        return real.isSignMinus || imaginary.isSignMinus
    }
}

public struct ComplexDouble: FloatingComplexType, CustomStringConvertible, Hashable {
    public typealias RealNumber = Double
    
    let _real, _imaginary: Double
    
    public var real: Double {
        return _real
    }
    public var imaginary: Double {
        return _imaginary
    }
    public var radius: Double {
        return abs(self)
    }
    public var angle: Double {
        return phase(self)
    }
    
    ///rectangular form init
    public init(real: Double, imaginary: Double) {
        self._real = real
        self._imaginary = imaginary
    }
    
    ///polar form to rectangular init
    public init(radius: Double, angle: Double) {
        self._real = radius * cos(angle)
        self._imaginary = radius * sin(angle)
    }
    
    //conforms to CustomStringConvertible
    public var description: String {
        if imaginary.isSignMinus {
            return "\(real) - i\(abs(imaginary))"
        }
        return "\(real) + i\(imaginary)"
    }
    
    //conforms to hashable
    public var hashValue: Int {
        return real.hashValue ^ imaginary.hashValue
    }
    
    //conforms to ComplexType
    public init(_ value: UInt8) {
        self.init(real: Double(value), imaginary: 0)
    }
    public init(_ value: Int8) {
        self.init(real: Double(value), imaginary: 0)
    }
    public init(_ value: UInt16) {
        self.init(real: Double(value), imaginary: 0)
    }
    public init(_ value: Int16) {
        self.init(real: Double(value), imaginary: 0)
    }
    public init(_ value: UInt32) {
        self.init(real: Double(value), imaginary: 0)
    }
    public init(_ value: Int32) {
        self.init(real: Double(value), imaginary: 0)
    }
    public init(_ value: UInt64) {
        self.init(real: Double(value), imaginary: 0)
    }
    public init(_ value: Int64) {
        self.init(real: Double(value), imaginary: 0)
    }
    public init(_ value: UInt) {
        self.init(real: Double(value), imaginary: 0)
    }
    public init(_ value: Int) {
        self.init(real: Double(value), imaginary: 0)
    }
    public init(_ value: Float) {
        self.init(real: Double(value), imaginary: 0)
    }
    public init(_ value: Double) {
        self.init(real: Double(value), imaginary: 0)
    }
    ///  - returns: a positive infinity complex value
    public static var infinity: ComplexDouble {
        return ComplexDouble(real: Double.infinity, imaginary: Double.infinity)
    }
    /// - returns: a NaN complex value
    public static var NaN: ComplexDouble {
        return ComplexDouble(real: Double.NaN, imaginary: Double.NaN)
    }
    /// - returns: a quietNaN complex value
    public static var quietNaN: ComplexDouble {
        return ComplexDouble(real: Double.quietNaN, imaginary: Double.quietNaN)
    }
    /// - returns: complex value I (0+i)
    public static var I: ComplexDouble {
        return ComplexDouble(real: 0, imaginary: 1)
    }
}

public func abs(z: ComplexDouble) -> Double {
    return hypot(z.real, z.imaginary)
}

public func phase(z: ComplexDouble) -> Double {
    return atan2(z.imaginary, z.real)
}

public func conjugate(z: ComplexDouble) -> ComplexDouble {
    return ComplexDouble(real: z.real, imaginary: -z.imaginary)
}

public func log(z: ComplexDouble) -> ComplexDouble {
    return ComplexDouble(
        real: log(abs(z)),
        imaginary: phase(z)
    )
}

public func log10(z: ComplexDouble) -> ComplexDouble {
    return ComplexDouble(
        real: log10(abs(z)),
        imaginary: phase(z)
    )
}

public func exp(z: ComplexDouble) -> ComplexDouble  {
    // exp(z) = exp(x) * cis(y)
    let r = exp(z.real)
    return ComplexDouble(radius: r, angle: z.imaginary)
}

public func pow(z: ComplexDouble, power: Double) -> ComplexDouble {
    // pow(z, power) = pow(radius, power) * cis(power * angle)
    return ComplexDouble(
        radius: pow(abs(z), power),
        angle: power * phase(z)
    )
}

public func pow(z: ComplexDouble, power: ComplexDouble) -> ComplexDouble {
    // pow(z, power) = cexp (power * clog(z))
    return exp(power * log(z))
}

public func sin(z: ComplexDouble) -> ComplexDouble {
    // sin(z) = sin(x)*cosh(y) + i*cos(x)*sinh(y)
    return ComplexDouble(
        real: sin(z.real)*cosh(z.imaginary),
        imaginary: cos(z.real)*sinh(z.imaginary)
    )
}

public func cos(z: ComplexDouble) -> ComplexDouble {
    // cos(z) = cos(x)*cosh(y) + i*sin(x)sinh(y)
    return ComplexDouble(
        real: cos(z.real)*cosh(z.imaginary),
        imaginary: sin(z.real)*sinh(z.imaginary)
    )
}

public func tan(z: ComplexDouble) -> ComplexDouble {
    // tan(z) = sin(z)/cos(z) = sin(2*x) + i*sinh(2*y) / cos(2*x) + cosh(2*y)
    let d : Double = cos(2 * z.real) + cosh(2 * z.imaginary)
    return ComplexDouble(
        real: sin(2 * z.real) / d,
        imaginary: sinh(2 * z.imaginary) / d
    )
}

public func arcsin(z: ComplexDouble) -> ComplexDouble {
    var temp = 1 - z * z
    temp = ComplexDouble.I * z + pow(temp, power: 0.5)
    return (-1 * ComplexDouble.I * log(temp))
}

public func arccos(z: ComplexDouble) -> ComplexDouble {
    return M_PI_2 + -1 * arcsin(z)
}

public func arctan(z: ComplexDouble) -> ComplexDouble {
    let temp = (ComplexDouble.I + z) / (ComplexDouble.I - z)
    return 0.5 * ComplexDouble.I * log(temp)
}

public func sinh(z: ComplexDouble) -> ComplexDouble {
    // sin(z) = sinh(x)*cos(y) + i*cosh(x)*sin(y)
    return ComplexDouble(
        real: sinh(z.real)*cos(z.imaginary),
        imaginary: cosh(z.real)*sin(z.imaginary)
    )
}

public func cosh(z: ComplexDouble) -> ComplexDouble {
    // cosh(z) = cosh(x)*cos(y) + i*sinh(x)sin(y)
    return ComplexDouble(
        real: cosh(z.real)*cos(z.imaginary),
        imaginary: sinh(z.real)*sin(z.imaginary)
    )
}

public func tanh(z: ComplexDouble) -> ComplexDouble {
    // tanh(z) = sinh(z)/cosh(z) = sinh(2*x) + i*sin(2*y) / cosh(2*x) + cos(2*y)
    let d : Double = cosh(2 * z.real) + cos(2 * z.imaginary)
    return ComplexDouble(
        real: sinh(2 * z.real) / d,
        imaginary: sin(2 * z.imaginary) / d
    )
}

public func arcsinh(z: ComplexDouble) -> ComplexDouble {
    var temp = z * z + 1
    temp = z + pow(temp, power: 0.5)
    return log(temp)
}

public func arccosh(z: ComplexDouble) -> ComplexDouble {
    var temp = z * z - 1
    temp = z + pow(temp, power: 0.5)
    return log(temp)
}

public func arctanh(z: ComplexDouble) -> ComplexDouble {
    let temp = (1 + z) / (1 - z)
    return 0.5 * log(temp)
}

public func ==(lhs: ComplexDouble, rhs: ComplexDouble) -> Bool {
    return (lhs.real == rhs.real) && (lhs.imaginary == rhs.imaginary)
}

public func ==(lhs: ComplexDouble, rhs: Double) -> Bool {
    return (lhs.real == rhs) && (lhs.imaginary == 0.0)
}

public func ==(lhs: Double, rhs: ComplexDouble) -> Bool {
    return rhs == lhs
}

public func +(lhs: ComplexDouble, rhs: ComplexDouble) -> ComplexDouble {
    return ComplexDouble(real: lhs.real + rhs.real, imaginary: lhs.imaginary + rhs.imaginary)
}

public func +(lhs: ComplexDouble, rhs: Double) -> ComplexDouble {
    return ComplexDouble(real: lhs.real + rhs, imaginary: lhs.imaginary)
}

public func +(lhs: Double, rhs: ComplexDouble) -> ComplexDouble {
    return rhs + lhs
}

public func -(lhs: ComplexDouble, rhs: ComplexDouble) -> ComplexDouble {
    return ComplexDouble(real: lhs.real - rhs.real, imaginary: lhs.imaginary - rhs.imaginary)
}

public func -(lhs: ComplexDouble, rhs: Double) -> ComplexDouble {
    return ComplexDouble(real: lhs.real - rhs, imaginary: lhs.imaginary)
}

public func -(lhs: Double, rhs: ComplexDouble) -> ComplexDouble {
    return rhs - lhs
}

public func *(lhs: ComplexDouble, rhs: ComplexDouble) -> ComplexDouble {
    return ComplexDouble(
        real: lhs.real * rhs.real - lhs.imaginary * rhs.imaginary,
        imaginary: lhs.imaginary * rhs.real + lhs.real * rhs.imaginary
    )
}

public func *(lhs: ComplexDouble, rhs: Double) -> ComplexDouble {
    return ComplexDouble(real: lhs.real * rhs, imaginary: lhs.imaginary * rhs)
}

public func *(lhs:Double, rhs: ComplexDouble) -> ComplexDouble {
    return rhs * lhs
}

public func /(lhs: ComplexDouble, rhs: ComplexDouble) -> ComplexDouble {
    let d = rhs.real * rhs.real + rhs.imaginary * rhs.imaginary
    return ComplexDouble(
        real: (lhs.real * rhs.real + lhs.imaginary * rhs.imaginary) / d,
        imaginary: (lhs.imaginary * rhs.real - lhs.real * rhs.imaginary) / d
    )
}

public func /(lhs: ComplexDouble, rhs: Double) -> ComplexDouble {
    return ComplexDouble(real: lhs.real / rhs, imaginary: lhs.imaginary / rhs)
}

public func /(lhs: Double, rhs: ComplexDouble) -> ComplexDouble {
    return ComplexDouble(real: lhs, imaginary: 0) / rhs
}



