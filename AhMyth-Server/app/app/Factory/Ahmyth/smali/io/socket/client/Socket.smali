.class public Lio/socket/client/Socket;
.super Lio/socket/emitter/Emitter;
.source "Socket.java"


# static fields
.field public static final EVENT_CONNECT:Ljava/lang/String; = "connect"

.field public static final EVENT_CONNECTING:Ljava/lang/String; = "connecting"

.field public static final EVENT_CONNECT_ERROR:Ljava/lang/String; = "connect_error"

.field public static final EVENT_CONNECT_TIMEOUT:Ljava/lang/String; = "connect_timeout"

.field public static final EVENT_DISCONNECT:Ljava/lang/String; = "disconnect"

.field public static final EVENT_ERROR:Ljava/lang/String; = "error"

.field public static final EVENT_MESSAGE:Ljava/lang/String; = "message"

.field public static final EVENT_PING:Ljava/lang/String; = "ping"

.field public static final EVENT_PONG:Ljava/lang/String; = "pong"

.field public static final EVENT_RECONNECT:Ljava/lang/String; = "reconnect"

.field public static final EVENT_RECONNECTING:Ljava/lang/String; = "reconnecting"

.field public static final EVENT_RECONNECT_ATTEMPT:Ljava/lang/String; = "reconnect_attempt"

.field public static final EVENT_RECONNECT_ERROR:Ljava/lang/String; = "reconnect_error"

.field public static final EVENT_RECONNECT_FAILED:Ljava/lang/String; = "reconnect_failed"

.field protected static events:Ljava/util/Map;
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

.field private static final logger:Ljava/util/logging/Logger;


# instance fields
.field private acks:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/Integer;",
            "Lio/socket/client/Ack;",
            ">;"
        }
    .end annotation
.end field

.field private volatile connected:Z

.field id:Ljava/lang/String;

.field private ids:I

.field private io:Lio/socket/client/Manager;

.field private nsp:Ljava/lang/String;

.field private final receiveBuffer:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue",
            "<",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation
.end field

.field private final sendBuffer:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue",
            "<",
            "Lio/socket/parser/Packet",
            "<",
            "Lorg/json/JSONArray;",
            ">;>;"
        }
    .end annotation
.end field

.field private subs:Ljava/util/Queue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Queue",
            "<",
            "Lio/socket/client/On$Handle;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 21
    const-class v0, Lio/socket/client/Socket;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    .line 65
    new-instance v0, Lio/socket/client/Socket$1;

    invoke-direct {v0}, Lio/socket/client/Socket$1;-><init>()V

    sput-object v0, Lio/socket/client/Socket;->events:Ljava/util/Map;

    return-void
.end method

.method public constructor <init>(Lio/socket/client/Manager;Ljava/lang/String;)V
    .locals 1
    .param p1, "io"    # Lio/socket/client/Manager;
    .param p2, "nsp"    # Ljava/lang/String;

    .prologue
    .line 92
    invoke-direct {p0}, Lio/socket/emitter/Emitter;-><init>()V

    .line 87
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lio/socket/client/Socket;->acks:Ljava/util/Map;

    .line 89
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lio/socket/client/Socket;->receiveBuffer:Ljava/util/Queue;

    .line 90
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lio/socket/client/Socket;->sendBuffer:Ljava/util/Queue;

    .line 93
    iput-object p1, p0, Lio/socket/client/Socket;->io:Lio/socket/client/Manager;

    .line 94
    iput-object p2, p0, Lio/socket/client/Socket;->nsp:Ljava/lang/String;

    .line 95
    return-void
.end method

.method static synthetic access$000(Lio/socket/client/Socket;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Socket;

    .prologue
    .line 19
    invoke-direct {p0}, Lio/socket/client/Socket;->onopen()V

    return-void
.end method

.method static synthetic access$100(Lio/socket/client/Socket;Lio/socket/parser/Packet;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Socket;
    .param p1, "x1"    # Lio/socket/parser/Packet;

    .prologue
    .line 19
    invoke-direct {p0, p1}, Lio/socket/client/Socket;->onpacket(Lio/socket/parser/Packet;)V

    return-void
.end method

.method static synthetic access$1000(Lorg/json/JSONArray;I)Lorg/json/JSONArray;
    .locals 1
    .param p0, "x0"    # Lorg/json/JSONArray;
    .param p1, "x1"    # I

    .prologue
    .line 19
    invoke-static {p0, p1}, Lio/socket/client/Socket;->remove(Lorg/json/JSONArray;I)Lorg/json/JSONArray;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$1100(Lio/socket/client/Socket;Lio/socket/parser/Packet;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Socket;
    .param p1, "x1"    # Lio/socket/parser/Packet;

    .prologue
    .line 19
    invoke-direct {p0, p1}, Lio/socket/client/Socket;->packet(Lio/socket/parser/Packet;)V

    return-void
.end method

.method static synthetic access$1200(Lio/socket/client/Socket;)Ljava/util/Queue;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;

    .prologue
    .line 19
    iget-object v0, p0, Lio/socket/client/Socket;->sendBuffer:Ljava/util/Queue;

    return-object v0
.end method

.method static synthetic access$1300(Lio/socket/client/Socket;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;

    .prologue
    .line 19
    iget-object v0, p0, Lio/socket/client/Socket;->nsp:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1400(Lio/socket/client/Socket;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Socket;

    .prologue
    .line 19
    invoke-direct {p0}, Lio/socket/client/Socket;->destroy()V

    return-void
.end method

.method static synthetic access$200(Lio/socket/client/Socket;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Socket;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 19
    invoke-direct {p0, p1}, Lio/socket/client/Socket;->onclose(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$300(Lio/socket/client/Socket;)Z
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;

    .prologue
    .line 19
    iget-boolean v0, p0, Lio/socket/client/Socket;->connected:Z

    return v0
.end method

.method static synthetic access$400(Lio/socket/client/Socket;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/client/Socket;

    .prologue
    .line 19
    invoke-direct {p0}, Lio/socket/client/Socket;->subEvents()V

    return-void
.end method

.method static synthetic access$500(Lio/socket/client/Socket;)Lio/socket/client/Manager;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;

    .prologue
    .line 19
    iget-object v0, p0, Lio/socket/client/Socket;->io:Lio/socket/client/Manager;

    return-object v0
.end method

.method static synthetic access$601(Lio/socket/client/Socket;Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;
    .param p1, "x1"    # Ljava/lang/String;
    .param p2, "x2"    # [Ljava/lang/Object;

    .prologue
    .line 19
    invoke-super {p0, p1, p2}, Lio/socket/emitter/Emitter;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$700(Lio/socket/client/Socket;)I
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;

    .prologue
    .line 19
    iget v0, p0, Lio/socket/client/Socket;->ids:I

    return v0
.end method

.method static synthetic access$708(Lio/socket/client/Socket;)I
    .locals 2
    .param p0, "x0"    # Lio/socket/client/Socket;

    .prologue
    .line 19
    iget v0, p0, Lio/socket/client/Socket;->ids:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lio/socket/client/Socket;->ids:I

    return v0
.end method

.method static synthetic access$800()Ljava/util/logging/Logger;
    .locals 1

    .prologue
    .line 19
    sget-object v0, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    return-object v0
.end method

.method static synthetic access$900(Lio/socket/client/Socket;)Ljava/util/Map;
    .locals 1
    .param p0, "x0"    # Lio/socket/client/Socket;

    .prologue
    .line 19
    iget-object v0, p0, Lio/socket/client/Socket;->acks:Ljava/util/Map;

    return-object v0
.end method

.method private ack(I)Lio/socket/client/Ack;
    .locals 4
    .param p1, "id"    # I

    .prologue
    const/4 v3, 0x0

    .line 347
    move-object v0, p0

    .line 348
    .local v0, "self":Lio/socket/client/Socket;
    const/4 v2, 0x1

    new-array v1, v2, [Z

    aput-boolean v3, v1, v3

    .line 349
    .local v1, "sent":[Z
    new-instance v2, Lio/socket/client/Socket$7;

    invoke-direct {v2, p0, v1, p1, v0}, Lio/socket/client/Socket$7;-><init>(Lio/socket/client/Socket;[ZILio/socket/client/Socket;)V

    return-object v2
.end method

.method private destroy()V
    .locals 3

    .prologue
    .line 413
    iget-object v1, p0, Lio/socket/client/Socket;->subs:Ljava/util/Queue;

    if-eqz v1, :cond_1

    .line 415
    iget-object v1, p0, Lio/socket/client/Socket;->subs:Ljava/util/Queue;

    invoke-interface {v1}, Ljava/util/Queue;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/socket/client/On$Handle;

    .line 416
    .local v0, "sub":Lio/socket/client/On$Handle;
    invoke-interface {v0}, Lio/socket/client/On$Handle;->destroy()V

    goto :goto_0

    .line 418
    .end local v0    # "sub":Lio/socket/client/On$Handle;
    :cond_0
    const/4 v1, 0x0

    iput-object v1, p0, Lio/socket/client/Socket;->subs:Ljava/util/Queue;

    .line 421
    :cond_1
    iget-object v1, p0, Lio/socket/client/Socket;->io:Lio/socket/client/Manager;

    invoke-virtual {v1, p0}, Lio/socket/client/Manager;->destroy(Lio/socket/client/Socket;)V

    .line 422
    return-void
.end method

.method private emitBuffered()V
    .locals 4

    .prologue
    .line 393
    :goto_0
    iget-object v3, p0, Lio/socket/client/Socket;->receiveBuffer:Ljava/util/Queue;

    invoke-interface {v3}, Ljava/util/Queue;->poll()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .local v0, "data":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    if-eqz v0, :cond_0

    .line 394
    const/4 v3, 0x0

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 395
    .local v1, "event":Ljava/lang/String;
    invoke-interface {v0}, Ljava/util/List;->toArray()[Ljava/lang/Object;

    move-result-object v3

    invoke-super {p0, v1, v3}, Lio/socket/emitter/Emitter;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    goto :goto_0

    .line 397
    .end local v1    # "event":Ljava/lang/String;
    :cond_0
    iget-object v3, p0, Lio/socket/client/Socket;->receiveBuffer:Ljava/util/Queue;

    invoke-interface {v3}, Ljava/util/Queue;->clear()V

    .line 400
    :goto_1
    iget-object v3, p0, Lio/socket/client/Socket;->sendBuffer:Ljava/util/Queue;

    invoke-interface {v3}, Ljava/util/Queue;->poll()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lio/socket/parser/Packet;

    .local v2, "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    if-eqz v2, :cond_1

    .line 401
    invoke-direct {p0, v2}, Lio/socket/client/Socket;->packet(Lio/socket/parser/Packet;)V

    goto :goto_1

    .line 403
    :cond_1
    iget-object v3, p0, Lio/socket/client/Socket;->sendBuffer:Ljava/util/Queue;

    invoke-interface {v3}, Ljava/util/Queue;->clear()V

    .line 404
    return-void
.end method

.method private onack(Lio/socket/parser/Packet;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/socket/parser/Packet",
            "<",
            "Lorg/json/JSONArray;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 376
    iget-object v1, p0, Lio/socket/client/Socket;->acks:Ljava/util/Map;

    iget v2, p1, Lio/socket/parser/Packet;->id:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lio/socket/client/Ack;

    .line 377
    .local v0, "fn":Lio/socket/client/Ack;
    if-eqz v0, :cond_0

    .line 378
    sget-object v1, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    const-string v2, "calling ack %s with %s"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    iget v4, p1, Lio/socket/parser/Packet;->id:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    iget-object v4, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    aput-object v4, v3, v6

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 379
    iget-object v1, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    check-cast v1, Lorg/json/JSONArray;

    invoke-static {v1}, Lio/socket/client/Socket;->toArray(Lorg/json/JSONArray;)[Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lio/socket/client/Ack;->call([Ljava/lang/Object;)V

    .line 383
    :goto_0
    return-void

    .line 381
    :cond_0
    sget-object v1, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    const-string v2, "bad ack %s"

    new-array v3, v6, [Ljava/lang/Object;

    iget v4, p1, Lio/socket/parser/Packet;->id:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private onclose(Ljava/lang/String;)V
    .locals 5
    .param p1, "reason"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 276
    sget-object v0, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    const-string v1, "close (%s)"

    new-array v2, v4, [Ljava/lang/Object;

    aput-object p1, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 277
    iput-boolean v3, p0, Lio/socket/client/Socket;->connected:Z

    .line 278
    const/4 v0, 0x0

    iput-object v0, p0, Lio/socket/client/Socket;->id:Ljava/lang/String;

    .line 279
    const-string v0, "disconnect"

    new-array v1, v4, [Ljava/lang/Object;

    aput-object p1, v1, v3

    invoke-virtual {p0, v0, v1}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 280
    return-void
.end method

.method private onconnect()V
    .locals 2

    .prologue
    .line 386
    const/4 v0, 0x1

    iput-boolean v0, p0, Lio/socket/client/Socket;->connected:Z

    .line 387
    const-string v0, "connect"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 388
    invoke-direct {p0}, Lio/socket/client/Socket;->emitBuffered()V

    .line 389
    return-void
.end method

.method private ondisconnect()V
    .locals 5

    .prologue
    .line 407
    sget-object v0, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    const-string v1, "server disconnect (%s)"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p0, Lio/socket/client/Socket;->nsp:Ljava/lang/String;

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 408
    invoke-direct {p0}, Lio/socket/client/Socket;->destroy()V

    .line 409
    const-string v0, "io server disconnect"

    invoke-direct {p0, v0}, Lio/socket/client/Socket;->onclose(Ljava/lang/String;)V

    .line 410
    return-void
.end method

.method private onevent(Lio/socket/parser/Packet;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/socket/parser/Packet",
            "<",
            "Lorg/json/JSONArray;",
            ">;)V"
        }
    .end annotation

    .prologue
    .local p1, "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    const/4 v5, 0x0

    .line 329
    new-instance v0, Ljava/util/ArrayList;

    iget-object v2, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    check-cast v2, Lorg/json/JSONArray;

    invoke-static {v2}, Lio/socket/client/Socket;->toArray(Lorg/json/JSONArray;)[Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 330
    .local v0, "args":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    sget-object v2, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    const-string v3, "emitting event %s"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    aput-object v0, v4, v5

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 332
    iget v2, p1, Lio/socket/parser/Packet;->id:I

    if-ltz v2, :cond_0

    .line 333
    sget-object v2, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    const-string v3, "attaching ack callback to event"

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 334
    iget v2, p1, Lio/socket/parser/Packet;->id:I

    invoke-direct {p0, v2}, Lio/socket/client/Socket;->ack(I)Lio/socket/client/Ack;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 337
    :cond_0
    iget-boolean v2, p0, Lio/socket/client/Socket;->connected:Z

    if-eqz v2, :cond_2

    .line 338
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 344
    :goto_0
    return-void

    .line 339
    :cond_1
    invoke-interface {v0, v5}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    .line 340
    .local v1, "event":Ljava/lang/String;
    invoke-interface {v0}, Ljava/util/List;->toArray()[Ljava/lang/Object;

    move-result-object v2

    invoke-super {p0, v1, v2}, Lio/socket/emitter/Emitter;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    goto :goto_0

    .line 342
    .end local v1    # "event":Ljava/lang/String;
    :cond_2
    iget-object v2, p0, Lio/socket/client/Socket;->receiveBuffer:Ljava/util/Queue;

    invoke-interface {v2, v0}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    goto :goto_0
.end method

.method private onopen()V
    .locals 2

    .prologue
    .line 268
    sget-object v0, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    const-string v1, "transport is open - connecting"

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 270
    const-string v0, "/"

    iget-object v1, p0, Lio/socket/client/Socket;->nsp:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 271
    new-instance v0, Lio/socket/parser/Packet;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lio/socket/parser/Packet;-><init>(I)V

    invoke-direct {p0, v0}, Lio/socket/client/Socket;->packet(Lio/socket/parser/Packet;)V

    .line 273
    :cond_0
    return-void
.end method

.method private onpacket(Lio/socket/parser/Packet;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/socket/parser/Packet",
            "<*>;)V"
        }
    .end annotation

    .prologue
    .line 283
    .local p1, "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<*>;"
    iget-object v1, p0, Lio/socket/client/Socket;->nsp:Ljava/lang/String;

    iget-object v2, p1, Lio/socket/parser/Packet;->nsp:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 326
    :goto_0
    return-void

    .line 285
    :cond_0
    iget v1, p1, Lio/socket/parser/Packet;->type:I

    packed-switch v1, :pswitch_data_0

    goto :goto_0

    .line 287
    :pswitch_0
    invoke-direct {p0}, Lio/socket/client/Socket;->onconnect()V

    goto :goto_0

    .line 292
    :pswitch_1
    move-object v0, p1

    .line 293
    .local v0, "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    invoke-direct {p0, v0}, Lio/socket/client/Socket;->onevent(Lio/socket/parser/Packet;)V

    goto :goto_0

    .line 299
    .end local v0    # "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    :pswitch_2
    move-object v0, p1

    .line 300
    .restart local v0    # "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    invoke-direct {p0, v0}, Lio/socket/client/Socket;->onevent(Lio/socket/parser/Packet;)V

    goto :goto_0

    .line 306
    .end local v0    # "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    :pswitch_3
    move-object v0, p1

    .line 307
    .restart local v0    # "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    invoke-direct {p0, v0}, Lio/socket/client/Socket;->onack(Lio/socket/parser/Packet;)V

    goto :goto_0

    .line 313
    .end local v0    # "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    :pswitch_4
    move-object v0, p1

    .line 314
    .restart local v0    # "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    invoke-direct {p0, v0}, Lio/socket/client/Socket;->onack(Lio/socket/parser/Packet;)V

    goto :goto_0

    .line 319
    .end local v0    # "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    :pswitch_5
    invoke-direct {p0}, Lio/socket/client/Socket;->ondisconnect()V

    goto :goto_0

    .line 323
    :pswitch_6
    const-string v1, "error"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    aput-object v4, v2, v3

    invoke-virtual {p0, v1, v2}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    goto :goto_0

    .line 285
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_5
        :pswitch_1
        :pswitch_3
        :pswitch_6
        :pswitch_2
        :pswitch_4
    .end packed-switch
.end method

.method private packet(Lio/socket/parser/Packet;)V
    .locals 1
    .param p1, "packet"    # Lio/socket/parser/Packet;

    .prologue
    .line 263
    iget-object v0, p0, Lio/socket/client/Socket;->nsp:Ljava/lang/String;

    iput-object v0, p1, Lio/socket/parser/Packet;->nsp:Ljava/lang/String;

    .line 264
    iget-object v0, p0, Lio/socket/client/Socket;->io:Lio/socket/client/Manager;

    invoke-virtual {v0, p1}, Lio/socket/client/Manager;->packet(Lio/socket/parser/Packet;)V

    .line 265
    return-void
.end method

.method private static remove(Lorg/json/JSONArray;I)Lorg/json/JSONArray;
    .locals 5
    .param p0, "a"    # Lorg/json/JSONArray;
    .param p1, "pos"    # I

    .prologue
    .line 211
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    .line 212
    .local v2, "na":Lorg/json/JSONArray;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-ge v1, v4, :cond_1

    .line 213
    if-eq v1, p1, :cond_0

    .line 216
    :try_start_0
    invoke-virtual {p0, v1}, Lorg/json/JSONArray;->get(I)Ljava/lang/Object;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    .line 220
    :goto_1
    invoke-virtual {v2, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 212
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 217
    :catch_0
    move-exception v0

    .line 218
    .local v0, "e":Lorg/json/JSONException;
    const/4 v3, 0x0

    .local v3, "v":Ljava/lang/Object;
    goto :goto_1

    .line 223
    .end local v0    # "e":Lorg/json/JSONException;
    .end local v3    # "v":Ljava/lang/Object;
    :cond_1
    return-object v2
.end method

.method private subEvents()V
    .locals 2

    .prologue
    .line 98
    iget-object v1, p0, Lio/socket/client/Socket;->subs:Ljava/util/Queue;

    if-eqz v1, :cond_0

    .line 121
    :goto_0
    return-void

    .line 100
    :cond_0
    iget-object v0, p0, Lio/socket/client/Socket;->io:Lio/socket/client/Manager;

    .line 101
    .local v0, "io":Lio/socket/client/Manager;
    new-instance v1, Lio/socket/client/Socket$2;

    invoke-direct {v1, p0, v0}, Lio/socket/client/Socket$2;-><init>(Lio/socket/client/Socket;Lio/socket/client/Manager;)V

    iput-object v1, p0, Lio/socket/client/Socket;->subs:Ljava/util/Queue;

    goto :goto_0
.end method

.method private static toArray(Lorg/json/JSONArray;)[Ljava/lang/Object;
    .locals 8
    .param p0, "array"    # Lorg/json/JSONArray;

    .prologue
    .line 477
    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v3

    .line 478
    .local v3, "length":I
    new-array v0, v3, [Ljava/lang/Object;

    .line 479
    .local v0, "data":[Ljava/lang/Object;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v3, :cond_1

    .line 482
    :try_start_0
    invoke-virtual {p0, v2}, Lorg/json/JSONArray;->get(I)Ljava/lang/Object;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v4

    .line 487
    :goto_1
    sget-object v5, Lorg/json/JSONObject;->NULL:Ljava/lang/Object;

    invoke-virtual {v5, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    const/4 v4, 0x0

    :cond_0
    aput-object v4, v0, v2

    .line 479
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 483
    :catch_0
    move-exception v1

    .line 484
    .local v1, "e":Lorg/json/JSONException;
    sget-object v5, Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;

    sget-object v6, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v7, "An error occured while retrieving data from JSONArray"

    invoke-virtual {v5, v6, v7, v1}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 485
    const/4 v4, 0x0

    .local v4, "v":Ljava/lang/Object;
    goto :goto_1

    .line 489
    .end local v1    # "e":Lorg/json/JSONException;
    .end local v4    # "v":Ljava/lang/Object;
    :cond_1
    return-object v0
.end method


# virtual methods
.method public close()Lio/socket/client/Socket;
    .locals 1

    .prologue
    .line 430
    new-instance v0, Lio/socket/client/Socket$8;

    invoke-direct {v0, p0}, Lio/socket/client/Socket$8;-><init>(Lio/socket/client/Socket;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 445
    return-object p0
.end method

.method public connect()Lio/socket/client/Socket;
    .locals 1

    .prologue
    .line 145
    invoke-virtual {p0}, Lio/socket/client/Socket;->open()Lio/socket/client/Socket;

    move-result-object v0

    return-object v0
.end method

.method public connected()Z
    .locals 1

    .prologue
    .line 462
    iget-boolean v0, p0, Lio/socket/client/Socket;->connected:Z

    return v0
.end method

.method public disconnect()Lio/socket/client/Socket;
    .locals 1

    .prologue
    .line 454
    invoke-virtual {p0}, Lio/socket/client/Socket;->close()Lio/socket/client/Socket;

    move-result-object v0

    return-object v0
.end method

.method public varargs emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;
    .locals 1
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .prologue
    .line 173
    new-instance v0, Lio/socket/client/Socket$5;

    invoke-direct {v0, p0, p1, p2}, Lio/socket/client/Socket$5;-><init>(Lio/socket/client/Socket;Ljava/lang/String;[Ljava/lang/Object;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 207
    return-object p0
.end method

.method public emit(Ljava/lang/String;[Ljava/lang/Object;Lio/socket/client/Ack;)Lio/socket/emitter/Emitter;
    .locals 1
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;
    .param p3, "ack"    # Lio/socket/client/Ack;

    .prologue
    .line 235
    new-instance v0, Lio/socket/client/Socket$6;

    invoke-direct {v0, p0, p1, p2, p3}, Lio/socket/client/Socket$6;-><init>(Lio/socket/client/Socket;Ljava/lang/String;[Ljava/lang/Object;Lio/socket/client/Ack;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 259
    return-object p0
.end method

.method public id()Ljava/lang/String;
    .locals 1

    .prologue
    .line 473
    iget-object v0, p0, Lio/socket/client/Socket;->id:Ljava/lang/String;

    return-object v0
.end method

.method public io()Lio/socket/client/Manager;
    .locals 1

    .prologue
    .line 458
    iget-object v0, p0, Lio/socket/client/Socket;->io:Lio/socket/client/Manager;

    return-object v0
.end method

.method public open()Lio/socket/client/Socket;
    .locals 1

    .prologue
    .line 127
    new-instance v0, Lio/socket/client/Socket$3;

    invoke-direct {v0, p0}, Lio/socket/client/Socket$3;-><init>(Lio/socket/client/Socket;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 138
    return-object p0
.end method

.method public varargs send([Ljava/lang/Object;)Lio/socket/client/Socket;
    .locals 1
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 155
    new-instance v0, Lio/socket/client/Socket$4;

    invoke-direct {v0, p0, p1}, Lio/socket/client/Socket$4;-><init>(Lio/socket/client/Socket;[Ljava/lang/Object;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 161
    return-object p0
.end method
