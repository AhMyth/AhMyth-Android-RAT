.class Lio/socket/engineio/client/transports/WebSocket$2$3;
.super Ljava/lang/Object;
.source "WebSocket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/WebSocket$2;->onMessage(Lokhttp3/WebSocket;Lokio/ByteString;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/transports/WebSocket$2;

.field final synthetic val$bytes:Lokio/ByteString;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/WebSocket$2;Lokio/ByteString;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/transports/WebSocket$2;

    .prologue
    .line 109
    iput-object p1, p0, Lio/socket/engineio/client/transports/WebSocket$2$3;->this$1:Lio/socket/engineio/client/transports/WebSocket$2;

    iput-object p2, p0, Lio/socket/engineio/client/transports/WebSocket$2$3;->val$bytes:Lokio/ByteString;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 112
    iget-object v0, p0, Lio/socket/engineio/client/transports/WebSocket$2$3;->this$1:Lio/socket/engineio/client/transports/WebSocket$2;

    iget-object v0, v0, Lio/socket/engineio/client/transports/WebSocket$2;->val$self:Lio/socket/engineio/client/transports/WebSocket;

    iget-object v1, p0, Lio/socket/engineio/client/transports/WebSocket$2$3;->val$bytes:Lokio/ByteString;

    invoke-virtual {v1}, Lokio/ByteString;->toByteArray()[B

    move-result-object v1

    # invokes: Lio/socket/engineio/client/transports/WebSocket;->onData([B)V
    invoke-static {v0, v1}, Lio/socket/engineio/client/transports/WebSocket;->access$200(Lio/socket/engineio/client/transports/WebSocket;[B)V

    .line 113
    return-void
.end method
