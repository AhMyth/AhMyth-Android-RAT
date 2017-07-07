.class public final Lio/socket/utf8/UTF8;
.super Ljava/lang/Object;
.source "UTF8.java"


# static fields
.field private static final INVALID_CONTINUATION_BYTE:Ljava/lang/String; = "Invalid continuation byte"

.field private static byteArray:[I

.field private static byteCount:I

.field private static byteIndex:I


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static checkScalarValue(I)V
    .locals 3
    .param p0, "codePoint"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .prologue
    .line 162
    const v0, 0xd800

    if-lt p0, v0, :cond_0

    const v0, 0xdfff

    if-gt p0, v0, :cond_0

    .line 163
    new-instance v0, Lio/socket/utf8/UTF8Exception;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Lone surrogate U+"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 164
    invoke-static {p0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " is not a scalar value"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 168
    :cond_0
    return-void
.end method

.method private static createByte(II)[C
    .locals 1
    .param p0, "codePoint"    # I
    .param p1, "shift"    # I

    .prologue
    .line 78
    shr-int v0, p0, p1

    and-int/lit8 v0, v0, 0x3f

    or-int/lit16 v0, v0, 0x80

    invoke-static {v0}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v0

    return-object v0
.end method

.method public static decode(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "byteString"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .prologue
    .line 34
    invoke-static {p0}, Lio/socket/utf8/UTF8;->ucs2decode(Ljava/lang/String;)[I

    move-result-object v2

    sput-object v2, Lio/socket/utf8/UTF8;->byteArray:[I

    .line 35
    sget-object v2, Lio/socket/utf8/UTF8;->byteArray:[I

    array-length v2, v2

    sput v2, Lio/socket/utf8/UTF8;->byteCount:I

    .line 36
    const/4 v2, 0x0

    sput v2, Lio/socket/utf8/UTF8;->byteIndex:I

    .line 37
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 39
    .local v0, "codePoints":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    :goto_0
    invoke-static {}, Lio/socket/utf8/UTF8;->decodeSymbol()I

    move-result v1

    .local v1, "tmp":I
    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    .line 40
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 42
    :cond_0
    invoke-static {v0}, Lio/socket/utf8/UTF8;->listToArray(Ljava/util/List;)[I

    move-result-object v2

    invoke-static {v2}, Lio/socket/utf8/UTF8;->ucs2encode([I)Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method private static decodeSymbol()I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .prologue
    .line 88
    sget v5, Lio/socket/utf8/UTF8;->byteIndex:I

    sget v6, Lio/socket/utf8/UTF8;->byteCount:I

    if-le v5, v6, :cond_0

    .line 89
    new-instance v5, Lio/socket/utf8/UTF8Exception;

    const-string v6, "Invalid byte index"

    invoke-direct {v5, v6}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v5

    .line 92
    :cond_0
    sget v5, Lio/socket/utf8/UTF8;->byteIndex:I

    sget v6, Lio/socket/utf8/UTF8;->byteCount:I

    if-ne v5, v6, :cond_2

    .line 93
    const/4 v4, -0x1

    .line 131
    .local v0, "byte1":I
    :cond_1
    :goto_0
    return v4

    .line 96
    .end local v0    # "byte1":I
    :cond_2
    sget-object v5, Lio/socket/utf8/UTF8;->byteArray:[I

    sget v6, Lio/socket/utf8/UTF8;->byteIndex:I

    aget v5, v5, v6

    and-int/lit16 v0, v5, 0xff

    .line 97
    .restart local v0    # "byte1":I
    sget v5, Lio/socket/utf8/UTF8;->byteIndex:I

    add-int/lit8 v5, v5, 0x1

    sput v5, Lio/socket/utf8/UTF8;->byteIndex:I

    .line 99
    and-int/lit16 v5, v0, 0x80

    if-nez v5, :cond_3

    move v4, v0

    .line 100
    goto :goto_0

    .line 103
    :cond_3
    and-int/lit16 v5, v0, 0xe0

    const/16 v6, 0xc0

    if-ne v5, v6, :cond_4

    .line 104
    invoke-static {}, Lio/socket/utf8/UTF8;->readContinuationByte()I

    move-result v1

    .line 105
    .local v1, "byte2":I
    and-int/lit8 v5, v0, 0x1f

    shl-int/lit8 v5, v5, 0x6

    or-int v4, v5, v1

    .line 106
    .local v4, "codePoint":I
    const/16 v5, 0x80

    if-ge v4, v5, :cond_1

    .line 109
    new-instance v5, Lio/socket/utf8/UTF8Exception;

    const-string v6, "Invalid continuation byte"

    invoke-direct {v5, v6}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v5

    .line 113
    .end local v1    # "byte2":I
    .end local v4    # "codePoint":I
    :cond_4
    and-int/lit16 v5, v0, 0xf0

    const/16 v6, 0xe0

    if-ne v5, v6, :cond_6

    .line 114
    invoke-static {}, Lio/socket/utf8/UTF8;->readContinuationByte()I

    move-result v1

    .line 115
    .restart local v1    # "byte2":I
    invoke-static {}, Lio/socket/utf8/UTF8;->readContinuationByte()I

    move-result v2

    .line 116
    .local v2, "byte3":I
    and-int/lit8 v5, v0, 0xf

    shl-int/lit8 v5, v5, 0xc

    shl-int/lit8 v6, v1, 0x6

    or-int/2addr v5, v6

    or-int v4, v5, v2

    .line 117
    .restart local v4    # "codePoint":I
    const/16 v5, 0x800

    if-lt v4, v5, :cond_5

    .line 118
    invoke-static {v4}, Lio/socket/utf8/UTF8;->checkScalarValue(I)V

    goto :goto_0

    .line 121
    :cond_5
    new-instance v5, Lio/socket/utf8/UTF8Exception;

    const-string v6, "Invalid continuation byte"

    invoke-direct {v5, v6}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v5

    .line 125
    .end local v1    # "byte2":I
    .end local v2    # "byte3":I
    .end local v4    # "codePoint":I
    :cond_6
    and-int/lit16 v5, v0, 0xf8

    const/16 v6, 0xf0

    if-ne v5, v6, :cond_7

    .line 126
    invoke-static {}, Lio/socket/utf8/UTF8;->readContinuationByte()I

    move-result v1

    .line 127
    .restart local v1    # "byte2":I
    invoke-static {}, Lio/socket/utf8/UTF8;->readContinuationByte()I

    move-result v2

    .line 128
    .restart local v2    # "byte3":I
    invoke-static {}, Lio/socket/utf8/UTF8;->readContinuationByte()I

    move-result v3

    .line 129
    .local v3, "byte4":I
    and-int/lit8 v5, v0, 0xf

    shl-int/lit8 v5, v5, 0x12

    shl-int/lit8 v6, v1, 0xc

    or-int/2addr v5, v6

    shl-int/lit8 v6, v2, 0x6

    or-int/2addr v5, v6

    or-int v4, v5, v3

    .line 130
    .restart local v4    # "codePoint":I
    const/high16 v5, 0x10000

    if-lt v4, v5, :cond_7

    const v5, 0x10ffff

    if-le v4, v5, :cond_1

    .line 135
    .end local v1    # "byte2":I
    .end local v2    # "byte3":I
    .end local v3    # "byte4":I
    .end local v4    # "codePoint":I
    :cond_7
    new-instance v5, Lio/socket/utf8/UTF8Exception;

    const-string v6, "Invalid continuation byte"

    invoke-direct {v5, v6}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v5
.end method

.method public static encode(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "string"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .prologue
    .line 21
    invoke-static {p0}, Lio/socket/utf8/UTF8;->ucs2decode(Ljava/lang/String;)[I

    move-result-object v2

    .line 22
    .local v2, "codePoints":[I
    array-length v4, v2

    .line 23
    .local v4, "length":I
    const/4 v3, -0x1

    .line 25
    .local v3, "index":I
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 26
    .local v0, "byteString":Ljava/lang/StringBuilder;
    :goto_0
    add-int/lit8 v3, v3, 0x1

    if-ge v3, v4, :cond_0

    .line 27
    aget v1, v2, v3

    .line 28
    .local v1, "codePoint":I
    invoke-static {v1}, Lio/socket/utf8/UTF8;->encodeCodePoint(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 30
    .end local v1    # "codePoint":I
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    return-object v5
.end method

.method private static encodeCodePoint(I)Ljava/lang/String;
    .locals 3
    .param p0, "codePoint"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .prologue
    const/4 v2, 0x6

    .line 58
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 59
    .local v0, "symbol":Ljava/lang/StringBuilder;
    and-int/lit8 v1, p0, -0x80

    if-nez v1, :cond_0

    .line 60
    invoke-static {p0}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 74
    :goto_0
    return-object v1

    .line 62
    :cond_0
    and-int/lit16 v1, p0, -0x800

    if-nez v1, :cond_2

    .line 63
    shr-int/lit8 v1, p0, 0x6

    and-int/lit8 v1, v1, 0x1f

    or-int/lit16 v1, v1, 0xc0

    invoke-static {v1}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    .line 73
    :cond_1
    :goto_1
    and-int/lit8 v1, p0, 0x3f

    or-int/lit16 v1, v1, 0x80

    invoke-static {v1}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    .line 74
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    .line 64
    :cond_2
    const/high16 v1, -0x10000

    and-int/2addr v1, p0

    if-nez v1, :cond_3

    .line 65
    invoke-static {p0}, Lio/socket/utf8/UTF8;->checkScalarValue(I)V

    .line 66
    shr-int/lit8 v1, p0, 0xc

    and-int/lit8 v1, v1, 0xf

    or-int/lit16 v1, v1, 0xe0

    invoke-static {v1}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    .line 67
    invoke-static {p0, v2}, Lio/socket/utf8/UTF8;->createByte(II)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 68
    :cond_3
    const/high16 v1, -0x200000

    and-int/2addr v1, p0

    if-nez v1, :cond_1

    .line 69
    shr-int/lit8 v1, p0, 0x12

    and-int/lit8 v1, v1, 0x7

    or-int/lit16 v1, v1, 0xf0

    invoke-static {v1}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    .line 70
    const/16 v1, 0xc

    invoke-static {p0, v1}, Lio/socket/utf8/UTF8;->createByte(II)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    .line 71
    invoke-static {p0, v2}, Lio/socket/utf8/UTF8;->createByte(II)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    goto :goto_1
.end method

.method private static listToArray(Ljava/util/List;)[I
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;)[I"
        }
    .end annotation

    .prologue
    .line 171
    .local p0, "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v2

    .line 172
    .local v2, "size":I
    new-array v0, v2, [I

    .line 173
    .local v0, "array":[I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v2, :cond_0

    .line 174
    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    aput v3, v0, v1

    .line 173
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 176
    :cond_0
    return-object v0
.end method

.method private static readContinuationByte()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .prologue
    .line 139
    sget v1, Lio/socket/utf8/UTF8;->byteIndex:I

    sget v2, Lio/socket/utf8/UTF8;->byteCount:I

    if-lt v1, v2, :cond_0

    .line 140
    new-instance v1, Lio/socket/utf8/UTF8Exception;

    const-string v2, "Invalid byte index"

    invoke-direct {v1, v2}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v1

    .line 143
    :cond_0
    sget-object v1, Lio/socket/utf8/UTF8;->byteArray:[I

    sget v2, Lio/socket/utf8/UTF8;->byteIndex:I

    aget v1, v1, v2

    and-int/lit16 v0, v1, 0xff

    .line 144
    .local v0, "continuationByte":I
    sget v1, Lio/socket/utf8/UTF8;->byteIndex:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lio/socket/utf8/UTF8;->byteIndex:I

    .line 146
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-ne v1, v2, :cond_1

    .line 147
    and-int/lit8 v1, v0, 0x3f

    return v1

    .line 150
    :cond_1
    new-instance v1, Lio/socket/utf8/UTF8Exception;

    const-string v2, "Invalid continuation byte"

    invoke-direct {v1, v2}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private static ucs2decode(Ljava/lang/String;)[I
    .locals 7
    .param p0, "string"    # Ljava/lang/String;

    .prologue
    .line 46
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    .line 47
    .local v3, "length":I
    const/4 v6, 0x0

    invoke-virtual {p0, v6, v3}, Ljava/lang/String;->codePointCount(II)I

    move-result v6

    new-array v4, v6, [I

    .line 48
    .local v4, "output":[I
    const/4 v0, 0x0

    .line 50
    .local v0, "counter":I
    const/4 v2, 0x0

    .local v2, "i":I
    move v1, v0

    .end local v0    # "counter":I
    .local v1, "counter":I
    :goto_0
    if-ge v2, v3, :cond_0

    .line 51
    invoke-virtual {p0, v2}, Ljava/lang/String;->codePointAt(I)I

    move-result v5

    .line 52
    .local v5, "value":I
    add-int/lit8 v0, v1, 0x1

    .end local v1    # "counter":I
    .restart local v0    # "counter":I
    aput v5, v4, v1

    .line 50
    invoke-static {v5}, Ljava/lang/Character;->charCount(I)I

    move-result v6

    add-int/2addr v2, v6

    move v1, v0

    .end local v0    # "counter":I
    .restart local v1    # "counter":I
    goto :goto_0

    .line 54
    .end local v5    # "value":I
    :cond_0
    return-object v4
.end method

.method private static ucs2encode([I)Ljava/lang/String;
    .locals 4
    .param p0, "array"    # [I

    .prologue
    .line 154
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 155
    .local v0, "output":Ljava/lang/StringBuilder;
    array-length v3, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v3, :cond_0

    aget v1, p0, v2

    .line 156
    .local v1, "value":I
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->appendCodePoint(I)Ljava/lang/StringBuilder;

    .line 155
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 158
    .end local v1    # "value":I
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method
