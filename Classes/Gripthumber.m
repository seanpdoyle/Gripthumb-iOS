//
//  Gripthumber.m
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/13/14.
//
//

#import "Gripthumber.h"

@implementation Gripthumber
@synthesize apiEndpoint;

- (id)init
{
    self = [super init];
    if (self) {
        apiEndpoint = [NSURL URLWithString:@"https://gripthumb.herokuapp.com/songs/identify"];
//        apiEndpoint = [NSURL URLWithString:@"http://gripthumb.dev/songs/identify"];
    }
    return self;
}

- (SongModel*) gripthumb:(NSString*)fingerprintCode {
    if ([fingerprintCode length] == 0) {
        return nil;
    }
    NSError* error;
    NSURLResponse* response;
    NSData* responseData = [NSURLConnection sendSynchronousRequest:[self requestFor:fingerprintCode]
                                                 returningResponse:&response
                                                             error:&error];
    
    id json = [NSJSONSerialization JSONObjectWithData:responseData
                                              options:NSJSONReadingAllowFragments
                                                error:nil];
    SongModel* song;
    if (error != nil) {
        NSLog(@"Error with request to server: %@", error.localizedDescription);
    } else if ([json hasKey:@"error"]) {
        NSLog(@"Error from server: %@", [json objectForKey:@"error"]);
        NSDictionary* withSong = [json objectForKey:@"song"];
        if (withSong != nil) {
            NSLog(@"Did find song: %@", song);
        }
    } else {
        song = [[SongModel alloc] initWithDictionary:[json objectForKey:@"song"]
                                                                  error:nil];
        NSLog(@"JSON: %@", json);
    }
    return song;
}

- (NSURLRequest*) requestFor:(NSString*) fingerprintCode {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:apiEndpoint];
    NSDictionary* parameters = @{
                                    @"code": fingerprintCode
                                 };

    NSData *postBody = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postBody];
    return request;
}

@end
