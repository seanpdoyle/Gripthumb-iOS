//
//  PartModel.h
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/13/14.
//
//

#import "JSONModel.h"
#import "VideoModel.h"

@protocol PartModel <NSObject>

@end

@interface PartModel : JSONModel

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) VideoModel* video;

@end
