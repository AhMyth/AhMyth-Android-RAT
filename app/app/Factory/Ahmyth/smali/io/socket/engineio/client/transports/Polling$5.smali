.class Lio/socket/engineio/client/transports/Polling$5;
.super Ljava/lang/Object;
.source "Polling.java"

# interfaces
.implements Lio/socket/engineio/parser/Parser$EncodeCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/Polling;->write([Lio/socket/engineio/parser/Packet;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lio/socket/engineio/parser/Parser$EncodeCallback",
        "<[B>;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/transports/Polling;

.field final synthetic val$callbackfn:Ljava/lang/Runnable;

.field final synthetic val$self:Lio/socket/engineio/client/transports/Polling;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/Polling;Lio/socket/engineio/client/transports/Polling;Ljava/lang/Runnable;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/transports/Polling;

    .prologue
    .line 186
    iput-object p1, p0, Lio/socket/engineio/client/transports/Polling$5;->this$0:Lio/socket/engineio/client/transports/Polling;

    iput-object p2, p0, Lio/socket/engineio/client/transports/Polling$5;->val$self:Lio/socket/engineio/client/transports/Polling;

    iput-object p3, p0, Lio/socket/engineio/client/transports/Polling$5;->val$callbackfn:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic call(Ljava/lang/Object;)V
    .locals 0

    .prologue
    .line 186
    check-cast p1, [B

    invoke-virtual {p0, p1}, Lio/socket/engineio/client/transports/Polling$5;->call([B)V

    return-void
.end method

.method public call([B)V
    .locals 2
    .param p1, "data"    # [B

    .prologue
    .line 189
    iget-object v0, p0, Lio/socket/engineio/client/transports/Polling$5;->val$self:Lio/socket/engineio/client/transports/Polling;

    iget-object v1, p0, Lio/socket/engineio/client/transports/Polling$5;->val$callbackfn:Ljava/lang/Runnable;

    invoke-virtual {v0, p1, v1}, Lio/socket/engineio/client/transports/Polling;->doWrite([BLjava/lang/Runnable;)V

    .line 190
    return-void
.end method
