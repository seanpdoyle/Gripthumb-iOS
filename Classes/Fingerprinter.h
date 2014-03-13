//
//  Fingerprinter.h
//  Echoprint
//
//  Created by Brian Whitman on 1/23/11.
//  Copyright 2011 The Echo Nest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Fingerprinter : NSObject {
	AVAudioRecorder* audioRecorder;
    BOOL recording;
    NSURL* outputURL;
}

-(void) record;
-(void) stop;
-(NSString*) fingerprint;
-(BOOL) isRecording;

-(NSDictionary*) recordSettings;

@end


