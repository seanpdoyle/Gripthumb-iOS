//
//  PartModel.h
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/13/14.
//
//

#import "JSONModel.h"
#import "VideoModel.h"

@protocol PartModel @end

@interface PartModel : JSONModel

@property int id;
@property NSString* name;
@property VideoModel* video;

@end
