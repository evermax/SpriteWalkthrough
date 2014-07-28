//
//  SpriteGraphicsUtilites.m
//  SpriteWalkthrough
//
//  Created by Maxime Lasserre on 14/04/14.
//  Copyright (c) 2014 Maxime Lasserre. All rights reserved.
//

#import "SpriteGraphicsUtilites.h"


@implementation SpriteGraphicsUtilites

/************************************** Particules des explosions ********************************************/
+ (SKEmitterNode *) newSparkEmitter
{
    NSString *sparkPath = [[NSBundle mainBundle] pathForResource:@"sparkExplosion" ofType:@"sks"];
    SKEmitterNode *spark = [NSKeyedUnarchiver unarchiveObjectWithFile:sparkPath];
    return spark;
}

/*********************************** Fonction de création du texte POC ! ***********************************/
+ (SKLabelNode *) newPocNode
{
    SKLabelNode *pocNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    pocNode.name = @"pocNode";
    pocNode.text = @"Poc !";
    pocNode.fontSize = 42;
    return pocNode;
}

/************************************** Particules du moteur ******************************************************/
+ (SKEmitterNode *) newFireEmitter
{
    NSString *firePath = [[NSBundle mainBundle] pathForResource:@"enginFire" ofType:@"sks"];
    SKEmitterNode *fire = [NSKeyedUnarchiver unarchiveObjectWithFile:firePath];
    return fire;
}

/**************** SpriteNode rock générique pour les petites roquettes qui apparaissent en haut ******************/
+ (SKSpriteNode *) newRocket
{
    SKSpriteNode *rocket = [SKSpriteNode spriteNodeWithImageNamed:@"rocket"];
    
    rocket.name = @"rocket";
    rocket.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rocket.size];
    rocket.zRotation = M_PI;
    rocket.xScale = 0.05;
    rocket.yScale = 0.05;
    rocket.physicsBody.usesPreciseCollisionDetection = YES;
    //rocket.physicsBody.affectedByGravity = NO;
    rocket.physicsBody.categoryBitMask = blockCategory;
    rocket.physicsBody.collisionBitMask = playerCategory;
    rocket.physicsBody.contactTestBitMask = playerCategory;
    return rocket;
}

/***************** Noeud qui permet d'afficher le nombre de contacts effectués depuis le début *******************/
+ (SKLabelNode *)newCounterNode:(SKScene *) scene :(float) collisionCounter
{
    SKLabelNode *counterNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    counterNode.name = @"counterNode";
    counterNode.text = [NSString stringWithFormat:@"Nombre de contact %ld", (long)collisionCounter];
    counterNode.fontSize = 42;
    counterNode.position = CGPointMake(CGRectGetMidX(scene.frame),CGRectGetMaxY(scene.frame) - 30.0);
    return counterNode;
}

/****************** SpriteNode rock générique pour les petits cailloux qui apparaissent en haut ******************/
+ (SKSpriteNode *)newRock
{
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(8,8)];
    rock.name = @"rock";
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = YES;
    rock.physicsBody.categoryBitMask = blockCategory;
    rock.physicsBody.collisionBitMask = playerCategory;
    rock.physicsBody.contactTestBitMask = playerCategory;
    return rock;
}

@end
