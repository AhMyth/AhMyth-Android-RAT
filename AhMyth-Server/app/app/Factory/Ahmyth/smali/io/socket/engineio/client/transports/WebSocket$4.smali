.class Lio/socket/engineio/client/transports/WebSocket$4;
.super Ljava/lang/Object;
.source "WebSocket.java"

# interfaces
.implements Lio/socket/engineio/parser/Parser$EncodeCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/WebSocket;->write([Lio/socket/engineio/parser/Packet;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/transports/WebSocket;

.field final synthetic val$done:Ljava/lang/Runnable;

.field final synthetic val$self:Lio/socket/engineio/client/transports/WebSocket;

.field final synthetic val$total:[I


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/WebSocket;Lio/socket/engineio/client/transports/WebSocket;[ILjava/lang/Runnable;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/transports/WebSocket;

    .prologue
    .line 169
    iput-object p1, p0, Lio/socket/engineio/client/transports/WebSocket$4;->this$0:Lio/socket/engineio/client/transports/WebSocket;

    iput-object p2, p0, Lio/socket/engineio/client/transports/WebSocket$4;->val$self:Lio/socket/engineio/client/transports/WebSocket;

    iput-object p3, p0, Lio/socket/engineio/client/transports/WebSocket$4;->val$total:[I

    iput-object p4, p0, Lio/socket/engineio/client/transports/WebSocket$4;->val$done:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public call(Ljava/lang/Object;)V
    .locals 4
    .param p1, "packet"    # Ljava/lang/Object;

    .prologue
    .line 173
    :try_start_0
    instance-of v1, p1, Ljava/lang/String;

    if-eqz v1, :cond_2

    .line 174
    iget-object v1, p0, Lio/socket/engineio/client/transports/WebSocket$4;->val$self:Lio/socket/engineio/client/transports/WebSocket;

    # getter for: Lio/socket/engineio/client/transports/WebSocket;->ws:Lokhttp3/WebSocket;
    invoke-static {v1}, Lio/socket/engineio/client/transports/WebSocket;->access$500(Lio/socket/engineio/client/transports/WebSocket;)Lokhttp3/WebSocket;

    move-result-object v1

    check-cast p1, Ljava/lang/String;

    .end local p1    # "packet":Ljava/lang/Object;
    invoke-interface {v1, p1}, Lokhttp3/WebSocket;->send(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    .line 182
    :cond_0
    :goto_0
    iget-object v1, p0, Lio/socket/engineio/client/transports/WebSocket$4;->val$total:[I

    const/4 v2, 0x0

    aget v3, v1, v2

    add-int/lit8 v3, v3, -0x1

    aput v3, v1, v2

    if-nez v3, :cond_1

    iget-object v1, p0, Lio/socket/engineio/client/transports/WebSocket$4;->val$done:Ljava/lang/Runnable;

    invoke-interface {v1}, Ljava/lang/Runnable;->run()V

    .line 183
    :cond_1
    return-void

    .line 175
    .restart local p1    # "packet":Ljava/lang/Object;
    :cond_2
    :try_start_1
    instance-of v1, p1, [B

    if-eqz v1, :cond_0

    .line 176
    iget-object v1, p0, Lio/socket/engineio/client/transports/WebSocket$4;->val$self:Lio/socket/engineio/client/transports/WebSocket;

    # getter for: Lio/socket/engineio/client/transports/WebSocket;->ws:Lokhttp3/WebSocket;
    invoke-static {v1}, Lio/socket/engineio/client/transports/WebSocket;->access$500(Lio/socket/engineio/client/transports/WebSocket;)Lokhttp3/WebSocket;

    move-result-object v1

    check-cast p1, [B

    .end local p1    # "packet":Ljava/lang/Object;
    check-cast p1, [B

    invoke-static {p1}, Lokio/ByteString;->of([B)Lokio/ByteString;

    move-result-object v2

    invoke-interface {v1, v2}, Lokhttp3/WebSocket;->send(Lokio/ByteString;)Z
    :try_end_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 178
    :catch_0
    move-exception v0

    .line 179
    .local v0, "e":Ljava/lang/IllegalStateException;
    # getter for: Lio/socket/engineio/client/transports/WebSocket;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/engineio/client/transports/WebSocket;->access$600()Ljava/util/logging/Logger;

    move-result-object v1

    const-string v2, "websocket closed before we could write"

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    goto :goto_0
.end method
