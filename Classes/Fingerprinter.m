//
//  Fingerprinter.h
//  Echoprint
//
//  Created by Brian Whitman on 1/23/11.
//  Copyright 2011 The Echo Nest. All rights reserved.
//

#import "Fingerprinter.h"

extern const char * GetPCMFromFile(char * filename);

@implementation Fingerprinter

- (id)init
{
    self = [super init];
    if (self) {
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"output.caf"];
        outputURL = [NSURL fileURLWithPath:filePath];
        recording = NO;
    }
    return self;
}

-(void) record
{
	NSLog(@"startRecording");
	audioRecorder = nil;
	
	// Init audio with record capability
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	[audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
	
	[[NSFileManager defaultManager] removeItemAtURL:outputURL error:nil];
	NSLog(@"url loc is %@", outputURL);
	
	NSError *error = nil;
	audioRecorder = [[ AVAudioRecorder alloc] initWithURL:outputURL settings:[self recordSettings] error:&error];
	
	if ([audioRecorder record] == NO){
		int errorCode = CFSwapInt32HostToBig ([error code]);
		NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
	}
	NSLog(@"recording");
    recording = YES;
}

-(void) stop
{
	[audioRecorder stop];
    recording = NO;
    
	NSLog(@"Stopped recording.");
}

-(NSString*) fingerprint
{
    const char * fpCode = GetPCMFromFile([outputURL fileSystemRepresentation]);
    
    return [NSString stringWithUTF8String: fpCode];
}

-(BOOL) isRecording
{
    return recording;
}

-(NSDictionary*) recordSettings
{
  return @{
            AVFormatIDKey:             [NSNumber numberWithInt: kAudioFormatLinearPCM],
            AVSampleRateKey:           @44100.0,
            AVNumberOfChannelsKey:     @2,
            AVLinearPCMBitDepthKey:    @16,
            AVLinearPCMIsBigEndianKey: @NO,
            AVLinearPCMIsFloatKey:     @NO
          };
}


@end
