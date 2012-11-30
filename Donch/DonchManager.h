//
//  DonchManager.h
//  Donch
//
//  Created by Ryan on 11/30/12.
//
//

#import <Foundation/Foundation.h>

@interface DonchManager : NSObject

+ (DonchManager *) getInstance;

- (BOOL) cleanYogaStatus;

- (BOOL) updateYogaStatusWithIndex: (NSInteger) index;

@property(retain, nonatomic) NSArray *yogaList;
@end
