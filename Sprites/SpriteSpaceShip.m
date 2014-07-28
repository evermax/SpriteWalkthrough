//
//  SpriteSpaceShip.m
//  SpriteWalkthrough
//
//  Created by Maxime Lasserre on 14/04/14.
//  Copyright (c) 2014 Maxime Lasserre. All rights reserved.
//

#import "SpriteSpaceShip.h"


@implementation SpriteSpaceShip

/****************************************** Création du vaisseau *************************************/
+ (SKSpriteNode *)newSpaceship: (BOOL) vectorialMove
{
    SKSpriteNode *hull = [SKSpriteNode spriteNodeWithImageNamed:@"Image.png"];
    hull.anchorPoint = CGPointMake(0.5, 0.5);
    CGFloat offsetX = hull.frame.size.width * hull.anchorPoint.x;
    CGFloat offsetY = hull.frame.size.height * hull.anchorPoint.y;
    
    /****** Création des contours physiques du vaisseau (au sens pour le moteur physique) *********/
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 114 - offsetX, 396 - offsetY);
    CGPathAddLineToPoint(path, NULL, 41 - offsetX, 282 - offsetY);
    CGPathAddLineToPoint(path, NULL, 14 - offsetX, 3 - offsetY);
    CGPathAddLineToPoint(path, NULL, 218 - offsetX, 3 - offsetY);
    CGPathAddLineToPoint(path, NULL, 181 - offsetX, 296 - offsetY);
    
    CGPathCloseSubpath(path);
    hull.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
    if (vectorialMove) {
        hull.physicsBody.dynamic = YES;
        hull.physicsBody.affectedByGravity = NO;
        hull.physicsBody.mass = 1000.0;
    } else {
        hull.physicsBody.dynamic = NO;
    }
    /********* Propriétés du vaisseau permettant de définir avec quoi il s'entrechoque *********/
    hull.physicsBody.categoryBitMask = playerCategory;
    hull.physicsBody.collisionBitMask = blockCategory;
    hull.physicsBody.contactTestBitMask = blockCategory;
    
    SKEmitterNode *fireEmitter = [SpriteGraphicsUtilites newFireEmitter];
    fireEmitter.position = CGPointMake(0.0, -142.0); //Coordonnées trouvées à la main...
    [hull addChild:fireEmitter];
    
    return hull;
}

-(id)initWithImageNamed:(NSString *)name{
    if (self = [super init]) {
        life = 10;
        //self = [SKSpriteNode spriteNodeWithImageNamed:@"Image.png"];
        self.anchorPoint = CGPointMake(0.5, 0.5);
        CGFloat offsetX = self.frame.size.width * self.anchorPoint.x;
        CGFloat offsetY = self.frame.size.height * self.anchorPoint.y;
        
        /****** Création des contours physiques du vaisseau (au sens pour le moteur physique) *********/
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 114 - offsetX, 396 - offsetY);
        CGPathAddLineToPoint(path, NULL, 41 - offsetX, 282 - offsetY);
        CGPathAddLineToPoint(path, NULL, 14 - offsetX, 3 - offsetY);
        CGPathAddLineToPoint(path, NULL, 218 - offsetX, 3 - offsetY);
        CGPathAddLineToPoint(path, NULL, 181 - offsetX, 296 - offsetY);
        
        CGPathCloseSubpath(path);
        self.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
        if (vectorialMove) {
            self.physicsBody.dynamic = YES;
            self.physicsBody.affectedByGravity = NO;
            self.physicsBody.mass = 1000.0;
        } else {
            self.physicsBody.dynamic = NO;
        }
        /********* Propriétés du vaisseau permettant de définir avec quoi il s'entrechoque *********/
        self.physicsBody.categoryBitMask = playerCategory;
        self.physicsBody.collisionBitMask = blockCategory;
        self.physicsBody.contactTestBitMask = blockCategory;
        
        SKEmitterNode *fireEmitter = [SpriteGraphicsUtilites newFireEmitter];
        fireEmitter.position = CGPointMake(0.0, -142.0); //Coordonnées trouvées à la main...
        [self addChild:fireEmitter];
        
        return self;
    }
    return self;
}

-(id)initWithImageNamed:(NSString *)name WithVectorialMove: (BOOL)vectorialMode{
    if (self = [super init]) {
        vectorialMove = vectorialMode;
        life = 10;
        //self = [SKSpriteNode spriteNodeWithImageNamed:@"Image.png"];
        self.anchorPoint = CGPointMake(0.5, 0.5);
        CGFloat offsetX = self.frame.size.width * self.anchorPoint.x;
        CGFloat offsetY = self.frame.size.height * self.anchorPoint.y;
        
        /****** Création des contours physiques du vaisseau (au sens pour le moteur physique) *********/
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 114 - offsetX, 396 - offsetY);
        CGPathAddLineToPoint(path, NULL, 41 - offsetX, 282 - offsetY);
        CGPathAddLineToPoint(path, NULL, 14 - offsetX, 3 - offsetY);
        CGPathAddLineToPoint(path, NULL, 218 - offsetX, 3 - offsetY);
        CGPathAddLineToPoint(path, NULL, 181 - offsetX, 296 - offsetY);
        
        CGPathCloseSubpath(path);
        self.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
        if (vectorialMove) {
            self.physicsBody.dynamic = YES;
            self.physicsBody.affectedByGravity = NO;
            self.physicsBody.mass = 1000.0;
        } else {
            self.physicsBody.dynamic = NO;
        }
        /********* Propriétés du vaisseau permettant de définir avec quoi il s'entrechoque *********/
        self.physicsBody.categoryBitMask = playerCategory;
        self.physicsBody.collisionBitMask = blockCategory;
        self.physicsBody.contactTestBitMask = blockCategory;
        
        SKEmitterNode *fireEmitter = [SpriteGraphicsUtilites newFireEmitter];
        fireEmitter.position = CGPointMake(0.0, -142.0); //Coordonnées trouvées à la main...
        [self addChild:fireEmitter];
        
        return self;
    }
    return self;
}

@end
