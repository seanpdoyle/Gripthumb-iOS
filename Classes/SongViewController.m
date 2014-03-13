//
//  SongViewController.m
//  Gripthumb-iOS
//
//  Created by Sean Doyle on 3/13/14.
//
//

#import "SongViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SongViewController ()

@end

@implementation SongViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    table.delegate = self;
    table.dataSource = self;
    [self loadSong:song];
}

- (void) loadSong:(SongModel*) songToLoad {
    song = songToLoad;
    [name setText: [song name]];
    [artistName setText:[song artistName]];
}

- (IBAction)close:(id)sender {
    [self close:sender];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return song.parts.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    NSArray* parts = song.parts;
    
    PartModel* part = parts[indexPath.row];
    VideoModel* video = part.video;
    
    cell.textLabel.text =  part.name;
    cell.detailTextLabel.text = part.video.name;
    
    [cell.imageView setImageWithURL:[video logoURL]
                   placeholderImage:[UIImage imageNamed:@"Default-568"]];
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
