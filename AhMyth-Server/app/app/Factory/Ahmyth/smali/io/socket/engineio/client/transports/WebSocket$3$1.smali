.class Lio/socket/engineio/client/transports/WebSocket$3$1;
.super Ljava/lang/Object;
.source "WebSocket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/WebSocket$3;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/transports/WebSocket$3;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/WebSocket$3;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/transports/WebSocket$3;

    .prologue
    .line 152
    iput-object p1, p0, Lio/socket/engineio/client/transports/WebSocket$3$1;->this$1:Lio/socket/engineio/client/transports/WebSocket$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 155
    iget-object v0, p0, Lio/socket/engineio/client/transports/WebSocket$3$1;->this$1:Lio/socket/engineio/client/transports/WebSocket$3;

    iget-object v0, v0, Lio/socket/engineio/client/transports/WebSocket$3;->val$self:Lio/socket/engineio/client/transports/WebSocket;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lio/socket/engineio/client/transports/WebSocket;->writable:Z

    .line 156
    iget-object v0, p0, Lio/socket/engineio/client/transports/WebSocket$3$1;->this$1:Lio/socket/engineio/client/transports/WebSocket$3;

    iget-object v0, v0, Lio/socket/engineio/client/transports/WebSocket$3;->val$self:Lio/socket/engineio/client/transports/WebSocket;

    const-string v1, "drain"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lio/socket/engineio/client/transports/WebSocket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 157
    return-void
.end method
