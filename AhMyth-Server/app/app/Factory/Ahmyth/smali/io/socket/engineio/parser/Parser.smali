.class public Lio/socket/engineio/parser/Parser;
.super Ljava/lang/Object;
.source "Parser.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/socket/engineio/parser/Parser$DecodePayloadCallback;,
        Lio/socket/engineio/parser/Parser$EncodeCallback;
    }
.end annotation


# static fields
.field private static final MAX_INT_CHAR_LENGTH:I

.field public static final PROTOCOL:I = 0x3

.field private static err:Lio/socket/engineio/parser/Packet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lio/socket/engineio/parser/Packet",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final packets:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static final packetslist:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    .line 15
    const v1, 0x7fffffff

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    sput v1, Lio/socket/engineio/parser/Parser;->MAX_INT_CHAR_LENGTH:I

    .line 19
    new-instance v1, Lio/socket/engineio/parser/Parser$1;

    invoke-direct {v1}, Lio/socket/engineio/parser/Parser$1;-><init>()V

    sput-object v1, Lio/socket/engineio/parser/Parser;->packets:Ljava/util/Map;

    .line 29
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    sput-object v1, Lio/socket/engineio/parser/Parser;->packetslist:Ljava/util/Map;

    .line 31
    sget-object v1, Lio/socket/engineio/parser/Parser;->packets:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v0, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/Integer;>;"
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/Integer;>;"
    check-cast v0, Ljava/util/Map$Entry;

    .line 32
    .restart local v0    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/Integer;>;"
    sget-object v2, Lio/socket/engineio/parser/Parser;->packetslist:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    invoke-interface {v2, v3, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 36
    :cond_0
    new-instance v1, Lio/socket/engineio/parser/Packet;

    const-string v2, "error"

    const-string v3, "parser error"

    invoke-direct {v1, v2, v3}, Lio/socket/engineio/parser/Packet;-><init>(Ljava/lang/String;Ljava/lang/Object;)V

    sput-object v1, Lio/socket/engineio/parser/Parser;->err:Lio/socket/engineio/parser/Packet;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;)[B
    .locals 1
    .param p0, "x0"    # Ljava/lang/String;

    .prologue
    .line 13
    invoke-static {p0}, Lio/socket/engineio/parser/Parser;->stringToByteArray(Ljava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method private static byteArrayToString([B)Ljava/lang/String;
    .locals 5
    .param p0, "bytes"    # [B

    .prologue
    .line 261
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 262
    .local v1, "builder":Ljava/lang/StringBuilder;
    array-length v3, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v3, :cond_0

    aget-byte v0, p0, v2

    .line 263
    .local v0, "b":B
    and-int/lit16 v4, v0, 0xff

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->appendCodePoint(I)Ljava/lang/StringBuilder;

    .line 262
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 265
    .end local v0    # "b":B
    :cond_0
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method public static decodePacket(Ljava/lang/String;)Lio/socket/engineio/parser/Packet;
    .locals 1
    .param p0, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lio/socket/engineio/parser/Packet",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 75
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lio/socket/engineio/parser/Parser;->decodePacket(Ljava/lang/String;Z)Lio/socket/engineio/parser/Packet;

    move-result-object v0

    return-object v0
.end method

.method public static decodePacket(Ljava/lang/String;Z)Lio/socket/engineio/parser/Packet;
    .locals 6
    .param p0, "data"    # Ljava/lang/String;
    .param p1, "utf8decode"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Z)",
            "Lio/socket/engineio/parser/Packet",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v5, 0x1

    .line 81
    const/4 v2, 0x0

    :try_start_0
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->getNumericValue(C)I
    :try_end_0
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 86
    .local v1, "type":I
    :goto_0
    if-eqz p1, :cond_0

    .line 88
    :try_start_1
    invoke-static {p0}, Lio/socket/utf8/UTF8;->decode(Ljava/lang/String;)Ljava/lang/String;
    :try_end_1
    .catch Lio/socket/utf8/UTF8Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object p0

    .line 94
    :cond_0
    if-ltz v1, :cond_1

    sget-object v2, Lio/socket/engineio/parser/Parser;->packetslist:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->size()I

    move-result v2

    if-lt v1, v2, :cond_2

    .line 95
    :cond_1
    sget-object v2, Lio/socket/engineio/parser/Parser;->err:Lio/socket/engineio/parser/Packet;

    .line 101
    :goto_1
    return-object v2

    .line 82
    .end local v1    # "type":I
    :catch_0
    move-exception v0

    .line 83
    .local v0, "e":Ljava/lang/IndexOutOfBoundsException;
    const/4 v1, -0x1

    .restart local v1    # "type":I
    goto :goto_0

    .line 89
    .end local v0    # "e":Ljava/lang/IndexOutOfBoundsException;
    :catch_1
    move-exception v0

    .line 90
    .local v0, "e":Lio/socket/utf8/UTF8Exception;
    sget-object v2, Lio/socket/engineio/parser/Parser;->err:Lio/socket/engineio/parser/Packet;

    goto :goto_1

    .line 98
    .end local v0    # "e":Lio/socket/utf8/UTF8Exception;
    :cond_2
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-le v2, v5, :cond_3

    .line 99
    new-instance v3, Lio/socket/engineio/parser/Packet;

    sget-object v2, Lio/socket/engineio/parser/Parser;->packetslist:Ljava/util/Map;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {p0, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v2, v4}, Lio/socket/engineio/parser/Packet;-><init>(Ljava/lang/String;Ljava/lang/Object;)V

    move-object v2, v3

    goto :goto_1

    .line 101
    :cond_3
    new-instance v3, Lio/socket/engineio/parser/Packet;

    sget-object v2, Lio/socket/engineio/parser/Parser;->packetslist:Ljava/util/Map;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-direct {v3, v2}, Lio/socket/engineio/parser/Packet;-><init>(Ljava/lang/String;)V

    move-object v2, v3

    goto :goto_1
.end method

.method public static decodePacket([B)Lio/socket/engineio/parser/Packet;
    .locals 5
    .param p0, "data"    # [B
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B)",
            "Lio/socket/engineio/parser/Packet",
            "<[B>;"
        }
    .end annotation

    .prologue
    const/4 v4, 0x0

    .line 106
    aget-byte v1, p0, v4

    .line 107
    .local v1, "type":I
    array-length v2, p0

    add-int/lit8 v2, v2, -0x1

    new-array v0, v2, [B

    .line 108
    .local v0, "intArray":[B
    const/4 v2, 0x1

    array-length v3, v0

    invoke-static {p0, v2, v0, v4, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 109
    new-instance v3, Lio/socket/engineio/parser/Packet;

    sget-object v2, Lio/socket/engineio/parser/Parser;->packetslist:Ljava/util/Map;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v2, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-direct {v3, v2, v0}, Lio/socket/engineio/parser/Packet;-><init>(Ljava/lang/String;Ljava/lang/Object;)V

    return-object v3
.end method

.method public static decodePayload(Ljava/lang/String;Lio/socket/engineio/parser/Parser$DecodePayloadCallback;)V
    .locals 13
    .param p0, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lio/socket/engineio/parser/Parser$DecodePayloadCallback",
            "<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "callback":Lio/socket/engineio/parser/Parser$DecodePayloadCallback;, "Lio/socket/engineio/parser/Parser$DecodePayloadCallback<Ljava/lang/String;>;"
    const/4 v12, 0x0

    const/4 v11, 0x1

    .line 153
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v9

    if-nez v9, :cond_2

    .line 154
    :cond_0
    sget-object v9, Lio/socket/engineio/parser/Parser;->err:Lio/socket/engineio/parser/Packet;

    invoke-interface {p1, v9, v12, v11}, Lio/socket/engineio/parser/Parser$DecodePayloadCallback;->call(Lio/socket/engineio/parser/Packet;II)Z

    .line 200
    :cond_1
    :goto_0
    return-void

    .line 158
    :cond_2
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .line 159
    .local v4, "length":Ljava/lang/StringBuilder;
    const/4 v2, 0x0

    .local v2, "i":I
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    .local v3, "l":I
    :goto_1
    if-ge v2, v3, :cond_6

    .line 160
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 162
    .local v0, "chr":C
    const/16 v9, 0x3a

    if-eq v9, v0, :cond_3

    .line 163
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 159
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 167
    :cond_3
    :try_start_0
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v6

    .line 175
    .local v6, "n":I
    add-int/lit8 v9, v2, 0x1

    add-int/lit8 v10, v2, 0x1

    add-int/2addr v10, v6

    :try_start_1
    invoke-virtual {p0, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/IndexOutOfBoundsException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v5

    .line 181
    .local v5, "msg":Ljava/lang/String;
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v9

    if-eqz v9, :cond_5

    .line 182
    invoke-static {v5, v11}, Lio/socket/engineio/parser/Parser;->decodePacket(Ljava/lang/String;Z)Lio/socket/engineio/parser/Packet;

    move-result-object v7

    .line 183
    .local v7, "packet":Lio/socket/engineio/parser/Packet;, "Lio/socket/engineio/parser/Packet<Ljava/lang/String;>;"
    sget-object v9, Lio/socket/engineio/parser/Parser;->err:Lio/socket/engineio/parser/Packet;

    iget-object v9, v9, Lio/socket/engineio/parser/Packet;->type:Ljava/lang/String;

    iget-object v10, v7, Lio/socket/engineio/parser/Packet;->type:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_4

    sget-object v9, Lio/socket/engineio/parser/Parser;->err:Lio/socket/engineio/parser/Packet;

    iget-object v9, v9, Lio/socket/engineio/parser/Packet;->data:Ljava/lang/Object;

    check-cast v9, Ljava/lang/String;

    iget-object v10, v7, Lio/socket/engineio/parser/Packet;->data:Ljava/lang/Object;

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_4

    .line 184
    sget-object v9, Lio/socket/engineio/parser/Parser;->err:Lio/socket/engineio/parser/Packet;

    invoke-interface {p1, v9, v12, v11}, Lio/socket/engineio/parser/Parser$DecodePayloadCallback;->call(Lio/socket/engineio/parser/Packet;II)Z

    goto :goto_0

    .line 168
    .end local v5    # "msg":Ljava/lang/String;
    .end local v6    # "n":I
    .end local v7    # "packet":Lio/socket/engineio/parser/Packet;, "Lio/socket/engineio/parser/Packet<Ljava/lang/String;>;"
    :catch_0
    move-exception v1

    .line 169
    .local v1, "e":Ljava/lang/NumberFormatException;
    sget-object v9, Lio/socket/engineio/parser/Parser;->err:Lio/socket/engineio/parser/Packet;

    invoke-interface {p1, v9, v12, v11}, Lio/socket/engineio/parser/Parser$DecodePayloadCallback;->call(Lio/socket/engineio/parser/Packet;II)Z

    goto :goto_0

    .line 176
    .end local v1    # "e":Ljava/lang/NumberFormatException;
    .restart local v6    # "n":I
    :catch_1
    move-exception v1

    .line 177
    .local v1, "e":Ljava/lang/IndexOutOfBoundsException;
    sget-object v9, Lio/socket/engineio/parser/Parser;->err:Lio/socket/engineio/parser/Packet;

    invoke-interface {p1, v9, v12, v11}, Lio/socket/engineio/parser/Parser$DecodePayloadCallback;->call(Lio/socket/engineio/parser/Packet;II)Z

    goto :goto_0

    .line 188
    .end local v1    # "e":Ljava/lang/IndexOutOfBoundsException;
    .restart local v5    # "msg":Ljava/lang/String;
    .restart local v7    # "packet":Lio/socket/engineio/parser/Packet;, "Lio/socket/engineio/parser/Packet<Ljava/lang/String;>;"
    :cond_4
    add-int v9, v2, v6

    invoke-interface {p1, v7, v9, v3}, Lio/socket/engineio/parser/Parser$DecodePayloadCallback;->call(Lio/socket/engineio/parser/Packet;II)Z

    move-result v8

    .line 189
    .local v8, "ret":Z
    if-eqz v8, :cond_1

    .line 192
    .end local v7    # "packet":Lio/socket/engineio/parser/Packet;, "Lio/socket/engineio/parser/Packet<Ljava/lang/String;>;"
    .end local v8    # "ret":Z
    :cond_5
    add-int/2addr v2, v6

    .line 193
    new-instance v4, Ljava/lang/StringBuilder;

    .end local v4    # "length":Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .restart local v4    # "length":Ljava/lang/StringBuilder;
    goto :goto_2

    .line 197
    .end local v0    # "chr":C
    .end local v5    # "msg":Ljava/lang/String;
    .end local v6    # "n":I
    :cond_6
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I

    move-result v9

    if-lez v9, :cond_1

    .line 198
    sget-object v9, Lio/socket/engineio/parser/Parser;->err:Lio/socket/engineio/parser/Packet;

    invoke-interface {p1, v9, v12, v11}, Lio/socket/engineio/parser/Parser$DecodePayloadCallback;->call(Lio/socket/engineio/parser/Packet;II)Z

    goto :goto_0
.end method

.method public static decodePayload([BLio/socket/engineio/parser/Parser$DecodePayloadCallback;)V
    .locals 16
    .param p0, "data"    # [B
    .param p1, "callback"    # Lio/socket/engineio/parser/Parser$DecodePayloadCallback;

    .prologue
    .line 203
    invoke-static/range {p0 .. p0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 204
    .local v2, "bufferTail":Ljava/nio/ByteBuffer;
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 206
    .local v3, "buffers":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    :goto_0
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v13

    if-lez v13, :cond_6

    .line 207
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    .line 208
    .local v9, "strLen":Ljava/lang/StringBuilder;
    const/4 v13, 0x0

    invoke-virtual {v2, v13}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v13

    and-int/lit16 v13, v13, 0xff

    if-nez v13, :cond_1

    const/4 v5, 0x1

    .line 209
    .local v5, "isString":Z
    :goto_1
    const/4 v8, 0x0

    .line 210
    .local v8, "numberTooLong":Z
    const/4 v4, 0x1

    .line 211
    .local v4, "i":I
    :goto_2
    invoke-virtual {v2, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v13

    and-int/lit16 v0, v13, 0xff

    .line 212
    .local v0, "b":I
    const/16 v13, 0xff

    if-ne v0, v13, :cond_2

    .line 220
    :goto_3
    if-eqz v8, :cond_4

    .line 222
    move-object/from16 v10, p1

    .line 223
    .local v10, "tempCallback":Lio/socket/engineio/parser/Parser$DecodePayloadCallback;, "Lio/socket/engineio/parser/Parser$DecodePayloadCallback<Ljava/lang/String;>;"
    sget-object v13, Lio/socket/engineio/parser/Parser;->err:Lio/socket/engineio/parser/Packet;

    const/4 v14, 0x0

    const/4 v15, 0x1

    invoke-interface {v10, v13, v14, v15}, Lio/socket/engineio/parser/Parser$DecodePayloadCallback;->call(Lio/socket/engineio/parser/Packet;II)Z

    .line 258
    .end local v0    # "b":I
    .end local v5    # "isString":Z
    .end local v8    # "numberTooLong":Z
    .end local v9    # "strLen":Ljava/lang/StringBuilder;
    .end local v10    # "tempCallback":Lio/socket/engineio/parser/Parser$DecodePayloadCallback;, "Lio/socket/engineio/parser/Parser$DecodePayloadCallback<Ljava/lang/String;>;"
    :cond_0
    return-void

    .line 208
    .end local v4    # "i":I
    .restart local v9    # "strLen":Ljava/lang/StringBuilder;
    :cond_1
    const/4 v5, 0x0

    goto :goto_1

    .line 214
    .restart local v0    # "b":I
    .restart local v4    # "i":I
    .restart local v5    # "isString":Z
    .restart local v8    # "numberTooLong":Z
    :cond_2
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->length()I

    move-result v13

    sget v14, Lio/socket/engineio/parser/Parser;->MAX_INT_CHAR_LENGTH:I

    if-le v13, v14, :cond_3

    .line 215
    const/4 v8, 0x1

    .line 216
    goto :goto_3

    .line 218
    :cond_3
    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 210
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 226
    :cond_4
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->length()I

    move-result v13

    add-int/lit8 v13, v13, 0x1

    invoke-virtual {v2, v13}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 227
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->slice()Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 229
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-static {v13}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v7

    .line 231
    .local v7, "msgLength":I
    const/4 v13, 0x1

    invoke-virtual {v2, v13}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 232
    add-int/lit8 v13, v7, 0x1

    invoke-virtual {v2, v13}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    .line 233
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v13

    new-array v6, v13, [B

    .line 234
    .local v6, "msg":[B
    invoke-virtual {v2, v6}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 235
    if-eqz v5, :cond_5

    .line 236
    invoke-static {v6}, Lio/socket/engineio/parser/Parser;->byteArrayToString([B)Ljava/lang/String;

    move-result-object v13

    invoke-interface {v3, v13}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 240
    :goto_4
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 241
    add-int/lit8 v13, v7, 0x1

    invoke-virtual {v2, v13}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 242
    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->slice()Ljava/nio/ByteBuffer;

    move-result-object v2

    .line 243
    goto :goto_0

    .line 238
    :cond_5
    invoke-interface {v3, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_4

    .line 245
    .end local v0    # "b":I
    .end local v4    # "i":I
    .end local v5    # "isString":Z
    .end local v6    # "msg":[B
    .end local v7    # "msgLength":I
    .end local v8    # "numberTooLong":Z
    .end local v9    # "strLen":Ljava/lang/StringBuilder;
    :cond_6
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v12

    .line 246
    .local v12, "total":I
    const/4 v4, 0x0

    .restart local v4    # "i":I
    :goto_5
    if-ge v4, v12, :cond_0

    .line 247
    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    .line 248
    .local v1, "buffer":Ljava/lang/Object;
    instance-of v13, v1, Ljava/lang/String;

    if-eqz v13, :cond_8

    .line 250
    move-object/from16 v10, p1

    .line 251
    .restart local v10    # "tempCallback":Lio/socket/engineio/parser/Parser$DecodePayloadCallback;, "Lio/socket/engineio/parser/Parser$DecodePayloadCallback<Ljava/lang/String;>;"
    check-cast v1, Ljava/lang/String;

    .end local v1    # "buffer":Ljava/lang/Object;
    const/4 v13, 0x1

    invoke-static {v1, v13}, Lio/socket/engineio/parser/Parser;->decodePacket(Ljava/lang/String;Z)Lio/socket/engineio/parser/Packet;

    move-result-object v13

    invoke-interface {v10, v13, v4, v12}, Lio/socket/engineio/parser/Parser$DecodePayloadCallback;->call(Lio/socket/engineio/parser/Packet;II)Z

    .line 246
    .end local v10    # "tempCallback":Lio/socket/engineio/parser/Parser$DecodePayloadCallback;, "Lio/socket/engineio/parser/Parser$DecodePayloadCallback<Ljava/lang/String;>;"
    :cond_7
    :goto_6
    add-int/lit8 v4, v4, 0x1

    goto :goto_5

    .line 252
    .restart local v1    # "buffer":Ljava/lang/Object;
    :cond_8
    instance-of v13, v1, [B

    if-eqz v13, :cond_7

    .line 254
    move-object/from16 v11, p1

    .line 255
    .local v11, "tempCallback":Lio/socket/engineio/parser/Parser$DecodePayloadCallback;, "Lio/socket/engineio/parser/Parser$DecodePayloadCallback<[B>;"
    check-cast v1, [B

    .end local v1    # "buffer":Ljava/lang/Object;
    check-cast v1, [B

    invoke-static {v1}, Lio/socket/engineio/parser/Parser;->decodePacket([B)Lio/socket/engineio/parser/Packet;

    move-result-object v13

    invoke-interface {v11, v13, v4, v12}, Lio/socket/engineio/parser/Parser$DecodePayloadCallback;->call(Lio/socket/engineio/parser/Packet;II)Z

    goto :goto_6
.end method

.method private static encodeByteArray(Lio/socket/engineio/parser/Packet;Lio/socket/engineio/parser/Parser$EncodeCallback;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/socket/engineio/parser/Packet",
            "<[B>;",
            "Lio/socket/engineio/parser/Parser$EncodeCallback",
            "<[B>;)V"
        }
    .end annotation

    .prologue
    .local p0, "packet":Lio/socket/engineio/parser/Packet;, "Lio/socket/engineio/parser/Packet<[B>;"
    .local p1, "callback":Lio/socket/engineio/parser/Parser$EncodeCallback;, "Lio/socket/engineio/parser/Parser$EncodeCallback<[B>;"
    const/4 v4, 0x0

    .line 67
    iget-object v0, p0, Lio/socket/engineio/parser/Packet;->data:Ljava/lang/Object;

    check-cast v0, [B

    .line 68
    .local v0, "data":[B
    array-length v2, v0

    add-int/lit8 v2, v2, 0x1

    new-array v1, v2, [B

    .line 69
    .local v1, "resultArray":[B
    sget-object v2, Lio/socket/engineio/parser/Parser;->packets:Ljava/util/Map;

    iget-object v3, p0, Lio/socket/engineio/parser/Packet;->type:Ljava/lang/String;

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->byteValue()B

    move-result v2

    aput-byte v2, v1, v4

    .line 70
    const/4 v2, 0x1

    array-length v3, v0

    invoke-static {v0, v4, v1, v2, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 71
    invoke-interface {p1, v1}, Lio/socket/engineio/parser/Parser$EncodeCallback;->call(Ljava/lang/Object;)V

    .line 72
    return-void
.end method

.method public static encodePacket(Lio/socket/engineio/parser/Packet;Lio/socket/engineio/parser/Parser$EncodeCallback;)V
    .locals 1
    .param p0, "packet"    # Lio/socket/engineio/parser/Packet;
    .param p1, "callback"    # Lio/socket/engineio/parser/Parser$EncodeCallback;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .prologue
    .line 42
    const/4 v0, 0x0

    invoke-static {p0, v0, p1}, Lio/socket/engineio/parser/Parser;->encodePacket(Lio/socket/engineio/parser/Packet;ZLio/socket/engineio/parser/Parser$EncodeCallback;)V

    .line 43
    return-void
.end method

.method public static encodePacket(Lio/socket/engineio/parser/Packet;ZLio/socket/engineio/parser/Parser$EncodeCallback;)V
    .locals 6
    .param p0, "packet"    # Lio/socket/engineio/parser/Packet;
    .param p1, "utf8encode"    # Z
    .param p2, "callback"    # Lio/socket/engineio/parser/Parser$EncodeCallback;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .prologue
    .line 46
    iget-object v4, p0, Lio/socket/engineio/parser/Packet;->data:Ljava/lang/Object;

    instance-of v4, v4, [B

    if-eqz v4, :cond_0

    .line 48
    move-object v2, p0

    .line 50
    .local v2, "packetToEncode":Lio/socket/engineio/parser/Packet;, "Lio/socket/engineio/parser/Packet<[B>;"
    move-object v0, p2

    .line 51
    .local v0, "callbackToEncode":Lio/socket/engineio/parser/Parser$EncodeCallback;, "Lio/socket/engineio/parser/Parser$EncodeCallback<[B>;"
    invoke-static {v2, v0}, Lio/socket/engineio/parser/Parser;->encodeByteArray(Lio/socket/engineio/parser/Packet;Lio/socket/engineio/parser/Parser$EncodeCallback;)V

    .line 64
    .end local v0    # "callbackToEncode":Lio/socket/engineio/parser/Parser$EncodeCallback;, "Lio/socket/engineio/parser/Parser$EncodeCallback<[B>;"
    .end local v2    # "packetToEncode":Lio/socket/engineio/parser/Packet;, "Lio/socket/engineio/parser/Packet<[B>;"
    :goto_0
    return-void

    .line 55
    :cond_0
    sget-object v4, Lio/socket/engineio/parser/Parser;->packets:Ljava/util/Map;

    iget-object v5, p0, Lio/socket/engineio/parser/Packet;->type:Ljava/lang/String;

    invoke-interface {v4, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 57
    .local v1, "encoded":Ljava/lang/String;
    iget-object v4, p0, Lio/socket/engineio/parser/Packet;->data:Ljava/lang/Object;

    if-eqz v4, :cond_1

    .line 58
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    if-eqz p1, :cond_2

    iget-object v4, p0, Lio/socket/engineio/parser/Packet;->data:Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lio/socket/utf8/UTF8;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_1
    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 62
    :cond_1
    move-object v3, p2

    .line 63
    .local v3, "tempCallback":Lio/socket/engineio/parser/Parser$EncodeCallback;, "Lio/socket/engineio/parser/Parser$EncodeCallback<Ljava/lang/String;>;"
    invoke-interface {v3, v1}, Lio/socket/engineio/parser/Parser$EncodeCallback;->call(Ljava/lang/Object;)V

    goto :goto_0

    .line 58
    .end local v3    # "tempCallback":Lio/socket/engineio/parser/Parser$EncodeCallback;, "Lio/socket/engineio/parser/Parser$EncodeCallback<Ljava/lang/String;>;"
    :cond_2
    iget-object v4, p0, Lio/socket/engineio/parser/Packet;->data:Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    goto :goto_1
.end method

.method public static encodePayload([Lio/socket/engineio/parser/Packet;Lio/socket/engineio/parser/Parser$EncodeCallback;)V
    .locals 6
    .param p0, "packets"    # [Lio/socket/engineio/parser/Packet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Lio/socket/engineio/parser/Packet;",
            "Lio/socket/engineio/parser/Parser$EncodeCallback",
            "<[B>;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .prologue
    .local p1, "callback":Lio/socket/engineio/parser/Parser$EncodeCallback;, "Lio/socket/engineio/parser/Parser$EncodeCallback<[B>;"
    const/4 v2, 0x0

    .line 113
    array-length v3, p0

    if-nez v3, :cond_0

    .line 114
    new-array v2, v2, [B

    invoke-interface {p1, v2}, Lio/socket/engineio/parser/Parser$EncodeCallback;->call(Ljava/lang/Object;)V

    .line 150
    :goto_0
    return-void

    .line 118
    :cond_0
    new-instance v1, Ljava/util/ArrayList;

    array-length v3, p0

    invoke-direct {v1, v3}, Ljava/util/ArrayList;-><init>(I)V

    .line 120
    .local v1, "results":Ljava/util/ArrayList;, "Ljava/util/ArrayList<[B>;"
    array-length v3, p0

    :goto_1
    if-ge v2, v3, :cond_1

    aget-object v0, p0, v2

    .line 121
    .local v0, "packet":Lio/socket/engineio/parser/Packet;
    const/4 v4, 0x1

    new-instance v5, Lio/socket/engineio/parser/Parser$2;

    invoke-direct {v5, v1}, Lio/socket/engineio/parser/Parser$2;-><init>(Ljava/util/ArrayList;)V

    invoke-static {v0, v4, v5}, Lio/socket/engineio/parser/Parser;->encodePacket(Lio/socket/engineio/parser/Packet;ZLio/socket/engineio/parser/Parser$EncodeCallback;)V

    .line 120
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 149
    .end local v0    # "packet":Lio/socket/engineio/parser/Packet;
    :cond_1
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v2

    new-array v2, v2, [[B

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [[B

    invoke-static {v2}, Lio/socket/engineio/parser/Buffer;->concat([[B)[B

    move-result-object v2

    invoke-interface {p1, v2}, Lio/socket/engineio/parser/Parser$EncodeCallback;->call(Ljava/lang/Object;)V

    goto :goto_0
.end method

.method private static stringToByteArray(Ljava/lang/String;)[B
    .locals 4
    .param p0, "string"    # Ljava/lang/String;

    .prologue
    .line 269
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    .line 270
    .local v2, "len":I
    new-array v0, v2, [B

    .line 271
    .local v0, "bytes":[B
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v2, :cond_0

    .line 272
    invoke-static {p0, v1}, Ljava/lang/Character;->codePointAt(Ljava/lang/CharSequence;I)I

    move-result v3

    int-to-byte v3, v3

    aput-byte v3, v0, v1

    .line 271
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 274
    :cond_0
    return-object v0
.end method
