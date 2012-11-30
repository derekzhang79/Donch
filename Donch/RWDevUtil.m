//
//  RyanUtility.m
//  Stitch
//
//  Created by Ryan on 11/27/12.
//  Copyright (c) 2012 Ryan Wu. All rights reserved.
//

#import "RWDevUtil.h"

@implementation RWDevUtil
+ (void) RWLog: (id) object {
    if ([object isKindOfClass: [NSString class]]) {
        NSLog(@"%@", object);
    } else if ([object isKindOfClass: [NSDictionary class]]){
        CFShow((__bridge CFTypeRef)(object));
      } else if ([object isKindOfClass: [NSArray class]]) {
          NSArray *array = object;
          NSLog(@"%@", [array componentsJoinedByString:@" - "]);
    } else if (!object) {
        NSLog(@"Object Not Exist!");
    } else {
        NSLog(@"%@ - %@", [object class], object);
    }
}
//NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
//NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
@end
