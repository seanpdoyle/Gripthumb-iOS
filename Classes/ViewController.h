//
//  ViewController.h
//
//  Created by Brian Whitman on 6/13/11.
//  Copyright 2011 The Echo Nest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <ASIHTTPRequest/ASIFormDataRequest.h>
#import <TSLibraryImport/TSLibraryImport.h>
#import "MicrophoneInput.h"

// developer.echonest.com
#define API_KEY @"QQZAT4LNJLUGLMAZ5"
#define API_HOST @"developer.echonest.com"

@interface ViewController : UIViewController <MPMediaPickerControllerDelegate> {
	BOOL recording;
	IBOutlet UIButton* recordButton;
	IBOutlet UILabel* statusLine;
	MicrophoneInput* recorder;

}

- (IBAction)pickSong:(id)sender;
- (IBAction)startMicrophone:(id)sender;
- (void) getSong: (const char*) fpCode;

@end

