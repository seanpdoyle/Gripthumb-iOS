//
//  MicrophoneViewController.m
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/12/14.
//
//

#import "MicrophoneViewController.h"

@interface MicrophoneViewController ()

@end

@implementation MicrophoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    recording = NO;
    fingerprinter = [[Fingerprinter alloc] init];
    spinnerView.hidesWhenStopped = YES;
}

- (IBAction)buttonWasPressed:(id)sender {
    if(recording) {
        [spinnerView stopAnimating];
        [fingerprinter stop];
    } else {
        [spinnerView startAnimating];
        [fingerprinter record];
    }
    recording = !recording;
    
    recordButton.selected = recording;
}
@end
