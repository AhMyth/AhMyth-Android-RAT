.class final Lokhttp3/internal/ws/WebSocketReader;
.super Ljava/lang/Object;
.source "WebSocketReader.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lokhttp3/internal/ws/WebSocketReader$FrameCallback;
    }
.end annotation


# instance fields
.field closed:Z

.field frameBytesRead:J

.field final frameCallback:Lokhttp3/internal/ws/WebSocketReader$FrameCallback;

.field frameLength:J

.field final isClient:Z

.field isControlFrame:Z

.field isFinalFrame:Z

.field isMasked:Z

.field final maskBuffer:[B

.field final maskKey:[B

.field opcode:I

.field final source:Lokio/BufferedSource;


# direct methods
.method constructor <init>(ZLokio/BufferedSource;Lokhttp3/internal/ws/WebSocketReader$FrameCallback;)V
    .locals 2
    .param p1, "isClient"    # Z
    .param p2, "source"    # Lokio/BufferedSource;
    .param p3, "frameCallback"    # Lokhttp3/internal/ws/WebSocketReader$FrameCallback;

    .prologue
    .line 78
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 75
    const/4 v0, 0x4

    new-array v0, v0, [B

    iput-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->maskKey:[B

    .line 76
    const/16 v0, 0x2000

    new-array v0, v0, [B

    iput-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->maskBuffer:[B

    .line 79
    if-nez p2, :cond_0

    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "source == null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 80
    :cond_0
    if-nez p3, :cond_1

    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "frameCallback == null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 81
    :cond_1
    iput-boolean p1, p0, Lokhttp3/internal/ws/WebSocketReader;->isClient:Z

    .line 82
    iput-object p2, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    .line 83
    iput-object p3, p0, Lokhttp3/internal/ws/WebSocketReader;->frameCallback:Lokhttp3/internal/ws/WebSocketReader$FrameCallback;

    .line 84
    return-void
.end method

.method private readControlFrame()V
    .locals 15
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v14, 0x0

    .line 169
    new-instance v6, Lokio/Buffer;

    invoke-direct {v6}, Lokio/Buffer;-><init>()V

    .line 170
    .local v6, "buffer":Lokio/Buffer;
    iget-wide v0, p0, Lokhttp3/internal/ws/WebSocketReader;->frameBytesRead:J

    iget-wide v2, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    cmp-long v0, v0, v2

    if-gez v0, :cond_0

    .line 171
    iget-boolean v0, p0, Lokhttp3/internal/ws/WebSocketReader;->isClient:Z

    if-eqz v0, :cond_2

    .line 172
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    iget-wide v2, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    invoke-interface {v0, v6, v2, v3}, Lokio/BufferedSource;->readFully(Lokio/Buffer;J)V

    .line 185
    :cond_0
    iget v0, p0, Lokhttp3/internal/ws/WebSocketReader;->opcode:I

    packed-switch v0, :pswitch_data_0

    .line 208
    new-instance v0, Ljava/net/ProtocolException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unknown control opcode: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lokhttp3/internal/ws/WebSocketReader;->opcode:I

    invoke-static {v2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 178
    .local v11, "read":I
    .local v13, "toRead":I
    :cond_1
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->maskBuffer:[B

    int-to-long v1, v11

    iget-object v3, p0, Lokhttp3/internal/ws/WebSocketReader;->maskKey:[B

    iget-wide v4, p0, Lokhttp3/internal/ws/WebSocketReader;->frameBytesRead:J

    invoke-static/range {v0 .. v5}, Lokhttp3/internal/ws/WebSocketProtocol;->toggleMask([BJ[BJ)V

    .line 179
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->maskBuffer:[B

    invoke-virtual {v6, v0, v14, v11}, Lokio/Buffer;->write([BII)Lokio/Buffer;

    .line 180
    iget-wide v0, p0, Lokhttp3/internal/ws/WebSocketReader;->frameBytesRead:J

    int-to-long v2, v11

    add-long/2addr v0, v2

    iput-wide v0, p0, Lokhttp3/internal/ws/WebSocketReader;->frameBytesRead:J

    .line 174
    .end local v11    # "read":I
    .end local v13    # "toRead":I
    :cond_2
    iget-wide v0, p0, Lokhttp3/internal/ws/WebSocketReader;->frameBytesRead:J

    iget-wide v2, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    cmp-long v0, v0, v2

    if-gez v0, :cond_0

    .line 175
    iget-wide v0, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    iget-wide v2, p0, Lokhttp3/internal/ws/WebSocketReader;->frameBytesRead:J

    sub-long/2addr v0, v2

    iget-object v2, p0, Lokhttp3/internal/ws/WebSocketReader;->maskBuffer:[B

    array-length v2, v2

    int-to-long v2, v2

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v0

    long-to-int v13, v0

    .line 176
    .restart local v13    # "toRead":I
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketReader;->maskBuffer:[B

    invoke-interface {v0, v1, v14, v13}, Lokio/BufferedSource;->read([BII)I

    move-result v11

    .line 177
    .restart local v11    # "read":I
    const/4 v0, -0x1

    if-ne v11, v0, :cond_1

    new-instance v0, Ljava/io/EOFException;

    invoke-direct {v0}, Ljava/io/EOFException;-><init>()V

    throw v0

    .line 187
    .end local v11    # "read":I
    .end local v13    # "toRead":I
    :pswitch_0
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->frameCallback:Lokhttp3/internal/ws/WebSocketReader$FrameCallback;

    invoke-virtual {v6}, Lokio/Buffer;->readByteString()Lokio/ByteString;

    move-result-object v1

    invoke-interface {v0, v1}, Lokhttp3/internal/ws/WebSocketReader$FrameCallback;->onReadPing(Lokio/ByteString;)V

    .line 210
    :goto_0
    return-void

    .line 190
    :pswitch_1
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->frameCallback:Lokhttp3/internal/ws/WebSocketReader$FrameCallback;

    invoke-virtual {v6}, Lokio/Buffer;->readByteString()Lokio/ByteString;

    move-result-object v1

    invoke-interface {v0, v1}, Lokhttp3/internal/ws/WebSocketReader$FrameCallback;->onReadPong(Lokio/ByteString;)V

    goto :goto_0

    .line 193
    :pswitch_2
    const/16 v7, 0x3ed

    .line 194
    .local v7, "code":I
    const-string v12, ""

    .line 195
    .local v12, "reason":Ljava/lang/String;
    invoke-virtual {v6}, Lokio/Buffer;->size()J

    move-result-wide v8

    .line 196
    .local v8, "bufferSize":J
    const-wide/16 v0, 0x1

    cmp-long v0, v8, v0

    if-nez v0, :cond_3

    .line 197
    new-instance v0, Ljava/net/ProtocolException;

    const-string v1, "Malformed close payload length of 1."

    invoke-direct {v0, v1}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 198
    :cond_3
    const-wide/16 v0, 0x0

    cmp-long v0, v8, v0

    if-eqz v0, :cond_4

    .line 199
    invoke-virtual {v6}, Lokio/Buffer;->readShort()S

    move-result v7

    .line 200
    invoke-virtual {v6}, Lokio/Buffer;->readUtf8()Ljava/lang/String;

    move-result-object v12

    .line 201
    invoke-static {v7}, Lokhttp3/internal/ws/WebSocketProtocol;->closeCodeExceptionMessage(I)Ljava/lang/String;

    move-result-object v10

    .line 202
    .local v10, "codeExceptionMessage":Ljava/lang/String;
    if-eqz v10, :cond_4

    new-instance v0, Ljava/net/ProtocolException;

    invoke-direct {v0, v10}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 204
    .end local v10    # "codeExceptionMessage":Ljava/lang/String;
    :cond_4
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->frameCallback:Lokhttp3/internal/ws/WebSocketReader$FrameCallback;

    invoke-interface {v0, v7, v12}, Lokhttp3/internal/ws/WebSocketReader$FrameCallback;->onReadClose(ILjava/lang/String;)V

    .line 205
    const/4 v0, 0x1

    iput-boolean v0, p0, Lokhttp3/internal/ws/WebSocketReader;->closed:Z

    goto :goto_0

    .line 185
    :pswitch_data_0
    .packed-switch 0x8
        :pswitch_2
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private readHeader()V
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const-wide/16 v12, 0x0

    const/4 v8, 0x1

    const/4 v9, 0x0

    .line 106
    iget-boolean v5, p0, Lokhttp3/internal/ws/WebSocketReader;->closed:Z

    if-eqz v5, :cond_0

    new-instance v5, Ljava/io/IOException;

    const-string v8, "closed"

    invoke-direct {v5, v8}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 110
    :cond_0
    iget-object v5, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    invoke-interface {v5}, Lokio/BufferedSource;->timeout()Lokio/Timeout;

    move-result-object v5

    invoke-virtual {v5}, Lokio/Timeout;->timeoutNanos()J

    move-result-wide v6

    .line 111
    .local v6, "timeoutBefore":J
    iget-object v5, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    invoke-interface {v5}, Lokio/BufferedSource;->timeout()Lokio/Timeout;

    move-result-object v5

    invoke-virtual {v5}, Lokio/Timeout;->clearTimeout()Lokio/Timeout;

    .line 113
    :try_start_0
    iget-object v5, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    invoke-interface {v5}, Lokio/BufferedSource;->readByte()B
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v5

    and-int/lit16 v0, v5, 0xff

    .line 115
    .local v0, "b0":I
    iget-object v5, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    invoke-interface {v5}, Lokio/BufferedSource;->timeout()Lokio/Timeout;

    move-result-object v5

    sget-object v10, Ljava/util/concurrent/TimeUnit;->NANOSECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v5, v6, v7, v10}, Lokio/Timeout;->timeout(JLjava/util/concurrent/TimeUnit;)Lokio/Timeout;

    .line 118
    and-int/lit8 v5, v0, 0xf

    iput v5, p0, Lokhttp3/internal/ws/WebSocketReader;->opcode:I

    .line 119
    and-int/lit16 v5, v0, 0x80

    if-eqz v5, :cond_1

    move v5, v8

    :goto_0
    iput-boolean v5, p0, Lokhttp3/internal/ws/WebSocketReader;->isFinalFrame:Z

    .line 120
    and-int/lit8 v5, v0, 0x8

    if-eqz v5, :cond_2

    move v5, v8

    :goto_1
    iput-boolean v5, p0, Lokhttp3/internal/ws/WebSocketReader;->isControlFrame:Z

    .line 123
    iget-boolean v5, p0, Lokhttp3/internal/ws/WebSocketReader;->isControlFrame:Z

    if-eqz v5, :cond_3

    iget-boolean v5, p0, Lokhttp3/internal/ws/WebSocketReader;->isFinalFrame:Z

    if-nez v5, :cond_3

    .line 124
    new-instance v5, Ljava/net/ProtocolException;

    const-string v8, "Control frames must be final."

    invoke-direct {v5, v8}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 115
    .end local v0    # "b0":I
    :catchall_0
    move-exception v5

    iget-object v8, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    invoke-interface {v8}, Lokio/BufferedSource;->timeout()Lokio/Timeout;

    move-result-object v8

    sget-object v9, Ljava/util/concurrent/TimeUnit;->NANOSECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v8, v6, v7, v9}, Lokio/Timeout;->timeout(JLjava/util/concurrent/TimeUnit;)Lokio/Timeout;

    throw v5

    .restart local v0    # "b0":I
    :cond_1
    move v5, v9

    .line 119
    goto :goto_0

    :cond_2
    move v5, v9

    .line 120
    goto :goto_1

    .line 127
    :cond_3
    and-int/lit8 v5, v0, 0x40

    if-eqz v5, :cond_5

    move v2, v8

    .line 128
    .local v2, "reservedFlag1":Z
    :goto_2
    and-int/lit8 v5, v0, 0x20

    if-eqz v5, :cond_6

    move v3, v8

    .line 129
    .local v3, "reservedFlag2":Z
    :goto_3
    and-int/lit8 v5, v0, 0x10

    if-eqz v5, :cond_7

    move v4, v8

    .line 130
    .local v4, "reservedFlag3":Z
    :goto_4
    if-nez v2, :cond_4

    if-nez v3, :cond_4

    if-eqz v4, :cond_8

    .line 132
    :cond_4
    new-instance v5, Ljava/net/ProtocolException;

    const-string v8, "Reserved flags are unsupported."

    invoke-direct {v5, v8}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v5

    .end local v2    # "reservedFlag1":Z
    .end local v3    # "reservedFlag2":Z
    .end local v4    # "reservedFlag3":Z
    :cond_5
    move v2, v9

    .line 127
    goto :goto_2

    .restart local v2    # "reservedFlag1":Z
    :cond_6
    move v3, v9

    .line 128
    goto :goto_3

    .restart local v3    # "reservedFlag2":Z
    :cond_7
    move v4, v9

    .line 129
    goto :goto_4

    .line 135
    .restart local v4    # "reservedFlag3":Z
    :cond_8
    iget-object v5, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    invoke-interface {v5}, Lokio/BufferedSource;->readByte()B

    move-result v5

    and-int/lit16 v1, v5, 0xff

    .line 137
    .local v1, "b1":I
    and-int/lit16 v5, v1, 0x80

    if-eqz v5, :cond_9

    :goto_5
    iput-boolean v8, p0, Lokhttp3/internal/ws/WebSocketReader;->isMasked:Z

    .line 138
    iget-boolean v5, p0, Lokhttp3/internal/ws/WebSocketReader;->isMasked:Z

    iget-boolean v8, p0, Lokhttp3/internal/ws/WebSocketReader;->isClient:Z

    if-ne v5, v8, :cond_b

    .line 140
    new-instance v8, Ljava/net/ProtocolException;

    iget-boolean v5, p0, Lokhttp3/internal/ws/WebSocketReader;->isClient:Z

    if-eqz v5, :cond_a

    const-string v5, "Server-sent frames must not be masked."

    :goto_6
    invoke-direct {v8, v5}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v8

    :cond_9
    move v8, v9

    .line 137
    goto :goto_5

    .line 140
    :cond_a
    const-string v5, "Client-sent frames must be masked."

    goto :goto_6

    .line 146
    :cond_b
    and-int/lit8 v5, v1, 0x7f

    int-to-long v8, v5

    iput-wide v8, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    .line 147
    iget-wide v8, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    const-wide/16 v10, 0x7e

    cmp-long v5, v8, v10

    if-nez v5, :cond_d

    .line 148
    iget-object v5, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    invoke-interface {v5}, Lokio/BufferedSource;->readShort()S

    move-result v5

    int-to-long v8, v5

    const-wide/32 v10, 0xffff

    and-long/2addr v8, v10

    iput-wide v8, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    .line 156
    :cond_c
    iput-wide v12, p0, Lokhttp3/internal/ws/WebSocketReader;->frameBytesRead:J

    .line 158
    iget-boolean v5, p0, Lokhttp3/internal/ws/WebSocketReader;->isControlFrame:Z

    if-eqz v5, :cond_e

    iget-wide v8, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    const-wide/16 v10, 0x7d

    cmp-long v5, v8, v10

    if-lez v5, :cond_e

    .line 159
    new-instance v5, Ljava/net/ProtocolException;

    const-string v8, "Control frame must be less than 125B."

    invoke-direct {v5, v8}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 149
    :cond_d
    iget-wide v8, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    const-wide/16 v10, 0x7f

    cmp-long v5, v8, v10

    if-nez v5, :cond_c

    .line 150
    iget-object v5, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    invoke-interface {v5}, Lokio/BufferedSource;->readLong()J

    move-result-wide v8

    iput-wide v8, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    .line 151
    iget-wide v8, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    cmp-long v5, v8, v12

    if-gez v5, :cond_c

    .line 152
    new-instance v5, Ljava/net/ProtocolException;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Frame length 0x"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-wide v10, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    .line 153
    invoke-static {v10, v11}, Ljava/lang/Long;->toHexString(J)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " > 0x7FFFFFFFFFFFFFFF"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v5, v8}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 162
    :cond_e
    iget-boolean v5, p0, Lokhttp3/internal/ws/WebSocketReader;->isMasked:Z

    if-eqz v5, :cond_f

    .line 164
    iget-object v5, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    iget-object v8, p0, Lokhttp3/internal/ws/WebSocketReader;->maskKey:[B

    invoke-interface {v5, v8}, Lokio/BufferedSource;->readFully([B)V

    .line 166
    :cond_f
    return-void
.end method

.method private readMessage(Lokio/Buffer;)V
    .locals 14
    .param p1, "sink"    # Lokio/Buffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const-wide/16 v12, -0x1

    const/4 v10, 0x0

    .line 246
    :goto_0
    iget-boolean v0, p0, Lokhttp3/internal/ws/WebSocketReader;->closed:Z

    if-eqz v0, :cond_0

    new-instance v0, Ljava/io/IOException;

    const-string v3, "closed"

    invoke-direct {v0, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 248
    :cond_0
    iget-wide v4, p0, Lokhttp3/internal/ws/WebSocketReader;->frameBytesRead:J

    iget-wide v8, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    cmp-long v0, v4, v8

    if-nez v0, :cond_4

    .line 249
    iget-boolean v0, p0, Lokhttp3/internal/ws/WebSocketReader;->isFinalFrame:Z

    if-eqz v0, :cond_2

    .line 256
    :cond_1
    return-void

    .line 251
    :cond_2
    invoke-virtual {p0}, Lokhttp3/internal/ws/WebSocketReader;->readUntilNonControlFrame()V

    .line 252
    iget v0, p0, Lokhttp3/internal/ws/WebSocketReader;->opcode:I

    if-eqz v0, :cond_3

    .line 253
    new-instance v0, Ljava/net/ProtocolException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Expected continuation opcode. Got: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lokhttp3/internal/ws/WebSocketReader;->opcode:I

    invoke-static {v4}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v3}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 255
    :cond_3
    iget-boolean v0, p0, Lokhttp3/internal/ws/WebSocketReader;->isFinalFrame:Z

    if-eqz v0, :cond_4

    iget-wide v4, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    const-wide/16 v8, 0x0

    cmp-long v0, v4, v8

    if-eqz v0, :cond_1

    .line 260
    :cond_4
    iget-wide v4, p0, Lokhttp3/internal/ws/WebSocketReader;->frameLength:J

    iget-wide v8, p0, Lokhttp3/internal/ws/WebSocketReader;->frameBytesRead:J

    sub-long v6, v4, v8

    .line 263
    .local v6, "toRead":J
    iget-boolean v0, p0, Lokhttp3/internal/ws/WebSocketReader;->isMasked:Z

    if-eqz v0, :cond_7

    .line 264
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->maskBuffer:[B

    array-length v0, v0

    int-to-long v4, v0

    invoke-static {v6, v7, v4, v5}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v6

    .line 265
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    iget-object v3, p0, Lokhttp3/internal/ws/WebSocketReader;->maskBuffer:[B

    long-to-int v4, v6

    invoke-interface {v0, v3, v10, v4}, Lokio/BufferedSource;->read([BII)I

    move-result v0

    int-to-long v1, v0

    .line 266
    .local v1, "read":J
    cmp-long v0, v1, v12

    if-nez v0, :cond_5

    new-instance v0, Ljava/io/EOFException;

    invoke-direct {v0}, Ljava/io/EOFException;-><init>()V

    throw v0

    .line 267
    :cond_5
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->maskBuffer:[B

    iget-object v3, p0, Lokhttp3/internal/ws/WebSocketReader;->maskKey:[B

    iget-wide v4, p0, Lokhttp3/internal/ws/WebSocketReader;->frameBytesRead:J

    invoke-static/range {v0 .. v5}, Lokhttp3/internal/ws/WebSocketProtocol;->toggleMask([BJ[BJ)V

    .line 268
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->maskBuffer:[B

    long-to-int v3, v1

    invoke-virtual {p1, v0, v10, v3}, Lokio/Buffer;->write([BII)Lokio/Buffer;

    .line 274
    :cond_6
    iget-wide v4, p0, Lokhttp3/internal/ws/WebSocketReader;->frameBytesRead:J

    add-long/2addr v4, v1

    iput-wide v4, p0, Lokhttp3/internal/ws/WebSocketReader;->frameBytesRead:J

    goto/16 :goto_0

    .line 270
    .end local v1    # "read":J
    :cond_7
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketReader;->source:Lokio/BufferedSource;

    invoke-interface {v0, p1, v6, v7}, Lokio/BufferedSource;->read(Lokio/Buffer;J)J

    move-result-wide v1

    .line 271
    .restart local v1    # "read":J
    cmp-long v0, v1, v12

    if-nez v0, :cond_6

    new-instance v0, Ljava/io/EOFException;

    invoke-direct {v0}, Ljava/io/EOFException;-><init>()V

    throw v0
.end method

.method private readMessageFrame()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v3, 0x1

    .line 213
    iget v1, p0, Lokhttp3/internal/ws/WebSocketReader;->opcode:I

    .line 214
    .local v1, "opcode":I
    if-eq v1, v3, :cond_0

    const/4 v2, 0x2

    if-eq v1, v2, :cond_0

    .line 215
    new-instance v2, Ljava/net/ProtocolException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Unknown opcode: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/net/ProtocolException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 218
    :cond_0
    new-instance v0, Lokio/Buffer;

    invoke-direct {v0}, Lokio/Buffer;-><init>()V

    .line 219
    .local v0, "message":Lokio/Buffer;
    invoke-direct {p0, v0}, Lokhttp3/internal/ws/WebSocketReader;->readMessage(Lokio/Buffer;)V

    .line 221
    if-ne v1, v3, :cond_1

    .line 222
    iget-object v2, p0, Lokhttp3/internal/ws/WebSocketReader;->frameCallback:Lokhttp3/internal/ws/WebSocketReader$FrameCallback;

    invoke-virtual {v0}, Lokio/Buffer;->readUtf8()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Lokhttp3/internal/ws/WebSocketReader$FrameCallback;->onReadMessage(Ljava/lang/String;)V

    .line 226
    :goto_0
    return-void

    .line 224
    :cond_1
    iget-object v2, p0, Lokhttp3/internal/ws/WebSocketReader;->frameCallback:Lokhttp3/internal/ws/WebSocketReader$FrameCallback;

    invoke-virtual {v0}, Lokio/Buffer;->readByteString()Lokio/ByteString;

    move-result-object v3

    invoke-interface {v2, v3}, Lokhttp3/internal/ws/WebSocketReader$FrameCallback;->onReadMessage(Lokio/ByteString;)V

    goto :goto_0
.end method


# virtual methods
.method processNextFrame()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 97
    invoke-direct {p0}, Lokhttp3/internal/ws/WebSocketReader;->readHeader()V

    .line 98
    iget-boolean v0, p0, Lokhttp3/internal/ws/WebSocketReader;->isControlFrame:Z

    if-eqz v0, :cond_0

    .line 99
    invoke-direct {p0}, Lokhttp3/internal/ws/WebSocketReader;->readControlFrame()V

    .line 103
    :goto_0
    return-void

    .line 101
    :cond_0
    invoke-direct {p0}, Lokhttp3/internal/ws/WebSocketReader;->readMessageFrame()V

    goto :goto_0
.end method

.method readUntilNonControlFrame()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 230
    :goto_0
    iget-boolean v0, p0, Lokhttp3/internal/ws/WebSocketReader;->closed:Z

    if-nez v0, :cond_0

    .line 231
    invoke-direct {p0}, Lokhttp3/internal/ws/WebSocketReader;->readHeader()V

    .line 232
    iget-boolean v0, p0, Lokhttp3/internal/ws/WebSocketReader;->isControlFrame:Z

    if-nez v0, :cond_1

    .line 237
    :cond_0
    return-void

    .line 235
    :cond_1
    invoke-direct {p0}, Lokhttp3/internal/ws/WebSocketReader;->readControlFrame()V

    goto :goto_0
.end method
