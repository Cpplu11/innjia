//
//  INNJPoint.h
//  innjiaios
//
//  Created by wl on 14-11-15.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "BMKCircle.h"
#import "BMKCircleView.h"
#import "BMKAnnotationView.h"
#import "BMKPointAnnotation.h"
#import "BMKAnnotation.h"
#define REUSEID @"Point"

@interface INNJPoint :NSObject <BMKAnnotation>
@property (nonatomic,assign) NSInteger tag;
@property (nonatomic,assign) NSString *key;
@property (nonatomic) CLLocationCoordinate2D coordinate;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
@end

@interface INNJPointView : BMKAnnotationView
@property (nonatomic,strong) UILabel *label;
-(id) initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;
@end
