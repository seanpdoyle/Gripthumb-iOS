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

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* artistName;
@property (assign, nonatomic) NSArray<PartModel>* parts;

@end
