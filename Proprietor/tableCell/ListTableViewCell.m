//
//  ListTableViewCell.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ListTableViewCell.h"
#import "repairTableModel.h"
#import "baoxiuModel.h"
#import "complainListModel.h"
#import "PublicDefine.h"
@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat CellWidth= self.contentView.frame.size.width-4;
        
        _titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(30,0,CellWidth-30-55,35)];
        _titleLbl.font=[UIFont systemFontOfSize:13];
//        [_titleLbl setLineBreakMode:NSLineBreakByWordWrapping];
//        [_titleLbl setNumberOfLines:0];
        [self addSubview:_titleLbl];
        
        
        _timeLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-90,2,90,35)];
        _timeLbl.font=[UIFont systemFontOfSize:10];
        //_timeLbl.backgroundColor=[UIColor yellowColor];
        //        [_titleLbl setLineBreakMode:NSLineBreakByWordWrapping];
        //        [_titleLbl setNumberOfLines:0];
        [self addSubview:_timeLbl];
        
        _titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(8,10,15,15)];
        //_titleImage.backgroundColor=[UIColor blueColor];
        [self addSubview:_titleImage];
        //_titleImage
        //_titleImage.image=[UIImage imageNamed:@"nshoul"];
        
    }
    return self;
}

-(void)showUiNewsCell:(repairTableModel*)NModel{
    
    _titleLbl.text=NModel.noticeTitle;
    _timeLbl.text=NModel.createTime;
    _titleImage.image=[UIImage imageNamed:@"notice"];
    _cellId=NModel.noticeId;
    _noticeContent=NModel.noticeContent;
}

-(void)showUiBaoxiuCell:(baoxiuModel*)NModel{
    
    _titleLbl.text=NModel.mendTitle;
    _timeLbl.text=NModel.reportTime;
    _titleImage.image=[UIImage imageNamed:@"nshoul"];
    _cellId=NModel.mendId;
    //_noticeContent=NModel.noticeContent;
}

-(void)showUiComplainCell:(complainListModel*)NModel{
    
    _titleLbl.text=NModel.complaintContent;
    _timeLbl.text=NModel.complaintCreatetime;
    _titleImage.image=[UIImage imageNamed:@"nshoul"];
    _cellId=NModel.complaintId;
    //_noticeContent=NModel.noticeContent;
}
@end
