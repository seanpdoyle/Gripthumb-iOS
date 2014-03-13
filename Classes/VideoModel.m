//
//  VideoModel.m
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/13/14.
//
//

#import "VideoModel.h"

@implementation VideoModel

- (NSURL*) logoURL {
    return [NSURL URLWithString:[self logo]];
}
@end
