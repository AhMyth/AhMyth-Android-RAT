.class public abstract Lio/socket/engineio/client/transports/Polling;
.super Lio/socket/engineio/client/Transport;
.source "Polling.java"


# static fields
.field public static final EVENT_POLL:Ljava/lang/String; = "poll"

.field public static final EVENT_POLL_COMPLETE:Ljava/lang/String; = "pollComplete"

.field public static final NAME:Ljava/lang/String; = "polling"

.field private static final logger:Ljava/util/logging/Logger;


# instance fields
.field private polling:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 19
    const-class v0, Lio/socket/engineio/client/transports/Polling;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lio/socket/engineio/client/transports/Polling;->logger:Ljava/util/logging/Logger;

    return-void
.end method

.method public constructor <init>(Lio/socket/engineio/client/Transport$Options;)V
    .locals 1
    .param p1, "opts"    # Lio/socket/engineio/client/Transport$Options;

    .prologue
    .line 30
    invoke-direct {p0, p1}, Lio/socket/engineio/client/Transport;-><init>(Lio/socket/engineio/client/Transport$Options;)V

    .line 31
    const-string v0, "polling"

    iput-object v0, p0, Lio/socket/engineio/client/transports/Polling;->name:Ljava/lang/String;

    .line 32
    return-void
.end method

.method private _onData(Ljava/lang/Object;)V
    .locals 8
    .param p1, "data"    # Ljava/lang/Object;

    .prologue
    const/4 v6, 0x1

    const/4 v7, 0x0

    .line 110
    move-object v1, p0

    .line 111
    .local v1, "self":Lio/socket/engineio/client/transports/Polling;
    sget-object v3, Lio/socket/engineio/client/transports/Polling;->logger:Ljava/util/logging/Logger;

    const-string v4, "polling got data %s"

    new-array v5, v6, [Ljava/lang/Object;

    aput-object p1, v5, v7

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 112
    new-instance v0, Lio/socket/engineio/client/transports/Polling$2;

    invoke-direct {v0, p0, v1}, Lio/socket/engineio/client/transports/Polling$2;-><init>(Lio/socket/engineio/client/transports/Polling;Lio/socket/engineio/client/transports/Polling;)V

    .line 129
    .local v0, "callback":Lio/socket/engineio/parser/Parser$DecodePayloadCallback;
    instance-of v3, p1, Ljava/lang/String;

    if-eqz v3, :cond_2

    .line 131
    move-object v2, v0

    .line 132
    .local v2, "tempCallback":Lio/socket/engineio/parser/Parser$DecodePayloadCallback;, "Lio/socket/engineio/parser/Parser$DecodePayloadCallback<Ljava/lang/String;>;"
    check-cast p1, Ljava/lang/String;

    .end local p1    # "data":Ljava/lang/Object;
    invoke-static {p1, v2}, Lio/socket/engineio/parser/Parser;->decodePayload(Ljava/lang/String;Lio/socket/engineio/parser/Parser$DecodePayloadCallback;)V

    .line 137
    .end local v2    # "tempCallback":Lio/socket/engineio/parser/Parser$DecodePayloadCallback;, "Lio/socket/engineio/parser/Parser$DecodePayloadCallback<Ljava/lang/String;>;"
    :cond_0
    :goto_0
    iget-object v3, p0, Lio/socket/engineio/client/transports/Polling;->readyState:Lio/socket/engineio/client/Transport$ReadyState;

    sget-object v4, Lio/socket/engineio/client/Transport$ReadyState;->CLOSED:Lio/socket/engineio/client/Transport$ReadyState;

    if-eq v3, v4, :cond_1

    .line 138
    iput-boolean v7, p0, Lio/socket/engineio/client/transports/Polling;->polling:Z

    .line 139
    const-string v3, "pollComplete"

    new-array v4, v7, [Ljava/lang/Object;

    invoke-virtual {p0, v3, v4}, Lio/socket/engineio/client/transports/Polling;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 141
    iget-object v3, p0, Lio/socket/engineio/client/transports/Polling;->readyState:Lio/socket/engineio/client/Transport$ReadyState;

    sget-object v4, Lio/socket/engineio/client/Transport$ReadyState;->OPEN:Lio/socket/engineio/client/Transport$ReadyState;

    if-ne v3, v4, :cond_3

    .line 142
    invoke-direct {p0}, Lio/socket/engineio/client/transports/Polling;->poll()V

    .line 147
    :cond_1
    :goto_1
    return-void

    .line 133
    .restart local p1    # "data":Ljava/lang/Object;
    :cond_2
    instance-of v3, p1, [B

    if-eqz v3, :cond_0

    .line 134
    check-cast p1, [B

    .end local p1    # "data":Ljava/lang/Object;
    check-cast p1, [B

    invoke-static {p1, v0}, Lio/socket/engineio/parser/Parser;->decodePayload([BLio/socket/engineio/parser/Parser$DecodePayloadCallback;)V

    goto :goto_0

    .line 144
    :cond_3
    sget-object v3, Lio/socket/engineio/client/transports/Polling;->logger:Ljava/util/logging/Logger;

    const-string v4, "ignoring poll - transport state \'%s\'"

    new-array v5, v6, [Ljava/lang/Object;

    iget-object v6, p0, Lio/socket/engineio/client/transports/Polling;->readyState:Lio/socket/engineio/client/Transport$ReadyState;

    aput-object v6, v5, v7

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    goto :goto_1
.end method

.method static synthetic access$002(Lio/socket/engineio/client/transports/Polling;Lio/socket/engineio/client/Transport$ReadyState;)Lio/socket/engineio/client/Transport$ReadyState;
    .locals 0
    .param p0, "x0"    # Lio/socket/engineio/client/transports/Polling;
    .param p1, "x1"    # Lio/socket/engineio/client/Transport$ReadyState;

    .prologue
    .line 17
    iput-object p1, p0, Lio/socket/engineio/client/transports/Polling;->readyState:Lio/socket/engineio/client/Transport$ReadyState;

    return-object p1
.end method

.method static synthetic access$100()Ljava/util/logging/Logger;
    .locals 1

    .prologue
    .line 17
    sget-object v0, Lio/socket/engineio/client/transports/Polling;->logger:Ljava/util/logging/Logger;

    return-object v0
.end method

.method static synthetic access$202(Lio/socket/engineio/client/transports/Polling;Lio/socket/engineio/client/Transport$ReadyState;)Lio/socket/engineio/client/Transport$ReadyState;
    .locals 0
    .param p0, "x0"    # Lio/socket/engineio/client/transports/Polling;
    .param p1, "x1"    # Lio/socket/engineio/client/Transport$ReadyState;

    .prologue
    .line 17
    iput-object p1, p0, Lio/socket/engineio/client/transports/Polling;->readyState:Lio/socket/engineio/client/Transport$ReadyState;

    return-object p1
.end method

.method static synthetic access$300(Lio/socket/engineio/client/transports/Polling;)Z
    .locals 1
    .param p0, "x0"    # Lio/socket/engineio/client/transports/Polling;

    .prologue
    .line 17
    iget-boolean v0, p0, Lio/socket/engineio/client/transports/Polling;->polling:Z

    return v0
.end method

.method static synthetic access$400(Lio/socket/engineio/client/transports/Polling;)Lio/socket/engineio/client/Transport$ReadyState;
    .locals 1
    .param p0, "x0"    # Lio/socket/engineio/client/transports/Polling;

    .prologue
    .line 17
    iget-object v0, p0, Lio/socket/engineio/client/transports/Polling;->readyState:Lio/socket/engineio/client/Transport$ReadyState;

    return-object v0
.end method

.method static synthetic access$500(Lio/socket/engineio/client/transports/Polling;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/engineio/client/transports/Polling;

    .prologue
    .line 17
    invoke-virtual {p0}, Lio/socket/engineio/client/transports/Polling;->onOpen()V

    return-void
.end method

.method static synthetic access$600(Lio/socket/engineio/client/transports/Polling;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/engineio/client/transports/Polling;

    .prologue
    .line 17
    invoke-virtual {p0}, Lio/socket/engineio/client/transports/Polling;->onClose()V

    return-void
.end method

.method static synthetic access$700(Lio/socket/engineio/client/transports/Polling;Lio/socket/engineio/parser/Packet;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/engineio/client/transports/Polling;
    .param p1, "x1"    # Lio/socket/engineio/parser/Packet;

    .prologue
    .line 17
    invoke-virtual {p0, p1}, Lio/socket/engineio/client/transports/Polling;->onPacket(Lio/socket/engineio/parser/Packet;)V

    return-void
.end method

.method private poll()V
    .locals 2

    .prologue
    .line 93
    sget-object v0, Lio/socket/engineio/client/transports/Polling;->logger:Ljava/util/logging/Logger;

    const-string v1, "polling"

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 94
    const/4 v0, 0x1

    iput-boolean v0, p0, Lio/socket/engineio/client/transports/Polling;->polling:Z

    .line 95
    invoke-virtual {p0}, Lio/socket/engineio/client/transports/Polling;->doPoll()V

    .line 96
    const-string v0, "poll"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lio/socket/engineio/client/transports/Polling;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 97
    return-void
.end method


# virtual methods
.method protected doClose()V
    .locals 4

    .prologue
    .line 150
    move-object v1, p0

    .line 152
    .local v1, "self":Lio/socket/engineio/client/transports/Polling;
    new-instance v0, Lio/socket/engineio/client/transports/Polling$3;

    invoke-direct {v0, p0, v1}, Lio/socket/engineio/client/transports/Polling$3;-><init>(Lio/socket/engineio/client/transports/Polling;Lio/socket/engineio/client/transports/Polling;)V

    .line 164
    .local v0, "close":Lio/socket/emitter/Emitter$Listener;
    iget-object v2, p0, Lio/socket/engineio/client/transports/Polling;->readyState:Lio/socket/engineio/client/Transport$ReadyState;

    sget-object v3, Lio/socket/engineio/client/Transport$ReadyState;->OPEN:Lio/socket/engineio/client/Transport$ReadyState;

    if-ne v2, v3, :cond_0

    .line 165
    sget-object v2, Lio/socket/engineio/client/transports/Polling;->logger:Ljava/util/logging/Logger;

    const-string v3, "transport open - closing"

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 166
    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-interface {v0, v2}, Lio/socket/emitter/Emitter$Listener;->call([Ljava/lang/Object;)V

    .line 173
    :goto_0
    return-void

    .line 170
    :cond_0
    sget-object v2, Lio/socket/engineio/client/transports/Polling;->logger:Ljava/util/logging/Logger;

    const-string v3, "transport not open - deferring close"

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 171
    const-string v2, "open"

    invoke-virtual {p0, v2, v0}, Lio/socket/engineio/client/transports/Polling;->once(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    goto :goto_0
.end method

.method protected doOpen()V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Lio/socket/engineio/client/transports/Polling;->poll()V

    .line 36
    return-void
.end method

.method protected abstract doPoll()V
.end method

.method protected abstract doWrite([BLjava/lang/Runnable;)V
.end method

.method protected onData(Ljava/lang/String;)V
    .locals 0
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    .line 101
    invoke-direct {p0, p1}, Lio/socket/engineio/client/transports/Polling;->_onData(Ljava/lang/Object;)V

    .line 102
    return-void
.end method

.method protected onData([B)V
    .locals 0
    .param p1, "data"    # [B

    .prologue
    .line 106
    invoke-direct {p0, p1}, Lio/socket/engineio/client/transports/Polling;->_onData(Ljava/lang/Object;)V

    .line 107
    return-void
.end method

.method public pause(Ljava/lang/Runnable;)V
    .locals 1
    .param p1, "onPause"    # Ljava/lang/Runnable;

    .prologue
    .line 39
    new-instance v0, Lio/socket/engineio/client/transports/Polling$1;

    invoke-direct {v0, p0, p1}, Lio/socket/engineio/client/transports/Polling$1;-><init>(Lio/socket/engineio/client/transports/Polling;Ljava/lang/Runnable;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 90
    return-void
.end method

.method protected uri()Ljava/lang/String;
    .locals 8

    .prologue
    .line 195
    iget-object v3, p0, Lio/socket/engineio/client/transports/Polling;->query:Ljava/util/Map;

    .line 196
    .local v3, "query":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    if-nez v3, :cond_0

    .line 197
    new-instance v3, Ljava/util/HashMap;

    .end local v3    # "query":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    .line 199
    .restart local v3    # "query":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_0
    iget-boolean v5, p0, Lio/socket/engineio/client/transports/Polling;->secure:Z

    if-eqz v5, :cond_6

    const-string v4, "https"

    .line 200
    .local v4, "schema":Ljava/lang/String;
    :goto_0
    const-string v2, ""

    .line 202
    .local v2, "port":Ljava/lang/String;
    iget-boolean v5, p0, Lio/socket/engineio/client/transports/Polling;->timestampRequests:Z

    if-eqz v5, :cond_1

    .line 203
    iget-object v5, p0, Lio/socket/engineio/client/transports/Polling;->timestampParam:Ljava/lang/String;

    invoke-static {}, Lio/socket/yeast/Yeast;->yeast()Ljava/lang/String;

    move-result-object v6

    invoke-interface {v3, v5, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 206
    :cond_1
    invoke-static {v3}, Lio/socket/parseqs/ParseQS;->encode(Ljava/util/Map;)Ljava/lang/String;

    move-result-object v0

    .line 208
    .local v0, "derivedQuery":Ljava/lang/String;
    iget v5, p0, Lio/socket/engineio/client/transports/Polling;->port:I

    if-lez v5, :cond_4

    const-string v5, "https"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    iget v5, p0, Lio/socket/engineio/client/transports/Polling;->port:I

    const/16 v6, 0x1bb

    if-ne v5, v6, :cond_3

    :cond_2
    const-string v5, "http"

    .line 209
    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_4

    iget v5, p0, Lio/socket/engineio/client/transports/Polling;->port:I

    const/16 v6, 0x50

    if-eq v5, v6, :cond_4

    .line 210
    :cond_3
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, ":"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p0, Lio/socket/engineio/client/transports/Polling;->port:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 213
    :cond_4
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    if-lez v5, :cond_5

    .line 214
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "?"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 217
    :cond_5
    iget-object v5, p0, Lio/socket/engineio/client/transports/Polling;->hostname:Ljava/lang/String;

    const-string v6, ":"

    invoke-virtual {v5, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    .line 218
    .local v1, "ipv6":Z
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "://"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    if-eqz v1, :cond_7

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "["

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v7, p0, Lio/socket/engineio/client/transports/Polling;->hostname:Ljava/lang/String;

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v7, "]"

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    :goto_1
    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lio/socket/engineio/client/transports/Polling;->path:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    return-object v5

    .line 199
    .end local v0    # "derivedQuery":Ljava/lang/String;
    .end local v1    # "ipv6":Z
    .end local v2    # "port":Ljava/lang/String;
    .end local v4    # "schema":Ljava/lang/String;
    :cond_6
    const-string v4, "http"

    goto/16 :goto_0

    .line 218
    .restart local v0    # "derivedQuery":Ljava/lang/String;
    .restart local v1    # "ipv6":Z
    .restart local v2    # "port":Ljava/lang/String;
    .restart local v4    # "schema":Ljava/lang/String;
    :cond_7
    iget-object v5, p0, Lio/socket/engineio/client/transports/Polling;->hostname:Ljava/lang/String;

    goto :goto_1
.end method

.method protected write([Lio/socket/engineio/parser/Packet;)V
    .locals 3
    .param p1, "packets"    # [Lio/socket/engineio/parser/Packet;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .prologue
    .line 176
    move-object v1, p0

    .line 177
    .local v1, "self":Lio/socket/engineio/client/transports/Polling;
    const/4 v2, 0x0

    iput-boolean v2, p0, Lio/socket/engineio/client/transports/Polling;->writable:Z

    .line 178
    new-instance v0, Lio/socket/engineio/client/transports/Polling$4;

    invoke-direct {v0, p0, v1}, Lio/socket/engineio/client/transports/Polling$4;-><init>(Lio/socket/engineio/client/transports/Polling;Lio/socket/engineio/client/transports/Polling;)V

    .line 186
    .local v0, "callbackfn":Ljava/lang/Runnable;
    new-instance v2, Lio/socket/engineio/client/transports/Polling$5;

    invoke-direct {v2, p0, v1, v0}, Lio/socket/engineio/client/transports/Polling$5;-><init>(Lio/socket/engineio/client/transports/Polling;Lio/socket/engineio/client/transports/Polling;Ljava/lang/Runnable;)V

    invoke-static {p1, v2}, Lio/socket/engineio/parser/Parser;->encodePayload([Lio/socket/engineio/parser/Packet;Lio/socket/engineio/parser/Parser$EncodeCallback;)V

    .line 192
    return-void
.end method
