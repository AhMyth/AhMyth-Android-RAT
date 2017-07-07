.class Lio/socket/engineio/client/transports/WebSocket$2$2;
.super Ljava/lang/Object;
.source "WebSocket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/WebSocket$2;->onMessage(Lokhttp3/WebSocket;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/transports/WebSocket$2;

.field final synthetic val$text:Ljava/lang/String;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/WebSocket$2;Ljava/lang/String;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/transports/WebSocket$2;

    .prologue
    .line 96
    iput-object p1, p0, Lio/socket/engineio/client/transports/WebSocket$2$2;->this$1:Lio/socket/engineio/client/transports/WebSocket$2;

    iput-object p2, p0, Lio/socket/engineio/client/transports/WebSocket$2$2;->val$text:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 99
    iget-object v0, p0, Lio/socket/engineio/client/transports/WebSocket$2$2;->this$1:Lio/socket/engineio/client/transports/WebSocket$2;

    iget-object v0, v0, Lio/socket/engineio/client/transports/WebSocket$2;->val$self:Lio/socket/engineio/client/transports/WebSocket;

    iget-object v1, p0, Lio/socket/engineio/client/transports/WebSocket$2$2;->val$text:Ljava/lang/String;

    # invokes: Lio/socket/engineio/client/transports/WebSocket;->onData(Ljava/lang/String;)V
    invoke-static {v0, v1}, Lio/socket/engineio/client/transports/WebSocket;->access$100(Lio/socket/engineio/client/transports/WebSocket;Ljava/lang/String;)V

    .line 100
    return-void
.end method
