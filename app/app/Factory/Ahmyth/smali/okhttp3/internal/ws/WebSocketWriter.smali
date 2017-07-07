.class final Lokhttp3/internal/ws/WebSocketWriter;
.super Ljava/lang/Object;
.source "WebSocketWriter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lokhttp3/internal/ws/WebSocketWriter$FrameSink;
    }
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z


# instance fields
.field activeWriter:Z

.field final buffer:Lokio/Buffer;

.field final frameSink:Lokhttp3/internal/ws/WebSocketWriter$FrameSink;

.field final isClient:Z

.field final maskBuffer:[B

.field final maskKey:[B

.field final random:Ljava/util/Random;

.field final sink:Lokio/BufferedSink;

.field writerClosed:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 47
    const-class v0, Lokhttp3/internal/ws/WebSocketWriter;

    invoke-virtual {v0}, Ljava/lang/Class;->desiredAssertionStatus()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    sput-boolean v0, Lokhttp3/internal/ws/WebSocketWriter;->$assertionsDisabled:Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method constructor <init>(ZLokio/BufferedSink;Ljava/util/Random;)V
    .locals 2
    .param p1, "isClient"    # Z
    .param p2, "sink"    # Lokio/BufferedSink;
    .param p3, "random"    # Ljava/util/Random;

    .prologue
    const/4 v1, 0x0

    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 56
    new-instance v0, Lokio/Buffer;

    invoke-direct {v0}, Lokio/Buffer;-><init>()V

    iput-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->buffer:Lokio/Buffer;

    .line 57
    new-instance v0, Lokhttp3/internal/ws/WebSocketWriter$FrameSink;

    invoke-direct {v0, p0}, Lokhttp3/internal/ws/WebSocketWriter$FrameSink;-><init>(Lokhttp3/internal/ws/WebSocketWriter;)V

    iput-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->frameSink:Lokhttp3/internal/ws/WebSocketWriter$FrameSink;

    .line 65
    if-nez p2, :cond_0

    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "sink == null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 66
    :cond_0
    if-nez p3, :cond_1

    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "random == null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 67
    :cond_1
    iput-boolean p1, p0, Lokhttp3/internal/ws/WebSocketWriter;->isClient:Z

    .line 68
    iput-object p2, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    .line 69
    iput-object p3, p0, Lokhttp3/internal/ws/WebSocketWriter;->random:Ljava/util/Random;

    .line 72
    if-eqz p1, :cond_3

    const/4 v0, 0x4

    new-array v0, v0, [B

    :goto_0
    iput-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    .line 73
    if-eqz p1, :cond_2

    const/16 v0, 0x2000

    new-array v1, v0, [B

    :cond_2
    iput-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->maskBuffer:[B

    .line 74
    return-void

    :cond_3
    move-object v0, v1

    .line 72
    goto :goto_0
.end method

.method private writeControlFrameSynchronized(ILokio/ByteString;)V
    .locals 9
    .param p1, "opcode"    # I
    .param p2, "payload"    # Lokio/ByteString;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 121
    sget-boolean v1, Lokhttp3/internal/ws/WebSocketWriter;->$assertionsDisabled:Z

    if-nez v1, :cond_0

    invoke-static {p0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/lang/AssertionError;

    invoke-direct {v1}, Ljava/lang/AssertionError;-><init>()V

    throw v1

    .line 123
    :cond_0
    iget-boolean v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->writerClosed:Z

    if-eqz v1, :cond_1

    new-instance v1, Ljava/io/IOException;

    const-string v2, "closed"

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 125
    :cond_1
    invoke-virtual {p2}, Lokio/ByteString;->size()I

    move-result v8

    .line 126
    .local v8, "length":I
    int-to-long v2, v8

    const-wide/16 v4, 0x7d

    cmp-long v1, v2, v4

    if-lez v1, :cond_2

    .line 127
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Payload size must be less than or equal to 125"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 131
    :cond_2
    or-int/lit16 v6, p1, 0x80

    .line 132
    .local v6, "b0":I
    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    invoke-interface {v1, v6}, Lokio/BufferedSink;->writeByte(I)Lokio/BufferedSink;

    .line 134
    move v7, v8

    .line 135
    .local v7, "b1":I
    iget-boolean v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->isClient:Z

    if-eqz v1, :cond_3

    .line 136
    or-int/lit16 v7, v7, 0x80

    .line 137
    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    invoke-interface {v1, v7}, Lokio/BufferedSink;->writeByte(I)Lokio/BufferedSink;

    .line 139
    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->random:Ljava/util/Random;

    iget-object v2, p0, Lokhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    invoke-virtual {v1, v2}, Ljava/util/Random;->nextBytes([B)V

    .line 140
    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    iget-object v2, p0, Lokhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    invoke-interface {v1, v2}, Lokio/BufferedSink;->write([B)Lokio/BufferedSink;

    .line 142
    invoke-virtual {p2}, Lokio/ByteString;->toByteArray()[B

    move-result-object v0

    .line 143
    .local v0, "bytes":[B
    array-length v1, v0

    int-to-long v1, v1

    iget-object v3, p0, Lokhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    const-wide/16 v4, 0x0

    invoke-static/range {v0 .. v5}, Lokhttp3/internal/ws/WebSocketProtocol;->toggleMask([BJ[BJ)V

    .line 144
    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    invoke-interface {v1, v0}, Lokio/BufferedSink;->write([B)Lokio/BufferedSink;

    .line 150
    .end local v0    # "bytes":[B
    :goto_0
    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    invoke-interface {v1}, Lokio/BufferedSink;->flush()V

    .line 151
    return-void

    .line 146
    :cond_3
    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    invoke-interface {v1, v7}, Lokio/BufferedSink;->writeByte(I)Lokio/BufferedSink;

    .line 147
    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    invoke-interface {v1, p2}, Lokio/BufferedSink;->write(Lokio/ByteString;)Lokio/BufferedSink;

    goto :goto_0
.end method


# virtual methods
.method newMessageSink(IJ)Lokio/Sink;
    .locals 2
    .param p1, "formatOpcode"    # I
    .param p2, "contentLength"    # J

    .prologue
    const/4 v1, 0x1

    .line 158
    iget-boolean v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->activeWriter:Z

    if-eqz v0, :cond_0

    .line 159
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Another message writer is active. Did you call close()?"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 161
    :cond_0
    iput-boolean v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->activeWriter:Z

    .line 164
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->frameSink:Lokhttp3/internal/ws/WebSocketWriter$FrameSink;

    iput p1, v0, Lokhttp3/internal/ws/WebSocketWriter$FrameSink;->formatOpcode:I

    .line 165
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->frameSink:Lokhttp3/internal/ws/WebSocketWriter$FrameSink;

    iput-wide p2, v0, Lokhttp3/internal/ws/WebSocketWriter$FrameSink;->contentLength:J

    .line 166
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->frameSink:Lokhttp3/internal/ws/WebSocketWriter$FrameSink;

    iput-boolean v1, v0, Lokhttp3/internal/ws/WebSocketWriter$FrameSink;->isFirstFrame:Z

    .line 167
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->frameSink:Lokhttp3/internal/ws/WebSocketWriter$FrameSink;

    const/4 v1, 0x0

    iput-boolean v1, v0, Lokhttp3/internal/ws/WebSocketWriter$FrameSink;->closed:Z

    .line 169
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->frameSink:Lokhttp3/internal/ws/WebSocketWriter$FrameSink;

    return-object v0
.end method

.method writeClose(ILokio/ByteString;)V
    .locals 4
    .param p1, "code"    # I
    .param p2, "reason"    # Lokio/ByteString;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 98
    sget-object v1, Lokio/ByteString;->EMPTY:Lokio/ByteString;

    .line 99
    .local v1, "payload":Lokio/ByteString;
    if-nez p1, :cond_0

    if-eqz p2, :cond_3

    .line 100
    :cond_0
    if-eqz p1, :cond_1

    .line 101
    invoke-static {p1}, Lokhttp3/internal/ws/WebSocketProtocol;->validateCloseCode(I)V

    .line 103
    :cond_1
    new-instance v0, Lokio/Buffer;

    invoke-direct {v0}, Lokio/Buffer;-><init>()V

    .line 104
    .local v0, "buffer":Lokio/Buffer;
    invoke-virtual {v0, p1}, Lokio/Buffer;->writeShort(I)Lokio/Buffer;

    .line 105
    if-eqz p2, :cond_2

    .line 106
    invoke-virtual {v0, p2}, Lokio/Buffer;->write(Lokio/ByteString;)Lokio/Buffer;

    .line 108
    :cond_2
    invoke-virtual {v0}, Lokio/Buffer;->readByteString()Lokio/ByteString;

    move-result-object v1

    .line 111
    .end local v0    # "buffer":Lokio/Buffer;
    :cond_3
    monitor-enter p0

    .line 113
    const/16 v2, 0x8

    :try_start_0
    invoke-direct {p0, v2, v1}, Lokhttp3/internal/ws/WebSocketWriter;->writeControlFrameSynchronized(ILokio/ByteString;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 115
    const/4 v2, 0x1

    :try_start_1
    iput-boolean v2, p0, Lokhttp3/internal/ws/WebSocketWriter;->writerClosed:Z

    .line 117
    monitor-exit p0

    .line 118
    return-void

    .line 115
    :catchall_0
    move-exception v2

    const/4 v3, 0x1

    iput-boolean v3, p0, Lokhttp3/internal/ws/WebSocketWriter;->writerClosed:Z

    throw v2

    .line 117
    :catchall_1
    move-exception v2

    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    throw v2
.end method

.method writeMessageFrameSynchronized(IJZZ)V
    .locals 10
    .param p1, "formatOpcode"    # I
    .param p2, "byteCount"    # J
    .param p4, "isFirstFrame"    # Z
    .param p5, "isFinal"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 174
    sget-boolean v0, Lokhttp3/internal/ws/WebSocketWriter;->$assertionsDisabled:Z

    if-nez v0, :cond_0

    invoke-static {p0}, Ljava/lang/Thread;->holdsLock(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 176
    :cond_0
    iget-boolean v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->writerClosed:Z

    if-eqz v0, :cond_1

    new-instance v0, Ljava/io/IOException;

    const-string v1, "closed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 178
    :cond_1
    if-eqz p4, :cond_4

    move v6, p1

    .line 179
    .local v6, "b0":I
    :goto_0
    if-eqz p5, :cond_2

    .line 180
    or-int/lit16 v6, v6, 0x80

    .line 182
    :cond_2
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    invoke-interface {v0, v6}, Lokio/BufferedSink;->writeByte(I)Lokio/BufferedSink;

    .line 184
    const/4 v7, 0x0

    .line 185
    .local v7, "b1":I
    iget-boolean v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->isClient:Z

    if-eqz v0, :cond_3

    .line 186
    or-int/lit16 v7, v7, 0x80

    .line 188
    :cond_3
    const-wide/16 v0, 0x7d

    cmp-long v0, p2, v0

    if-gtz v0, :cond_5

    .line 189
    long-to-int v0, p2

    or-int/2addr v7, v0

    .line 190
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    invoke-interface {v0, v7}, Lokio/BufferedSink;->writeByte(I)Lokio/BufferedSink;

    .line 201
    :goto_1
    iget-boolean v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->isClient:Z

    if-eqz v0, :cond_8

    .line 202
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->random:Ljava/util/Random;

    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    invoke-virtual {v0, v1}, Ljava/util/Random;->nextBytes([B)V

    .line 203
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    invoke-interface {v0, v1}, Lokio/BufferedSink;->write([B)Lokio/BufferedSink;

    .line 205
    const-wide/16 v4, 0x0

    .local v4, "written":J
    :goto_2
    cmp-long v0, v4, p2

    if-gez v0, :cond_9

    .line 206
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->maskBuffer:[B

    array-length v0, v0

    int-to-long v0, v0

    invoke-static {p2, p3, v0, v1}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v0

    long-to-int v9, v0

    .line 207
    .local v9, "toRead":I
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->buffer:Lokio/Buffer;

    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->maskBuffer:[B

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2, v9}, Lokio/Buffer;->read([BII)I

    move-result v8

    .line 208
    .local v8, "read":I
    const/4 v0, -0x1

    if-ne v8, v0, :cond_7

    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0

    .line 178
    .end local v4    # "written":J
    .end local v6    # "b0":I
    .end local v7    # "b1":I
    .end local v8    # "read":I
    .end local v9    # "toRead":I
    :cond_4
    const/4 v6, 0x0

    goto :goto_0

    .line 191
    .restart local v6    # "b0":I
    .restart local v7    # "b1":I
    :cond_5
    const-wide/32 v0, 0xffff

    cmp-long v0, p2, v0

    if-gtz v0, :cond_6

    .line 192
    or-int/lit8 v7, v7, 0x7e

    .line 193
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    invoke-interface {v0, v7}, Lokio/BufferedSink;->writeByte(I)Lokio/BufferedSink;

    .line 194
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    long-to-int v1, p2

    invoke-interface {v0, v1}, Lokio/BufferedSink;->writeShort(I)Lokio/BufferedSink;

    goto :goto_1

    .line 196
    :cond_6
    or-int/lit8 v7, v7, 0x7f

    .line 197
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    invoke-interface {v0, v7}, Lokio/BufferedSink;->writeByte(I)Lokio/BufferedSink;

    .line 198
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    invoke-interface {v0, p2, p3}, Lokio/BufferedSink;->writeLong(J)Lokio/BufferedSink;

    goto :goto_1

    .line 209
    .restart local v4    # "written":J
    .restart local v8    # "read":I
    .restart local v9    # "toRead":I
    :cond_7
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->maskBuffer:[B

    int-to-long v1, v8

    iget-object v3, p0, Lokhttp3/internal/ws/WebSocketWriter;->maskKey:[B

    invoke-static/range {v0 .. v5}, Lokhttp3/internal/ws/WebSocketProtocol;->toggleMask([BJ[BJ)V

    .line 210
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->maskBuffer:[B

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2, v8}, Lokio/BufferedSink;->write([BII)Lokio/BufferedSink;

    .line 211
    int-to-long v0, v8

    add-long/2addr v4, v0

    .line 212
    goto :goto_2

    .line 214
    .end local v4    # "written":J
    .end local v8    # "read":I
    .end local v9    # "toRead":I
    :cond_8
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    iget-object v1, p0, Lokhttp3/internal/ws/WebSocketWriter;->buffer:Lokio/Buffer;

    invoke-interface {v0, v1, p2, p3}, Lokio/BufferedSink;->write(Lokio/Buffer;J)V

    .line 217
    :cond_9
    iget-object v0, p0, Lokhttp3/internal/ws/WebSocketWriter;->sink:Lokio/BufferedSink;

    invoke-interface {v0}, Lokio/BufferedSink;->emit()Lokio/BufferedSink;

    .line 218
    return-void
.end method

.method writePing(Lokio/ByteString;)V
    .locals 1
    .param p1, "payload"    # Lokio/ByteString;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 78
    monitor-enter p0

    .line 79
    const/16 v0, 0x9

    :try_start_0
    invoke-direct {p0, v0, p1}, Lokhttp3/internal/ws/WebSocketWriter;->writeControlFrameSynchronized(ILokio/ByteString;)V

    .line 80
    monitor-exit p0

    .line 81
    return-void

    .line 80
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method writePong(Lokio/ByteString;)V
    .locals 1
    .param p1, "payload"    # Lokio/ByteString;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 85
    monitor-enter p0

    .line 86
    const/16 v0, 0xa

    :try_start_0
    invoke-direct {p0, v0, p1}, Lokhttp3/internal/ws/WebSocketWriter;->writeControlFrameSynchronized(ILokio/ByteString;)V

    .line 87
    monitor-exit p0

    .line 88
    return-void

    .line 87
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method
