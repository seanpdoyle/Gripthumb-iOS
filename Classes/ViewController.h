//
//  ViewController.h
//
//  Created by Brian Whitman on 6/13/11.
//  Copyright 2011 The Echo Nest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <ASIHTTPRequest/ASIFormDataRequest.h>
#import <AsyncImageView/AsyncImageView.h>
#import <TSLibraryImport/TSLibraryImport.h>
#import <ObjectiveSugar/ObjectiveSugar.h>
#import <Inflections/NSString+Inflections.h>
#import "Fingerprinter.h"

#define API_HOST @"gripthumb.com"
#define RECORD_FOR 15

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	IBOutlet UIButton* recordButton;
	IBOutlet UILabel* statusLine;
	IBOutlet UITableView* partsTable;
    IBOutlet UIProgressView *progressView;
    
    NSMutableArray* partsArray;
	Fingerprinter* fingerprinter;
    
    NSTimer *progressTimer;
    NSInteger progress;
}

- (IBAction)startMicrophone:(id)sender;
- (void) getSongWithCode: (NSString*) code;

@end

