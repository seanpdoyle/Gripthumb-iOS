//
//  Gripthumber.h
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/13/14.
//
//

#import <Foundation/Foundation.h>
#import "SongModel.h"

@interface Gripthumber : NSObject

- (SongModel*) gripthumb:(NSString*)fingerprintCode;

@property NSURL* apiEndpoint;

@end
