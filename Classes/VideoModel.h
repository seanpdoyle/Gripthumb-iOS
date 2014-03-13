//
//  VideoModel.h
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/13/14.
//
//

#import "JSONModel.h"

@interface VideoModel : JSONModel

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* logo;

@end
