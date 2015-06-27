//
//  UnixFileHandle.swift
//  ARISockets
//
//  Created by Helge Hess on 17/06/15.
//
//

import Darwin

// Notes: All properties need to be public in the implementing class. Hm.

public protocol UnixFileHandleType {

  var fd      : Int32? { get set } // TBD: probably better >= 0
  var isValid : Bool   { get }
 
  mutating func close()
  
  var flags         : Int32? { get set }
  var isNonBlocking : Bool   { get set }
}


/* default implementations */

public extension UnixFileHandleType {

  public var isValid : Bool { return fd != nil }

  public mutating func close() {
    guard let cfd = fd else { return }
    guard cfd >= 0     else { return }
    Darwin.close(cfd)
    fd = nil
  }

}

// Crashes when changed from Socket to UnixFileHandleType
public extension UnixFileHandleType { // fcntl() Flags
  
  public var flags : Int32? {
    get {
      let rc = ari_fcntlVi(fd!, F_GETFL, 0)
      return rc >= 0 ? rc : nil
    }
    set {
      let rc = ari_fcntlVi(fd!, F_SETFL, Int32(newValue!))
      if rc == -1 {
        print("Could not set new socket flags \(rc)")
      }
    }
  }
  
  public var isNonBlocking : Bool {
    get {
      if let f = flags {
        return (f & O_NONBLOCK) != 0 ? true : false
      }
      else {
        print("ERROR: could not get non-blocking socket property!")
        return false
      }
    }
    set {
      if newValue {
        if let f = flags {
          flags = f | O_NONBLOCK
        }
        else {
          flags = O_NONBLOCK
        }
      }
      else {
        flags = flags! & ~O_NONBLOCK
      }
    }
  }
  
}
