using System;
using System.Collections.Generic;
using Server.Data;

public class EmailData
{
    //信件ID
    public int EmailID = 0;

    //信件标题
    public String Title = "";

    //信件发送时间
    public String Time = "";

    //信件类型
    public int Type = 0;

    //信息状态
    public Boolean State = false;

    //信件发送人
    public String From = "";

    //信件中的内容
    public String NeiRong = "";

    //附件中的物品
    public List<MailGoodsData> GoodsIDList = null;

    //信件中的绑定金币数
    public int TongQianNum = 0;

    //信件中的金币数
    public int YinLiangNum = 0;

    //信件中的钻石数
    public int YuanBaoNum = 0;

    //是否收取过附件，标志位
    //等于0，表示未收取,1为收取
    public int Hasfetchattachment = 0;

}

