//
//  SongModel.m
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/13/14.
//
//

#import "SongModel.h"

@implementation SongModel

+(JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
