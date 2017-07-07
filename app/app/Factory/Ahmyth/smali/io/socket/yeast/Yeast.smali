.class public final Lio/socket/yeast/Yeast;
.super Ljava/lang/Object;
.source "Yeast.java"


# static fields
.field private static alphabet:[C

.field private static length:I

.field private static map:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/Character;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static prev:Ljava/lang/String;

.field private static seed:I


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    .line 11
    const-string v1, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_"

    invoke-virtual {v1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    sput-object v1, Lio/socket/yeast/Yeast;->alphabet:[C

    .line 13
    sget-object v1, Lio/socket/yeast/Yeast;->alphabet:[C

    array-length v1, v1

    sput v1, Lio/socket/yeast/Yeast;->length:I

    .line 14
    const/4 v1, 0x0

    sput v1, Lio/socket/yeast/Yeast;->seed:I

    .line 16
    new-instance v1, Ljava/util/HashMap;

    sget v2, Lio/socket/yeast/Yeast;->length:I

    invoke-direct {v1, v2}, Ljava/util/HashMap;-><init>(I)V

    sput-object v1, Lio/socket/yeast/Yeast;->map:Ljava/util/Map;

    .line 18
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    sget v1, Lio/socket/yeast/Yeast;->length:I

    if-ge v0, v1, :cond_0

    .line 19
    sget-object v1, Lio/socket/yeast/Yeast;->map:Ljava/util/Map;

    sget-object v2, Lio/socket/yeast/Yeast;->alphabet:[C

    aget-char v2, v2, v0

    invoke-static {v2}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v2

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 18
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 21
    :cond_0
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static decode(Ljava/lang/String;)J
    .locals 12
    .param p0, "str"    # Ljava/lang/String;

    .prologue
    .line 37
    const-wide/16 v2, 0x0

    .line 39
    .local v2, "decoded":J
    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v5

    array-length v6, v5

    const/4 v1, 0x0

    move v4, v1

    :goto_0
    if-ge v4, v6, :cond_0

    aget-char v0, v5, v4

    .line 40
    .local v0, "c":C
    sget v1, Lio/socket/yeast/Yeast;->length:I

    int-to-long v8, v1

    mul-long/2addr v8, v2

    sget-object v1, Lio/socket/yeast/Yeast;->map:Ljava/util/Map;

    invoke-static {v0}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v7

    invoke-interface {v1, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    int-to-long v10, v1

    add-long v2, v8, v10

    .line 39
    add-int/lit8 v1, v4, 0x1

    move v4, v1

    goto :goto_0

    .line 43
    .end local v0    # "c":C
    :cond_0
    return-wide v2
.end method

.method public static encode(J)Ljava/lang/String;
    .locals 8
    .param p0, "num"    # J

    .prologue
    .line 26
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 27
    .local v2, "encoded":Ljava/lang/StringBuilder;
    move-wide v0, p0

    .line 29
    .local v0, "dividedNum":J
    :cond_0
    const/4 v3, 0x0

    sget-object v4, Lio/socket/yeast/Yeast;->alphabet:[C

    sget v5, Lio/socket/yeast/Yeast;->length:I

    int-to-long v6, v5

    rem-long v6, v0, v6

    long-to-int v5, v6

    aget-char v4, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->insert(IC)Ljava/lang/StringBuilder;

    .line 30
    sget v3, Lio/socket/yeast/Yeast;->length:I

    int-to-long v4, v3

    div-long/2addr v0, v4

    .line 31
    const-wide/16 v4, 0x0

    cmp-long v3, v0, v4

    if-gtz v3, :cond_0

    .line 33
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method public static yeast()Ljava/lang/String;
    .locals 4

    .prologue
    .line 47
    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    invoke-static {v2, v3}, Lio/socket/yeast/Yeast;->encode(J)Ljava/lang/String;

    move-result-object v0

    .line 49
    .local v0, "now":Ljava/lang/String;
    sget-object v1, Lio/socket/yeast/Yeast;->prev:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 50
    const/4 v1, 0x0

    sput v1, Lio/socket/yeast/Yeast;->seed:I

    .line 51
    sput-object v0, Lio/socket/yeast/Yeast;->prev:Ljava/lang/String;

    .line 55
    .end local v0    # "now":Ljava/lang/String;
    :goto_0
    return-object v0

    .restart local v0    # "now":Ljava/lang/String;
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lio/socket/yeast/Yeast;->seed:I

    add-int/lit8 v3, v2, 0x1

    sput v3, Lio/socket/yeast/Yeast;->seed:I

    int-to-long v2, v2

    invoke-static {v2, v3}, Lio/socket/yeast/Yeast;->encode(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method
