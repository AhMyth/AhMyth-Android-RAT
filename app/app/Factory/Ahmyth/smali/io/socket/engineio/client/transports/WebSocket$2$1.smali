.class Lio/socket/engineio/client/transports/WebSocket$2$1;
.super Ljava/lang/Object;
.source "WebSocket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/WebSocket$2;->onOpen(Lokhttp3/WebSocket;Lokhttp3/Response;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/transports/WebSocket$2;

.field final synthetic val$headers:Ljava/util/Map;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/WebSocket$2;Ljava/util/Map;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/transports/WebSocket$2;

    .prologue
    .line 82
    iput-object p1, p0, Lio/socket/engineio/client/transports/WebSocket$2$1;->this$1:Lio/socket/engineio/client/transports/WebSocket$2;

    iput-object p2, p0, Lio/socket/engineio/client/transports/WebSocket$2$1;->val$headers:Ljava/util/Map;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 85
    iget-object v0, p0, Lio/socket/engineio/client/transports/WebSocket$2$1;->this$1:Lio/socket/engineio/client/transports/WebSocket$2;

    iget-object v0, v0, Lio/socket/engineio/client/transports/WebSocket$2;->val$self:Lio/socket/engineio/client/transports/WebSocket;

    const-string v1, "responseHeaders"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p0, Lio/socket/engineio/client/transports/WebSocket$2$1;->val$headers:Ljava/util/Map;

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Lio/socket/engineio/client/transports/WebSocket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 86
    iget-object v0, p0, Lio/socket/engineio/client/transports/WebSocket$2$1;->this$1:Lio/socket/engineio/client/transports/WebSocket$2;

    iget-object v0, v0, Lio/socket/engineio/client/transports/WebSocket$2;->val$self:Lio/socket/engineio/client/transports/WebSocket;

    # invokes: Lio/socket/engineio/client/transports/WebSocket;->onOpen()V
    invoke-static {v0}, Lio/socket/engineio/client/transports/WebSocket;->access$000(Lio/socket/engineio/client/transports/WebSocket;)V

    .line 87
    return-void
.end method
