//
//  AppDelegate.h
//  Cocoa Speech Synthesizer
//
//  Created by Nikola Grujic on 12/01/2020.
//  Copyright © 2020 Mac Developers. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSSpeechSynthesizerDelegate, NSTableViewDelegate>
{
    NSArray *voices;
    NSSpeechSynthesizer *speechSynthesizer;
}

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSButton *speakButton;
@property (weak) IBOutlet NSButton *stopButton;
@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)stop:(id)sender;
- (IBAction)speak:(id)sender;

@end

