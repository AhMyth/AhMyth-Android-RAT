.class Lio/socket/engineio/client/transports/Polling$3;
.super Ljava/lang/Object;
.source "Polling.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/Polling;->doClose()V
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
    .line 152
    iput-object p1, p0, Lio/socket/engineio/client/transports/Polling$3;->this$0:Lio/socket/engineio/client/transports/Polling;

    iput-object p2, p0, Lio/socket/engineio/client/transports/Polling$3;->val$self:Lio/socket/engineio/client/transports/Polling;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 6
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 155
    # getter for: Lio/socket/engineio/client/transports/Polling;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/engineio/client/transports/Polling;->access$100()Ljava/util/logging/Logger;

    move-result-object v1

    const-string v2, "writing close packet"

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 157
    :try_start_0
    iget-object v1, p0, Lio/socket/engineio/client/transports/Polling$3;->val$self:Lio/socket/engineio/client/transports/Polling;

    const/4 v2, 0x1

    new-array v2, v2, [Lio/socket/engineio/parser/Packet;

    const/4 v3, 0x0

    new-instance v4, Lio/socket/engineio/parser/Packet;

    const-string v5, "close"

    invoke-direct {v4, v5}, Lio/socket/engineio/parser/Packet;-><init>(Ljava/lang/String;)V

    aput-object v4, v2, v3

    invoke-virtual {v1, v2}, Lio/socket/engineio/client/transports/Polling;->write([Lio/socket/engineio/parser/Packet;)V
    :try_end_0
    .catch Lio/socket/utf8/UTF8Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 161
    return-void

    .line 158
    :catch_0
    move-exception v0

    .line 159
    .local v0, "err":Lio/socket/utf8/UTF8Exception;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method
