//
//  MicrophoneControllerViewController.h
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/12/14.
//
//

#import <UIKit/UIKit.h>
#import "Fingerprinter.h"
#import "Gripthumber.h"

@interface MicrophoneViewController : UIViewController {
    IBOutlet UIActivityIndicatorView* spinnerView;
    IBOutlet UIButton* recordButton;

    Fingerprinter* fingerprinter;
    Gripthumber* gripthumber;
    
    BOOL recording;
    int secondsPassed;
}

- (IBAction) buttonWasPressed:(id)sender;

- (void) fingerprintSong;
- (void) scheduleFingerprint;
- (void) startRecording;
- (void) stopRecording;
- (void) showResults:(NSArray*) results;

@end

