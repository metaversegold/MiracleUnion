using ProtoBuf;

[ProtoContract]
public class MarryPartyData
{
    /// <summary>
    /// 角色ID
    /// </summary>
    [ProtoMember(1)]
    public int RoleID = -1;

    /// <summary>
    /// 婚宴类型
    /// </summary>
    [ProtoMember(2)]
    public int PartyType = -1;

    /// <summary>
    /// 參予次数
    /// </summary>
    [ProtoMember(3)]
    public int JoinCount = 0;

    /// <summary>
    /// 开始时间
    /// </summary>
    [ProtoMember(4)]
    public long StartTime;

    /// <summary>
    /// 丈夫名字
    /// </summary>
    [ProtoMember(5)]
    public string HuasbandName;

    /// <summary>
    /// 妻子名字
    /// </summary>
    [ProtoMember(6)]
    public string WifeName;

    /// <summary>
    /// 丈夫ID
    /// </summary>
    [ProtoMember(7)]
    public int HuasbandId;

    /// <summary>
    /// 妻子ID
    /// </summary>
    [ProtoMember(8)]
    public int WifeId;

}

