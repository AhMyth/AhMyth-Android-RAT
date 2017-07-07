.class Lio/socket/engineio/client/Socket$2;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket;->open()Lio/socket/engineio/client/Socket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/Socket;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/Socket;

    .prologue
    .line 226
    iput-object p1, p0, Lio/socket/engineio/client/Socket$2;->this$0:Lio/socket/engineio/client/Socket;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 230
    iget-object v3, p0, Lio/socket/engineio/client/Socket$2;->this$0:Lio/socket/engineio/client/Socket;

    # getter for: Lio/socket/engineio/client/Socket;->rememberUpgrade:Z
    invoke-static {v3}, Lio/socket/engineio/client/Socket;->access$200(Lio/socket/engineio/client/Socket;)Z

    move-result v3

    if-eqz v3, :cond_0

    # getter for: Lio/socket/engineio/client/Socket;->priorWebsocketSuccess:Z
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$300()Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v3, p0, Lio/socket/engineio/client/Socket$2;->this$0:Lio/socket/engineio/client/Socket;

    # getter for: Lio/socket/engineio/client/Socket;->transports:Ljava/util/List;
    invoke-static {v3}, Lio/socket/engineio/client/Socket;->access$400(Lio/socket/engineio/client/Socket;)Ljava/util/List;

    move-result-object v3

    const-string v4, "websocket"

    invoke-interface {v3, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 231
    const-string v2, "websocket"

    .line 245
    .local v2, "transportName":Ljava/lang/String;
    :goto_0
    iget-object v3, p0, Lio/socket/engineio/client/Socket$2;->this$0:Lio/socket/engineio/client/Socket;

    sget-object v4, Lio/socket/engineio/client/Socket$ReadyState;->OPENING:Lio/socket/engineio/client/Socket$ReadyState;

    # setter for: Lio/socket/engineio/client/Socket;->readyState:Lio/socket/engineio/client/Socket$ReadyState;
    invoke-static {v3, v4}, Lio/socket/engineio/client/Socket;->access$502(Lio/socket/engineio/client/Socket;Lio/socket/engineio/client/Socket$ReadyState;)Lio/socket/engineio/client/Socket$ReadyState;

    .line 246
    iget-object v3, p0, Lio/socket/engineio/client/Socket$2;->this$0:Lio/socket/engineio/client/Socket;

    # invokes: Lio/socket/engineio/client/Socket;->createTransport(Ljava/lang/String;)Lio/socket/engineio/client/Transport;
    invoke-static {v3, v2}, Lio/socket/engineio/client/Socket;->access$600(Lio/socket/engineio/client/Socket;Ljava/lang/String;)Lio/socket/engineio/client/Transport;

    move-result-object v1

    .line 247
    .local v1, "transport":Lio/socket/engineio/client/Transport;
    iget-object v3, p0, Lio/socket/engineio/client/Socket$2;->this$0:Lio/socket/engineio/client/Socket;

    # invokes: Lio/socket/engineio/client/Socket;->setTransport(Lio/socket/engineio/client/Transport;)V
    invoke-static {v3, v1}, Lio/socket/engineio/client/Socket;->access$700(Lio/socket/engineio/client/Socket;Lio/socket/engineio/client/Transport;)V

    .line 248
    invoke-virtual {v1}, Lio/socket/engineio/client/Transport;->open()Lio/socket/engineio/client/Transport;

    .line 249
    .end local v1    # "transport":Lio/socket/engineio/client/Transport;
    .end local v2    # "transportName":Ljava/lang/String;
    :goto_1
    return-void

    .line 232
    :cond_0
    iget-object v3, p0, Lio/socket/engineio/client/Socket$2;->this$0:Lio/socket/engineio/client/Socket;

    # getter for: Lio/socket/engineio/client/Socket;->transports:Ljava/util/List;
    invoke-static {v3}, Lio/socket/engineio/client/Socket;->access$400(Lio/socket/engineio/client/Socket;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-nez v3, :cond_1

    .line 234
    iget-object v0, p0, Lio/socket/engineio/client/Socket$2;->this$0:Lio/socket/engineio/client/Socket;

    .line 235
    .local v0, "self":Lio/socket/engineio/client/Socket;
    new-instance v3, Lio/socket/engineio/client/Socket$2$1;

    invoke-direct {v3, p0, v0}, Lio/socket/engineio/client/Socket$2$1;-><init>(Lio/socket/engineio/client/Socket$2;Lio/socket/engineio/client/Socket;)V

    invoke-static {v3}, Lio/socket/thread/EventThread;->nextTick(Ljava/lang/Runnable;)V

    goto :goto_1

    .line 243
    .end local v0    # "self":Lio/socket/engineio/client/Socket;
    :cond_1
    iget-object v3, p0, Lio/socket/engineio/client/Socket$2;->this$0:Lio/socket/engineio/client/Socket;

    # getter for: Lio/socket/engineio/client/Socket;->transports:Ljava/util/List;
    invoke-static {v3}, Lio/socket/engineio/client/Socket;->access$400(Lio/socket/engineio/client/Socket;)Ljava/util/List;

    move-result-object v3

    const/4 v4, 0x0

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .restart local v2    # "transportName":Ljava/lang/String;
    goto :goto_0
.end method
