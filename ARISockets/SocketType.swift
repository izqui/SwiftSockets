//
//  SocketType.swift
//  ARISockets
//
//  Created by Helge Heß on 27/06/15.
//
//

public protocol SocketType : UnixFileHandleType {
  
  /*
  typealias T
  
  var boundAddress : T?   { get set }
  var isBound      : Bool { get }
  */
  
}

/*
// MARK: - Binding Sockets

public extension SocketType where T: SocketAddressType {
  
  public var isBound : Bool { return boundAddress != nil }
}
*/
