//
//  MicrophoneControllerViewController.h
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/12/14.
//
//

#import <UIKit/UIKit.h>
#import "Fingerprinter.h"

@interface MicrophoneViewController : UIViewController {    
    IBOutlet UIActivityIndicatorView* spinnerView;
    IBOutlet UIButton* recordButton;
    Fingerprinter* fingerprinter;
    BOOL recording;
}

- (IBAction)buttonWasPressed:(id)sender;

@end
