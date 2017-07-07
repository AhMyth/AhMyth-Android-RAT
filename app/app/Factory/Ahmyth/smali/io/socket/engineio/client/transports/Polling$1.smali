.class Lio/socket/engineio/client/transports/Polling$1;
.super Ljava/lang/Object;
.source "Polling.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/Polling;->pause(Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/transports/Polling;

.field final synthetic val$onPause:Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/Polling;Ljava/lang/Runnable;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/transports/Polling;

    .prologue
    .line 39
    iput-object p1, p0, Lio/socket/engineio/client/transports/Polling$1;->this$0:Lio/socket/engineio/client/transports/Polling;

    iput-object p2, p0, Lio/socket/engineio/client/transports/Polling$1;->val$onPause:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 42
    iget-object v1, p0, Lio/socket/engineio/client/transports/Polling$1;->this$0:Lio/socket/engineio/client/transports/Polling;

    .line 44
    .local v1, "self":Lio/socket/engineio/client/transports/Polling;
    iget-object v3, p0, Lio/socket/engineio/client/transports/Polling$1;->this$0:Lio/socket/engineio/client/transports/Polling;

    sget-object v4, Lio/socket/engineio/client/Transport$ReadyState;->PAUSED:Lio/socket/engineio/client/Transport$ReadyState;

    # setter for: Lio/socket/engineio/client/transports/Polling;->readyState:Lio/socket/engineio/client/Transport$ReadyState;
    invoke-static {v3, v4}, Lio/socket/engineio/client/transports/Polling;->access$002(Lio/socket/engineio/client/transports/Polling;Lio/socket/engineio/client/Transport$ReadyState;)Lio/socket/engineio/client/Transport$ReadyState;

    .line 46
    new-instance v0, Lio/socket/engineio/client/transports/Polling$1$1;

    invoke-direct {v0, p0, v1}, Lio/socket/engineio/client/transports/Polling$1$1;-><init>(Lio/socket/engineio/client/transports/Polling$1;Lio/socket/engineio/client/transports/Polling;)V

    .line 55
    .local v0, "pause":Ljava/lang/Runnable;
    iget-object v3, p0, Lio/socket/engineio/client/transports/Polling$1;->this$0:Lio/socket/engineio/client/transports/Polling;

    # getter for: Lio/socket/engineio/client/transports/Polling;->polling:Z
    invoke-static {v3}, Lio/socket/engineio/client/transports/Polling;->access$300(Lio/socket/engineio/client/transports/Polling;)Z

    move-result v3

    if-nez v3, :cond_0

    iget-object v3, p0, Lio/socket/engineio/client/transports/Polling$1;->this$0:Lio/socket/engineio/client/transports/Polling;

    iget-boolean v3, v3, Lio/socket/engineio/client/transports/Polling;->writable:Z

    if-nez v3, :cond_3

    .line 56
    :cond_0
    const/4 v3, 0x1

    new-array v2, v3, [I

    aput v6, v2, v6

    .line 58
    .local v2, "total":[I
    iget-object v3, p0, Lio/socket/engineio/client/transports/Polling$1;->this$0:Lio/socket/engineio/client/transports/Polling;

    # getter for: Lio/socket/engineio/client/transports/Polling;->polling:Z
    invoke-static {v3}, Lio/socket/engineio/client/transports/Polling;->access$300(Lio/socket/engineio/client/transports/Polling;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 59
    # getter for: Lio/socket/engineio/client/transports/Polling;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/engineio/client/transports/Polling;->access$100()Ljava/util/logging/Logger;

    move-result-object v3

    const-string v4, "we are currently polling - waiting to pause"

    invoke-virtual {v3, v4}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 60
    aget v3, v2, v6

    add-int/lit8 v3, v3, 0x1

    aput v3, v2, v6

    .line 61
    iget-object v3, p0, Lio/socket/engineio/client/transports/Polling$1;->this$0:Lio/socket/engineio/client/transports/Polling;

    const-string v4, "pollComplete"

    new-instance v5, Lio/socket/engineio/client/transports/Polling$1$2;

    invoke-direct {v5, p0, v2, v0}, Lio/socket/engineio/client/transports/Polling$1$2;-><init>(Lio/socket/engineio/client/transports/Polling$1;[ILjava/lang/Runnable;)V

    invoke-virtual {v3, v4, v5}, Lio/socket/engineio/client/transports/Polling;->once(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 72
    :cond_1
    iget-object v3, p0, Lio/socket/engineio/client/transports/Polling$1;->this$0:Lio/socket/engineio/client/transports/Polling;

    iget-boolean v3, v3, Lio/socket/engineio/client/transports/Polling;->writable:Z

    if-nez v3, :cond_2

    .line 73
    # getter for: Lio/socket/engineio/client/transports/Polling;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/engineio/client/transports/Polling;->access$100()Ljava/util/logging/Logger;

    move-result-object v3

    const-string v4, "we are currently writing - waiting to pause"

    invoke-virtual {v3, v4}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 74
    aget v3, v2, v6

    add-int/lit8 v3, v3, 0x1

    aput v3, v2, v6

    .line 75
    iget-object v3, p0, Lio/socket/engineio/client/transports/Polling$1;->this$0:Lio/socket/engineio/client/transports/Polling;

    const-string v4, "drain"

    new-instance v5, Lio/socket/engineio/client/transports/Polling$1$3;

    invoke-direct {v5, p0, v2, v0}, Lio/socket/engineio/client/transports/Polling$1$3;-><init>(Lio/socket/engineio/client/transports/Polling$1;[ILjava/lang/Runnable;)V

    invoke-virtual {v3, v4, v5}, Lio/socket/engineio/client/transports/Polling;->once(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 88
    .end local v2    # "total":[I
    :cond_2
    :goto_0
    return-void

    .line 86
    :cond_3
    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    goto :goto_0
.end method
