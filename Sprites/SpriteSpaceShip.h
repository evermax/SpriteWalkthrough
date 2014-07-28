//
//  SpriteSpaceShip.h
//  SpriteWalkthrough
//
//  Created by Maxime Lasserre on 14/04/14.
//  Copyright (c) 2014 Maxime Lasserre. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpriteGraphicsUtilites.h"

@interface SpriteSpaceShip : SKSpriteNode {
    NSInteger life;
    BOOL vectorialMove;
}

+ (SKSpriteNode *)newSpaceship: (BOOL) vectorialMove;

@end
