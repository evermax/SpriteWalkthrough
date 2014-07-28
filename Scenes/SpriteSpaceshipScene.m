//
//  SpriteSpaceshipScene.m
//  SpriteWalkthrough
//
//  Created by Maxime Lasserre on 03/04/14.
//  Copyright (c) 2014 Maxime Lasserre. All rights reserved.
//

#import "SpriteSpaceshipScene.h"


@interface SpriteSpaceshipScene ()
@property BOOL contentCreated;
@property NSInteger collisionCounter;
@property SKLabelNode *counterNode;
@property SKSpriteNode *spaceShip;
@property BOOL vectorialMove;
@property float shipSpeed;
@end

@implementation SpriteSpaceshipScene

static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

/****************** Création de la vue lors du déplacement sur celle-ci ***********************/
- (void) didMoveToView:(SKView *)view
{
    //Chercher si le paramètre "view" est la vue de laquelle on vient, comme ça : récupérer des userData 
    if (!self.contentCreated) {
        self.vectorialMove = [[self.userData objectForKey:@"vectorialMode"] boolValue];
        NSLog(@"%hhd", self.vectorialMove);
        [self createSceneContents];
        self.contentCreated = YES;
        self.collisionCounter = 0;
        self.counterNode = [SpriteGraphicsUtilites newCounterNode:self :self.collisionCounter];
        [self addChild: self.counterNode];
        self.shipSpeed = 200.0;
        self.physicsWorld.contactDelegate = self;
        if (self.vectorialMove) {
            self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        }
        /*Permet l'utilisation de la fonction didBeginContact, entre autres.
         Cette propriété dit que la vue doit aller chercher dans elle-même pour
         trouver son délégué aux traitements des interractions physiques.*/
   }
}

/********************************** Création des éléments de la scène ****************************************/
- (void)createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    self.spaceShip = [SpriteSpaceShip newSpaceship:self.vectorialMove];
    self.spaceShip.position = CGPointMake(300,500);
    self.spaceShip.xScale = 0.5;
    self.spaceShip.yScale = 0.5;
    [self addChild: self.spaceShip];
    
    SKAction *makeRockets = [SKAction sequence: @[
                                                  [SKAction performSelector:@selector(addRocket) onTarget:self],
                                                [SKAction waitForDuration:0.10 withRange:0.15]
                                                ]];
    
    SKAction *makeRocketsInCircle = [SKAction sequence: @[
                                                  [SKAction performSelector:@selector(addRocketInCircle) onTarget:self],
                                                  [SKAction waitForDuration:3.0 withRange:0.15]
                                                  ]];
    if (self.vectorialMove) {
        [self runAction: [SKAction repeatActionForever:makeRocketsInCircle]];
    }else{
        [self runAction: [SKAction repeatActionForever:makeRockets]];
    }
}

/********************* Faire disparaitre tous les noeuds qui passent en dessous du bas de l'écran *************************/
-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"rocket" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
}

#pragma mark - Physics Contact Helpers
-(void)didBeginContact:(SKPhysicsContact *)contact
{
    self.collisionCounter++;
    self.counterNode.text = [NSString stringWithFormat:@"Nombre de contact %ld", (long)self.collisionCounter];
    SKAction *pulseRed = [SKAction sequence:@[[SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:1.0 duration:0.1],
                                              [SKAction waitForDuration:0.05],
                                              [SKAction colorizeWithColorBlendFactor:0.0 duration:0.1]]];
    
    SKAction *releaseExplosion = [SKAction sequence:@[[SKAction waitForDuration:0.25],
                                                       [SKAction removeFromParent]]];
    
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    CGFloat contactX = contact.contactPoint.x;
    CGFloat contactY = contact.contactPoint.y;
    
    [[secondBody node] runAction:pulseRed];
    
    SKEmitterNode *sparkEmitter = [SpriteGraphicsUtilites newSparkEmitter];
    sparkEmitter.position = CGPointMake(contactX, contactY); //Coordonnées trouvées à la main...
    [self addChild:sparkEmitter];
    [sparkEmitter runAction:releaseExplosion];

    [[firstBody node] removeFromParent];
}

/************* Fonction qui permet de découvrir ou se passe le contact et de définir des actions dans ce cas ***************/
- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *)event
{
    float distance = 0.0;
    UITouch *touch = [touches anyObject];
    CGPoint locationTouch = [touch locationInNode:self];
    if (self.vectorialMove) {
        CGVector impulse = CGVectorMake(100.0 * (locationTouch.x - self.spaceShip.position.x), 100.0 * (locationTouch.y - self.spaceShip.position.y));
        [self.spaceShip.physicsBody applyImpulse:impulse];
    }else{
        distance = sqrt(powf((locationTouch.x - self.spaceShip.position.x), 2.0) + powf((locationTouch.y - self.spaceShip.position.y), 2.0));
        SKAction *goTo = [SKAction moveTo:locationTouch duration:distance/self.shipSpeed];
        [self.spaceShip runAction:goTo];
    }
}

/******************** SpriteNode rock générique pour les petites roquettes qui apparaissent en haut *************************/
- (void)addRocket
{
    SKSpriteNode *rocket = [SpriteGraphicsUtilites newRocket];
    
    rocket.position = CGPointMake(skRand(0, self.size.width), self.size.height-50);
    [self addChild:rocket];
}

- (void)addRocketInCircle
{
    SKSpriteNode *rocket = [SpriteGraphicsUtilites newRocket];
    
    rocket.position = CGPointMake((self.size.width/2 - 20)*cos(skRand(0, 7)) + self.size.width/2, (self.size.width/2 - 20)*sin(skRand(0, 7)) + self.size.height/2);
    if (self.vectorialMove) {
        rocket.physicsBody.affectedByGravity = NO;
    }
    [self addChild:rocket];
    
    CGVector impulse = CGVectorMake(10.0 * (self.spaceShip.position.y - rocket.position.x), 10.0 * (self.spaceShip.position.y - rocket.position.y));
    [rocket.physicsBody applyImpulse:impulse];
}

@end
