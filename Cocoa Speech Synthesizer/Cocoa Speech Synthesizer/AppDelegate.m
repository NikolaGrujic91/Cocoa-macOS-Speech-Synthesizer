//
//  AppDelegate.m
//  Cocoa Speech Synthesizer
//
//  Created by Nikola Grujic on 12/01/2020.
//  Copyright © 2020 Mac Developers. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (id)init
{
    self = [super init];
    
    if (self)
    {
        speechSynthesizer = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
        [speechSynthesizer setDelegate:self];
        
        voices = [NSSpeechSynthesizer availableVoices];
    }
    
    return self;
}

//Prepares the receiver for service after it has been loaded from an
//Interface Builder archive, or nib file.
- (void) awakeFromNib
{
    NSString *defaultVoice = [NSSpeechSynthesizer defaultVoice];
    NSInteger defaultRow = [voices indexOfObject: defaultVoice];
    NSIndexSet *indices = [NSIndexSet indexSetWithIndex:defaultRow];
    [_tableView selectRowIndexes:indices byExtendingSelection:NO];
    [_tableView scrollRowToVisible:defaultRow];
}

// Sent when an NSSpeechSynthesizer object finishes speaking through the sound output device.
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender
        didFinishSpeaking:(BOOL)finishedSpeaking
{
    [_speakButton setEnabled:YES];
    [_stopButton setEnabled:NO];
    [_tableView setEnabled:YES];
}

#pragma mark Table view dataSource methods

//Returns the number of records managed for aTableView by the data source object.
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return (NSInteger)[voices count];
}

//Called by the table view to return the data object associated
//with the specified row and column.
- (id)tableView:(NSTableView *)tableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
            row:(NSInteger)row
{
    NSString *voice = [voices objectAtIndex:row];
    NSDictionary *voicesDictionary = [NSSpeechSynthesizer attributesForVoice:voice];
    return [voicesDictionary objectForKey:NSVoiceName];
}

//Tells the delegate that the table view’s selection has changed.
- (void)tableViewSelectionDidChange:(NSNotification *)notification;
{
    NSInteger row = [_tableView selectedRow];
    
    if (row == -1)
    {
        return;
    }
    
    NSString *selectedVoice = [voices objectAtIndex:row];
    [speechSynthesizer setVoice:selectedVoice];
}

#pragma mark Action methods

- (IBAction)stop:(id)sender
{
    [speechSynthesizer stopSpeaking];
}

- (IBAction)speak:(id)sender
{
    NSString *str = [_textField stringValue];
    
    if ([str length] == 0)
    {
        return;
    }
    
    [speechSynthesizer startSpeakingString:str];
    
    [_speakButton setEnabled:NO];
    [_stopButton setEnabled:YES];
    [_tableView setEnabled:NO];
}

@end
