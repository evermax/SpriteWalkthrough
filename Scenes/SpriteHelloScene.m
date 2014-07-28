//
//  SpriteHelloScene.m
//  SpriteWalkthrough
//
//  Created by Maxime Lasserre on 03/04/14.
//  Copyright (c) 2014 Maxime Lasserre. All rights reserved.
//

#import "SpriteHelloScene.h"
#import "SpriteSpaceshipScene.h"


@interface SpriteHelloScene ()
@property BOOL contentCreated;
@end


@implementation SpriteHelloScene

- (void)didMoveToView: (SKView *) view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    self.userData = [NSMutableDictionary dictionary];
    self.backgroundColor = [SKColor blueColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    CGPoint pointVectorial = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame) + 50.0);
    CGPoint pointLinear = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame) - 50.0);
    [self addChild: [self newTitleNode: pointVectorial Name:@"vectorial" Text:@"Déplacement vectoriel"]];
    [self addChild: [self newTitleNode: pointLinear Name:@"linear" Text:@"Déplacement linéaire"]];
}

- (SKLabelNode *)newTitleNode: (CGPoint) point Name:(NSString*) name Text:(NSString*) text
{
    SKLabelNode *helloNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.name = name;
    helloNode.text = text;
    helloNode.fontSize = 42;
    helloNode.position = point;
    return helloNode;
}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    SKNode *vectorialNode = [self childNodeWithName:@"vectorial"];
    SKNode *linearNode = [self childNodeWithName:@"linear"];
    SKNode *node1;
    SKNode *node2;
    BOOL vectorialMode;
    SKAction *moveUp = [SKAction moveToY: 500.0 duration:0.5];
    SKAction *zoom = [SKAction scaleTo: 2.0 duration: 0.25];
    SKAction *pause = [SKAction waitForDuration: 0.5];
    SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *moveSequence = [SKAction sequence:@[moveUp, zoom, pause, fadeAway, remove]];
    NSArray *nodes = [self nodesAtPoint:[touch locationInNode:self]];
    if ([nodes containsObject:vectorialNode]) {
        node1 = vectorialNode;
        node2 = linearNode;
        vectorialMode = YES;
    }else {
        node2 = vectorialNode;
        node1 = linearNode;
        vectorialMode = NO;
    }
    if (node1 != nil && node2 != nil)
    {
        node2.name = nil;
        node1.name = nil;
        [node2 runAction:fadeAway];
        
        [node1 runAction: moveSequence completion:^{
            SKScene *spaceshipScene  = [[SpriteSpaceshipScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
            spaceshipScene.userData = [NSMutableDictionary dictionary];
            if (vectorialMode) {
                [spaceshipScene.userData setObject:@"YES" forKey:@"vectorialMode"];
            } else {
                [spaceshipScene.userData setObject:@"NO" forKey:@"vectorialMode"];
            }
            
            [self.view presentScene:spaceshipScene transition:doors];
        }];
    }
}


@end
