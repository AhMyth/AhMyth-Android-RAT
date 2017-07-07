.class public final Lokhttp3/internal/ws/WebSocketProtocol;
.super Ljava/lang/Object;
.source "WebSocketProtocol.java"


# static fields
.field static final ACCEPT_MAGIC:Ljava/lang/String; = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"

.field static final B0_FLAG_FIN:I = 0x80

.field static final B0_FLAG_RSV1:I = 0x40

.field static final B0_FLAG_RSV2:I = 0x20

.field static final B0_FLAG_RSV3:I = 0x10

.field static final B0_MASK_OPCODE:I = 0xf

.field static final B1_FLAG_MASK:I = 0x80

.field static final B1_MASK_LENGTH:I = 0x7f

.field static final CLOSE_ABNORMAL_TERMINATION:I = 0x3ee

.field static final CLOSE_CLIENT_GOING_AWAY:I = 0x3e9

.field static final CLOSE_MESSAGE_MAX:J = 0x7bL

.field static final CLOSE_NO_STATUS_CODE:I = 0x3ed

.field static final CLOSE_PROTOCOL_EXCEPTION:I = 0x3ea

.field static final OPCODE_BINARY:I = 0x2

.field static final OPCODE_CONTINUATION:I = 0x0

.field static final OPCODE_CONTROL_CLOSE:I = 0x8

.field static final OPCODE_CONTROL_PING:I = 0x9

.field static final OPCODE_CONTROL_PONG:I = 0xa

.field static final OPCODE_FLAG_CONTROL:I = 0x8

.field static final OPCODE_TEXT:I = 0x1

.field static final PAYLOAD_BYTE_MAX:J = 0x7dL

.field static final PAYLOAD_LONG:I = 0x7f

.field static final PAYLOAD_SHORT:I = 0x7e

.field static final PAYLOAD_SHORT_MAX:J = 0xffffL


# direct methods
.method private constructor <init>()V
    .locals 2

    .prologue
    .line 127
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 128
    new-instance v0, Ljava/lang/AssertionError;

    const-string v1, "No instances."

    invoke-direct {v0, v1}, Ljava/lang/AssertionError;-><init>(Ljava/lang/Object;)V

    throw v0
.end method

.method public static acceptHeader(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "key"    # Ljava/lang/String;

    .prologue
    .line 124
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lokio/ByteString;->encodeUtf8(Ljava/lang/String;)Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0}, Lokio/ByteString;->sha1()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0}, Lokio/ByteString;->base64()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static closeCodeExceptionMessage(I)Ljava/lang/String;
    .locals 2
    .param p0, "code"    # I

    .prologue
    .line 109
    const/16 v0, 0x3e8

    if-lt p0, v0, :cond_0

    const/16 v0, 0x1388

    if-lt p0, v0, :cond_1

    .line 110
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Code must be in range [1000,5000): "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 114
    :goto_0
    return-object v0

    .line 111
    :cond_1
    const/16 v0, 0x3ec

    if-lt p0, v0, :cond_2

    const/16 v0, 0x3ee

    if-le p0, v0, :cond_3

    :cond_2
    const/16 v0, 0x3f4

    if-lt p0, v0, :cond_4

    const/16 v0, 0xbb7

    if-gt p0, v0, :cond_4

    .line 112
    :cond_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Code "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " is reserved and may not be used."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 114
    :cond_4
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static toggleMask([BJ[BJ)V
    .locals 6
    .param p0, "buffer"    # [B
    .param p1, "byteCount"    # J
    .param p3, "key"    # [B
    .param p4, "frameBytesRead"    # J

    .prologue
    .line 101
    array-length v2, p3

    .line 102
    .local v2, "keyLength":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    int-to-long v4, v0

    cmp-long v3, v4, p1

    if-gez v3, :cond_0

    .line 103
    int-to-long v4, v2

    rem-long v4, p4, v4

    long-to-int v1, v4

    .line 104
    .local v1, "keyIndex":I
    aget-byte v3, p0, v0

    aget-byte v4, p3, v1

    xor-int/2addr v3, v4

    int-to-byte v3, v3

    aput-byte v3, p0, v0

    .line 102
    add-int/lit8 v0, v0, 0x1

    const-wide/16 v4, 0x1

    add-long/2addr p4, v4

    goto :goto_0

    .line 106
    .end local v1    # "keyIndex":I
    :cond_0
    return-void
.end method

.method static validateCloseCode(I)V
    .locals 2
    .param p0, "code"    # I

    .prologue
    .line 119
    invoke-static {p0}, Lokhttp3/internal/ws/WebSocketProtocol;->closeCodeExceptionMessage(I)Ljava/lang/String;

    move-result-object v0

    .line 120
    .local v0, "message":Ljava/lang/String;
    if-eqz v0, :cond_0

    new-instance v1, Ljava/lang/IllegalArgumentException;

    invoke-direct {v1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 121
    :cond_0
    return-void
.end method
