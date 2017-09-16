.class Lio/socket/engineio/client/transports/PollingXHR$3$1;
.super Ljava/lang/Object;
.source "PollingXHR.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/PollingXHR$3;->call([Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/transports/PollingXHR$3;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/PollingXHR$3;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/transports/PollingXHR$3;

    .prologue
    .line 73
    iput-object p1, p0, Lio/socket/engineio/client/transports/PollingXHR$3$1;->this$1:Lio/socket/engineio/client/transports/PollingXHR$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 76
    iget-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$3$1;->this$1:Lio/socket/engineio/client/transports/PollingXHR$3;

    iget-object v0, v0, Lio/socket/engineio/client/transports/PollingXHR$3;->val$fn:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 77
    return-void
.end method
