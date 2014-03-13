//
//  ViewController.m
//
//  Created by Brian Whitman on 6/13/11.
//  Copyright 2011 The Echo Nest. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (IBAction) startCount:(id)sender
{
    progress = 0;
    progressTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgressBar:) userInfo:nil repeats:YES];
}

- (void) updateProgressBar:(NSTimer *)timer
{
    progress++;
    
    if (progress <= RECORD_FOR)
    {
        progressView.progress = (float) progress / (float) RECORD_FOR;
    } else
    {
        progressView.progress = 0;
        [progressTimer invalidate];
        progressTimer = nil;
    } 
}

- (IBAction) startMicrophone:(id)sender {
	if([fingerprinter isRecording]) {
        [self stopRecording];
    } else {
        [self startRecording];
    }
}

- (void) startRecording {
    [partsArray removeAllObjects];
    [statusLine setText:@""];    [recordButton setTitle:@"Recording..." forState:UIControlStateNormal];
    [fingerprinter record];
    [recordButton setEnabled:NO];
    [statusLine setNeedsDisplay];
    [self.view setNeedsDisplay];
    
    [NSTimer scheduledTimerWithTimeInterval: RECORD_FOR
                                     target: self
                                   selector: @selector(stopRecording)
                                   userInfo: nil
                                    repeats: NO];
}

- (void) stopRecording {
    [fingerprinter stop];
    NSString* fpCode = [fingerprinter fingerprint];
    [recordButton setTitle:@"Record" forState:UIControlStateNormal];
    [recordButton setEnabled:YES];
    [statusLine setText:@"analysing..."];
    [statusLine setNeedsDisplay];
    [self.view setNeedsDisplay];
    [self getSongWithCode:fpCode];
}

- (void) getSongWithCode: (NSString*) songCode {
	NSLog(@"Done %@", songCode);
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/songs/identify", API_HOST]];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:songCode forKey:@"code"];
	[request setAllowCompressedResponse:NO];
	[request startSynchronous];
    
    [partsTable reloadData];
    
	NSError *error = [request error];
	if (!error) {
		NSString *response = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
		NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		NSLog(@"%@", json);
        NSString *error = [json objectForKey:@"error"];
		NSDictionary *song = [json objectForKey:@"song"];
        
        if(error == NULL) {
            NSArray *parts = [song objectForKey:@"parts"];
            
            [parts each:^(id part){
                [partsArray addObject: part];
            }];
            
            NSString *song_title = [song objectForKey:@"name"];
			NSString *artist_name = [song objectForKey:@"artist_name"];
            
			[statusLine setText:[NSString stringWithFormat:@"%@ - %@", artist_name, song_title]];
        } else {
            if(song != NULL) {
                NSString *song_title = [song objectForKey:@"name"];
                NSString *artist_name = [song objectForKey:@"artist_name"];
                [statusLine setText:[NSString stringWithFormat: @"No parts found for %@ - %@",  artist_name, song_title]];
            } else {
                [statusLine setText:@"No matching song"];
            }
        }
	} else {
		[statusLine setText:@"some error"];
		NSLog(@"error: %@", error);
	}
    [partsTable reloadData];
	[statusLine setNeedsDisplay];
	[self.view setNeedsDisplay];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [partsArray count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary *part = [partsArray objectAtIndex: indexPath.row];
    NSDictionary *video = [part objectForKey:@"video"];
    
    cell.textLabel.text =  [part objectForKey:@"name"];
    cell.detailTextLabel.text = [video objectForKey:@"name"];
   
    NSString *logo = [video objectForKey:@"logo"];
    
    NSURL *thumbUrl = [NSURL URLWithString:logo];
    NSData *thumbData = [NSData dataWithContentsOfURL:thumbUrl];
    
    cell.imageView.image = [UIImage imageWithData:thumbData];
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    partsArray = [[NSMutableArray alloc] init];
	fingerprinter = [[Fingerprinter alloc] init];
}

@end
