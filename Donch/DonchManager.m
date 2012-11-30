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
    self = [super init];
    
    if (self != nil)
    {
        
        NSString* configPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
        NSDictionary *configDictionary = [NSJSONSerialization
                                          JSONObjectWithData:[[[NSString alloc] initWithContentsOfFile:configPath
                                                                                              encoding:NSUTF8StringEncoding
                                                                                                 error:nil]
                                                              dataUsingEncoding:NSUTF8StringEncoding]
                                          options:NSJSONReadingAllowFragments
                                          error:nil];
        NSArray *yogaDataList = [configDictionary objectForKey:@"sampleYoga"];
        yogaList = [NSMutableArray new];
        for (NSDictionary *yogaData in yogaDataList) {
            Yoga *y = [Yoga new];
            y.name = [yogaData objectForKey:@"name"];
            y.imageName = [yogaData objectForKey:@"src"];
            y.status = [[yogaData objectForKey:@"status"] boolValue];;
            NSLog(@"-%@", y);
            [yogaList addObject:y];
        }
    }
    return self;
}

- (NSArray *) listAllYoga {
    for (Yoga *yoga in yogaList) {
        NSLog(@"->%@", yoga);
    }
    return yogaList;
}
- (BOOL) cleanYogaStatus {
    return true;
}

- (BOOL) updateYogaStatusWithIndex: (NSInteger) index {
    Yoga *yoga = [yogaList objectAtIndex:index];
    yoga.status = 1;
    [yogaList replaceObjectAtIndex:index withObject:yoga];
    return true;
}


@end
