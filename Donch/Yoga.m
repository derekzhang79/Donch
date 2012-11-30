//
//  Yoga.m
//  Donch
//
//  Created by Ryan on 11/30/12.
//
//

#import "Yoga.h"

@implementation Yoga
@synthesize name, imageName, status;

//For print out
- (NSString *)description {
    return [NSString stringWithFormat:@"Yoga : <%@, %@, %@>", name, imageName, status ? @"YES" : @"NO"];
}

@end
