//
//  RootTableView.h
//  SuBaoJiang
//
//  Created by apple on 15/6/26.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

#define WAIT_TIME       0.68

@protocol RootTableViewDelegate <NSObject>
- (BOOL)doSthWhenfreshingHeader ;
- (BOOL)doSthWhenfreshingFooter ;
@end

@protocol RootTableViewFinished <NSObject>
@optional
- (void)headerRefreshFinished ;
- (void)footerRefreshFinished ;
@end

@interface RootTableView : UITableView <EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView   *_refreshHeaderView ;
    BOOL                        _reloadingHead      ;
    BOOL                        _reloadingFoot      ;
}

@property (nonatomic,weak) id <RootTableViewDelegate> rootDelegate ;
@property (nonatomic,weak) id <RootTableViewFinished> rootFinished ;

@property (nonatomic)       BOOL    shutDownManualPullFooter ;
@property (nonatomic)       BOOL    hideHudForShowNothing ;

/*
 ** default NO ;
 ** if YES     : when no data is return  , show a img in the front ;
 **/
@property (nonatomic) BOOL isNetSuccess ;

/*
 **  pull down Manually and fresh header
 **/
- (void)pulldownManually ;

/*
 **  write in scroll view delegate
 **/
- (void)rootTableScrollDidScroll:(UIScrollView *)scrollView ;
- (void)rootTableScrollDidEndDragging:(UIScrollView *)scrollView ;

/*
 ** write in tableview delegate
 **/
- (void)loadFooterInTableWillDisplayCellWithCurrentIndexRowOrSection:(NSInteger)currentIndex
                                                           ListCount:(NSInteger)count ;

@end


