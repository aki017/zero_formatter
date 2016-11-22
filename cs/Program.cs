using System;
using System.IO;
using ZeroFormatter;

namespace ConsoleApplication
{
  public class Program
  {
    public static void Main(string[] args)
    {
      Console.WriteLine("Hello World!");
      var master = new Data{
        Int16                  = -16,
        Int32                  = -32,
        Int64                  = -64,
        UInt16                 = 16,
        UInt32                 = 32,
        UInt64                 = 64,
        Single                 = 1,
        Double                 = 3.1415,
        Boolean                = true,
        Byte                   = 128,
        SByte                  = 127,
        Char                   = 'a',
        TimeSpan               = TimeSpan.FromSeconds(1),
        DateTime               = DateTime.Now,
        DateTimeOffset         = DateTime.Now,
        String                 = "TestString",
        Int16Nullable          = null,
        Int32Nullable          = null,
        Int64Nullable          = null,
        UInt16Nullable         = null,
        UInt32Nullable         = null,
        UInt64Nullable         = null,
        SingleNullable         = null,
        DoubleNullable         = null,
        BooleanNullable        = null,
        ByteNullable           = null,
        SByteNullable          = null,
        CharNullable           = null,
        TimeSpanNullable       = null,
        DateTimeNullable       = null,
        DateTimeOffsetNullable = null,
      };
      var data = ZeroFormatterSerializer.Serialize<Data>(master);

      File.WriteAllBytes("data.pack", data);
    }
  }

  [ZeroFormattable]
  public class Data
  {
    [Index(0)]  public virtual Int16           Int16                  { get; set; }
    [Index(1)]  public virtual Int32           Int32                  { get; set; }
    [Index(2)]  public virtual Int64           Int64                  { get; set; }
    [Index(3)]  public virtual UInt16          UInt16                 { get; set; }
    [Index(4)]  public virtual UInt32          UInt32                 { get; set; }
    [Index(5)]  public virtual UInt64          UInt64                 { get; set; }
    [Index(6)]  public virtual Single          Single                 { get; set; }
    [Index(7)]  public virtual Double          Double                 { get; set; }
    [Index(8)]  public virtual Boolean         Boolean                { get; set; }
    [Index(9)]  public virtual Byte            Byte                   { get; set; }
    [Index(10)] public virtual SByte           SByte                  { get; set; }
    [Index(11)] public virtual Char            Char                   { get; set; }
    [Index(12)] public virtual TimeSpan        TimeSpan               { get; set; }
    [Index(13)] public virtual DateTime        DateTime               { get; set; }
    [Index(14)] public virtual DateTimeOffset  DateTimeOffset         { get; set; }
    [Index(15)] public virtual String          String                 { get; set; }
    [Index(16)] public virtual Int16?          Int16Nullable          { get; set; }
    [Index(17)] public virtual Int32?          Int32Nullable          { get; set; }
    [Index(18)] public virtual Int64?          Int64Nullable          { get; set; }
    [Index(19)] public virtual UInt16?         UInt16Nullable         { get; set; }
    [Index(20)] public virtual UInt32?         UInt32Nullable         { get; set; }
    [Index(21)] public virtual UInt64?         UInt64Nullable         { get; set; }
    [Index(22)] public virtual Single?         SingleNullable         { get; set; }
    [Index(23)] public virtual Double?         DoubleNullable         { get; set; }
    [Index(24)] public virtual Boolean?        BooleanNullable        { get; set; }
    [Index(25)] public virtual Byte?           ByteNullable           { get; set; }
    [Index(26)] public virtual SByte?          SByteNullable          { get; set; }
    [Index(27)] public virtual Char?           CharNullable           { get; set; }
    [Index(28)] public virtual TimeSpan?       TimeSpanNullable       { get; set; }
    [Index(29)] public virtual DateTime?       DateTimeNullable       { get; set; }
    [Index(30)] public virtual DateTimeOffset? DateTimeOffsetNullable { get; set; }
  }
}
