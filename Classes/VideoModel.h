//
//  VideoModel.h
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/13/14.
//
//

#import "JSONModel.h"

@interface VideoModel : JSONModel

@property int id;
@property NSString* name;
@property NSString* logo;

- (NSURL*) logoURL;

@end
