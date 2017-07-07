.class Lio/socket/engineio/client/transports/Polling$1$2;
.super Ljava/lang/Object;
.source "Polling.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/Polling$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/transports/Polling$1;

.field final synthetic val$pause:Ljava/lang/Runnable;

.field final synthetic val$total:[I


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/Polling$1;[ILjava/lang/Runnable;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/transports/Polling$1;

    .prologue
    .line 61
    iput-object p1, p0, Lio/socket/engineio/client/transports/Polling$1$2;->this$1:Lio/socket/engineio/client/transports/Polling$1;

    iput-object p2, p0, Lio/socket/engineio/client/transports/Polling$1$2;->val$total:[I

    iput-object p3, p0, Lio/socket/engineio/client/transports/Polling$1$2;->val$pause:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 3
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 64
    # getter for: Lio/socket/engineio/client/transports/Polling;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/engineio/client/transports/Polling;->access$100()Ljava/util/logging/Logger;

    move-result-object v0

    const-string v1, "pre-pause polling complete"

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 65
    iget-object v0, p0, Lio/socket/engineio/client/transports/Polling$1$2;->val$total:[I

    const/4 v1, 0x0

    aget v2, v0, v1

    add-int/lit8 v2, v2, -0x1

    aput v2, v0, v1

    if-nez v2, :cond_0

    .line 66
    iget-object v0, p0, Lio/socket/engineio/client/transports/Polling$1$2;->val$pause:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 68
    :cond_0
    return-void
.end method
