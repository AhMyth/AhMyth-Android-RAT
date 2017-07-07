.class Lio/socket/engineio/client/transports/Polling$4;
.super Ljava/lang/Object;
.source "Polling.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/Polling;->write([Lio/socket/engineio/parser/Packet;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/transports/Polling;

.field final synthetic val$self:Lio/socket/engineio/client/transports/Polling;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/Polling;Lio/socket/engineio/client/transports/Polling;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/transports/Polling;

    .prologue
    .line 178
    iput-object p1, p0, Lio/socket/engineio/client/transports/Polling$4;->this$0:Lio/socket/engineio/client/transports/Polling;

    iput-object p2, p0, Lio/socket/engineio/client/transports/Polling$4;->val$self:Lio/socket/engineio/client/transports/Polling;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 181
    iget-object v0, p0, Lio/socket/engineio/client/transports/Polling$4;->val$self:Lio/socket/engineio/client/transports/Polling;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lio/socket/engineio/client/transports/Polling;->writable:Z

    .line 182
    iget-object v0, p0, Lio/socket/engineio/client/transports/Polling$4;->val$self:Lio/socket/engineio/client/transports/Polling;

    const-string v1, "drain"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lio/socket/engineio/client/transports/Polling;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 183
    return-void
.end method
