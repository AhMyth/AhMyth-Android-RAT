.class Lio/socket/engineio/client/Socket$7$1;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket$7;->call([Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/Socket$7;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket$7;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/Socket$7;

    .prologue
    .line 346
    iput-object p1, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 8
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 349
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$failed:[Z

    aget-boolean v2, v2, v6

    if-eqz v2, :cond_1

    .line 385
    :cond_0
    :goto_0
    return-void

    .line 351
    :cond_1
    aget-object v1, p1, v6

    check-cast v1, Lio/socket/engineio/parser/Packet;

    .line 352
    .local v1, "msg":Lio/socket/engineio/parser/Packet;
    const-string v2, "pong"

    iget-object v3, v1, Lio/socket/engineio/parser/Packet;->type:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    const-string v2, "probe"

    iget-object v3, v1, Lio/socket/engineio/parser/Packet;->data:Ljava/lang/Object;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 353
    # getter for: Lio/socket/engineio/client/Socket;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v2

    const-string v3, "probe transport \'%s\' pong"

    new-array v4, v7, [Ljava/lang/Object;

    iget-object v5, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v5, v5, Lio/socket/engineio/client/Socket$7;->val$name:Ljava/lang/String;

    aput-object v5, v4, v6

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 354
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    # setter for: Lio/socket/engineio/client/Socket;->upgrading:Z
    invoke-static {v2, v7}, Lio/socket/engineio/client/Socket;->access$1302(Lio/socket/engineio/client/Socket;Z)Z

    .line 355
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    const-string v3, "upgrading"

    new-array v4, v7, [Ljava/lang/Object;

    iget-object v5, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v5, v5, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v5, v5, v6

    aput-object v5, v4, v6

    invoke-virtual {v2, v3, v4}, Lio/socket/engineio/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 356
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v2, v2, v6

    if-eqz v2, :cond_0

    .line 357
    const-string v2, "websocket"

    iget-object v3, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v3, v3, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v3, v3, v6

    iget-object v3, v3, Lio/socket/engineio/client/Transport;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    # setter for: Lio/socket/engineio/client/Socket;->priorWebsocketSuccess:Z
    invoke-static {v2}, Lio/socket/engineio/client/Socket;->access$302(Z)Z

    .line 359
    # getter for: Lio/socket/engineio/client/Socket;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v2

    const-string v3, "pausing current transport \'%s\'"

    new-array v4, v7, [Ljava/lang/Object;

    iget-object v5, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v5, v5, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    iget-object v5, v5, Lio/socket/engineio/client/Socket;->transport:Lio/socket/engineio/client/Transport;

    iget-object v5, v5, Lio/socket/engineio/client/Transport;->name:Ljava/lang/String;

    aput-object v5, v4, v6

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 360
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    iget-object v2, v2, Lio/socket/engineio/client/Socket;->transport:Lio/socket/engineio/client/Transport;

    check-cast v2, Lio/socket/engineio/client/transports/Polling;

    new-instance v3, Lio/socket/engineio/client/Socket$7$1$1;

    invoke-direct {v3, p0}, Lio/socket/engineio/client/Socket$7$1$1;-><init>(Lio/socket/engineio/client/Socket$7$1;)V

    invoke-virtual {v2, v3}, Lio/socket/engineio/client/transports/Polling;->pause(Ljava/lang/Runnable;)V

    goto/16 :goto_0

    .line 380
    :cond_2
    # getter for: Lio/socket/engineio/client/Socket;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v2

    const-string v3, "probe transport \'%s\' failed"

    new-array v4, v7, [Ljava/lang/Object;

    iget-object v5, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v5, v5, Lio/socket/engineio/client/Socket$7;->val$name:Ljava/lang/String;

    aput-object v5, v4, v6

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 381
    new-instance v0, Lio/socket/engineio/client/EngineIOException;

    const-string v2, "probe error"

    invoke-direct {v0, v2}, Lio/socket/engineio/client/EngineIOException;-><init>(Ljava/lang/String;)V

    .line 382
    .local v0, "err":Lio/socket/engineio/client/EngineIOException;
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v2, v2, v6

    iget-object v2, v2, Lio/socket/engineio/client/Transport;->name:Ljava/lang/String;

    iput-object v2, v0, Lio/socket/engineio/client/EngineIOException;->transport:Ljava/lang/String;

    .line 383
    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    const-string v3, "upgradeError"

    new-array v4, v7, [Ljava/lang/Object;

    aput-object v0, v4, v6

    invoke-virtual {v2, v3, v4}, Lio/socket/engineio/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    goto/16 :goto_0
.end method
