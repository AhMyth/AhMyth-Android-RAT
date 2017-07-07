.class Lio/socket/engineio/client/transports/WebSocket$2;
.super Lokhttp3/WebSocketListener;
.source "WebSocket.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/WebSocket;->doOpen()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/transports/WebSocket;

.field final synthetic val$self:Lio/socket/engineio/client/transports/WebSocket;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/WebSocket;Lio/socket/engineio/client/transports/WebSocket;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/transports/WebSocket;

    .prologue
    .line 78
    iput-object p1, p0, Lio/socket/engineio/client/transports/WebSocket$2;->this$0:Lio/socket/engineio/client/transports/WebSocket;

    iput-object p2, p0, Lio/socket/engineio/client/transports/WebSocket$2;->val$self:Lio/socket/engineio/client/transports/WebSocket;

    invoke-direct {p0}, Lokhttp3/WebSocketListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onClosed(Lokhttp3/WebSocket;ILjava/lang/String;)V
    .locals 1
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "code"    # I
    .param p3, "reason"    # Ljava/lang/String;

    .prologue
    .line 119
    new-instance v0, Lio/socket/engineio/client/transports/WebSocket$2$4;

    invoke-direct {v0, p0}, Lio/socket/engineio/client/transports/WebSocket$2$4;-><init>(Lio/socket/engineio/client/transports/WebSocket$2;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 125
    return-void
.end method

.method public onFailure(Lokhttp3/WebSocket;Ljava/lang/Throwable;Lokhttp3/Response;)V
    .locals 1
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "t"    # Ljava/lang/Throwable;
    .param p3, "response"    # Lokhttp3/Response;

    .prologue
    .line 129
    instance-of v0, p2, Ljava/lang/Exception;

    if-nez v0, :cond_0

    .line 138
    :goto_0
    return-void

    .line 132
    :cond_0
    new-instance v0, Lio/socket/engineio/client/transports/WebSocket$2$5;

    invoke-direct {v0, p0, p2}, Lio/socket/engineio/client/transports/WebSocket$2$5;-><init>(Lio/socket/engineio/client/transports/WebSocket$2;Ljava/lang/Throwable;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    goto :goto_0
.end method

.method public onMessage(Lokhttp3/WebSocket;Ljava/lang/String;)V
    .locals 1
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "text"    # Ljava/lang/String;

    .prologue
    .line 93
    if-nez p2, :cond_0

    .line 102
    :goto_0
    return-void

    .line 96
    :cond_0
    new-instance v0, Lio/socket/engineio/client/transports/WebSocket$2$2;

    invoke-direct {v0, p0, p2}, Lio/socket/engineio/client/transports/WebSocket$2$2;-><init>(Lio/socket/engineio/client/transports/WebSocket$2;Ljava/lang/String;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    goto :goto_0
.end method

.method public onMessage(Lokhttp3/WebSocket;Lokio/ByteString;)V
    .locals 1
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "bytes"    # Lokio/ByteString;

    .prologue
    .line 106
    if-nez p2, :cond_0

    .line 115
    :goto_0
    return-void

    .line 109
    :cond_0
    new-instance v0, Lio/socket/engineio/client/transports/WebSocket$2$3;

    invoke-direct {v0, p0, p2}, Lio/socket/engineio/client/transports/WebSocket$2$3;-><init>(Lio/socket/engineio/client/transports/WebSocket$2;Lokio/ByteString;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    goto :goto_0
.end method

.method public onOpen(Lokhttp3/WebSocket;Lokhttp3/Response;)V
    .locals 2
    .param p1, "webSocket"    # Lokhttp3/WebSocket;
    .param p2, "response"    # Lokhttp3/Response;

    .prologue
    .line 81
    invoke-virtual {p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v1

    invoke-virtual {v1}, Lokhttp3/Headers;->toMultimap()Ljava/util/Map;

    move-result-object v0

    .line 82
    .local v0, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    new-instance v1, Lio/socket/engineio/client/transports/WebSocket$2$1;

    invoke-direct {v1, p0, v0}, Lio/socket/engineio/client/transports/WebSocket$2$1;-><init>(Lio/socket/engineio/client/transports/WebSocket$2;Ljava/util/Map;)V

    invoke-static {v1}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 89
    return-void
.end method
