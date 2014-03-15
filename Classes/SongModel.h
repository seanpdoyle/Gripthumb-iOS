//
//  SongModel.h
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/13/14.
//
//

#import "JSONModel.h"
#import "PartModel.h"

@interface SongModel : JSONModel

@property int id;
@property NSString* name;
@property NSString* artistName;
@property NSArray<PartModel>* parts;

@end
