.class Lio/socket/engineio/client/transports/WebSocket$2$4;
.super Ljava/lang/Object;
.source "WebSocket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/WebSocket$2;->onClosed(Lokhttp3/WebSocket;ILjava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/transports/WebSocket$2;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/WebSocket$2;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/transports/WebSocket$2;

    .prologue
    .line 119
    iput-object p1, p0, Lio/socket/engineio/client/transports/WebSocket$2$4;->this$1:Lio/socket/engineio/client/transports/WebSocket$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 122
    iget-object v0, p0, Lio/socket/engineio/client/transports/WebSocket$2$4;->this$1:Lio/socket/engineio/client/transports/WebSocket$2;

    iget-object v0, v0, Lio/socket/engineio/client/transports/WebSocket$2;->val$self:Lio/socket/engineio/client/transports/WebSocket;

    # invokes: Lio/socket/engineio/client/transports/WebSocket;->onClose()V
    invoke-static {v0}, Lio/socket/engineio/client/transports/WebSocket;->access$300(Lio/socket/engineio/client/transports/WebSocket;)V

    .line 123
    return-void
.end method
