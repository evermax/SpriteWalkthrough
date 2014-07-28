//
//  SpriteViewController.m
//  SpriteWalkthrough
//
//  Created by Maxime Lasserre on 03/04/14.
//  Copyright (c) 2014 Maxime Lasserre. All rights reserved.
//

#import "SpriteViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "SpriteHelloScene.h"
#import "SpriteSpaceshipScene.h"

@interface SpriteViewController ()

@end

@implementation SpriteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    SKView *spriteView = (SKView *) self.view;
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    SpriteHelloScene* hello = [[SpriteHelloScene alloc] initWithSize:CGSizeMake(640,960)];
    SKView *spriteView = (SKView *) self.view;
    [spriteView presentScene: hello];
}


@end
