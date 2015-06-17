//
//  UnixFileHandle.swift
//  ARISockets
//
//  Created by Helge Hess on 17/06/15.
//
//

import Darwin

public protocol UnixFileHandleType {

  var fd      : Int32? { get } // TBD: probably better >= 0
  var isValid : Bool   { get }
  
}

extension UnixFileHandleType {

  public var isValid : Bool { return fd != nil }
  
}
