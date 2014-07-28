//
//  SpriteGraphicsUtilites.h
//  SpriteWalkthrough
//
//  Created by Maxime Lasserre on 14/04/14.
//  Copyright (c) 2014 Maxime Lasserre. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

SKEmitterNode * newSparkEmitter();
SKLabelNode * newPocNode();
SKEmitterNode * newFireEmitter();

static const uint32_t blockCategory = 0x1 <<0;
static const uint32_t  playerCategory = 0x1 <<1;


@interface SpriteGraphicsUtilites : NSObject

+ (SKEmitterNode *) newSparkEmitter;
+ (SKLabelNode *) newPocNode;
+ (SKEmitterNode *) newFireEmitter;

+ (SKSpriteNode *) newRocket;
+ (SKSpriteNode *)newRock;
+ (SKLabelNode *)newCounterNode:(SKScene *) scene :(float) collisionCounter;

@end
