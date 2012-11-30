//
//  DonchManager.m
//  Donch
//
//  Created by Ryan on 11/30/12.
//
//

#import "DonchManager.h"
#import "Yoga.h"

@implementation DonchManager
@synthesize yogaList;

+ (DonchManager *) getInstance {
    static dispatch_once_t pred;
    static DonchManager *manager = nil;
    dispatch_once(&pred, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
- (id)init {
    if ((self = [super init])) {
        Yoga *yoga = [Yoga new];
    }
    
    return self;
}

- (BOOL) cleanYogaStatus {
    
}

- (BOOL) updateYogaStatusWithIndex: (NSInteger) index {
    
}


@end
