//
//  QMKInvocationFork.h
//  QulixMobileKit
//
//  Created by Makarov Viacheslav on 29.08.12.
//  Copyright (c) 2012 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Forwards every incomming method call to a set of responders (makes every call to fork).
///
/// The set of methods allowed to fork are specified by a protocol. The fork will not respond to a method
/// that is not present in the original protocol. The fork will respond to a method call only when
/// there is at least one responder that responds to the given method.
@interface QMKInvocationFork : NSObject

/// @param protocol  The fork protocol that should be implemented by the responders.
- (id)initWithProtocol:(Protocol*)protocol;

/// Adds the given object as a target for the forwarded messages. The order in which the responders
/// will receive messages is not defined. So, if a forwarded message returns non-void than it should not be
/// implemented by more than one responder.
///
/// @param responder  An object to which the messages should be forwarded. It is assumed that
/// the responder implements the fork protocol.
- (void)addResponder:(id)responder;

- (void)removeResponder:(id)responder;

@end
