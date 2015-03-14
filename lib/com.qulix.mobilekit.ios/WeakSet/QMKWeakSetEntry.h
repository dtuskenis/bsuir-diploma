//
//  QMKWeakSetEntry.h
//  QulixMobileKit
//
//  Created by Makarov, Viacheslav on 19.08.13.
//  Copyright (c) 2013 Qulix Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QMKWeakSetEntry : NSObject {
@public
    __unsafe_unretained id object_;
    void* deallocActionKey_;
}

- (id)initWithObject:(id)object;

@end
