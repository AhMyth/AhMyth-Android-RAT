.class Lio/socket/engineio/client/Socket$7$1$1;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket$7$1;->call([Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$2:Lio/socket/engineio/client/Socket$7$1;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket$7$1;)V
    .locals 0
    .param p1, "this$2"    # Lio/socket/engineio/client/Socket$7$1;

    .prologue
    .line 360
    iput-object p1, p0, Lio/socket/engineio/client/Socket$7$1$1;->this$2:Lio/socket/engineio/client/Socket$7$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    const/4 v3, 0x1

    const/4 v5, 0x0

    .line 363
    iget-object v1, p0, Lio/socket/engineio/client/Socket$7$1$1;->this$2:Lio/socket/engineio/client/Socket$7$1;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7;->val$failed:[Z

    aget-boolean v1, v1, v5

    if-eqz v1, :cond_1

    .line 377
    :cond_0
    :goto_0
    return-void

    .line 364
    :cond_1
    sget-object v1, Lio/socket/engineio/client/Socket$ReadyState;->CLOSED:Lio/socket/engineio/client/Socket$ReadyState;

    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1$1;->this$2:Lio/socket/engineio/client/Socket$7$1;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    # getter for: Lio/socket/engineio/client/Socket;->readyState:Lio/socket/engineio/client/Socket$ReadyState;
    invoke-static {v2}, Lio/socket/engineio/client/Socket;->access$500(Lio/socket/engineio/client/Socket;)Lio/socket/engineio/client/Socket$ReadyState;

    move-result-object v2

    if-eq v1, v2, :cond_0

    .line 366
    # getter for: Lio/socket/engineio/client/Socket;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v1

    const-string v2, "changing transport and sending upgrade packet"

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 368
    iget-object v1, p0, Lio/socket/engineio/client/Socket$7$1$1;->this$2:Lio/socket/engineio/client/Socket$7$1;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7;->val$cleanup:[Ljava/lang/Runnable;

    aget-object v1, v1, v5

    invoke-interface {v1}, Ljava/lang/Runnable;->run()V

    .line 370
    iget-object v1, p0, Lio/socket/engineio/client/Socket$7$1$1;->this$2:Lio/socket/engineio/client/Socket$7$1;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    iget-object v2, p0, Lio/socket/engineio/client/Socket$7$1$1;->this$2:Lio/socket/engineio/client/Socket$7$1;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v2, v2, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v2, v2, v5

    # invokes: Lio/socket/engineio/client/Socket;->setTransport(Lio/socket/engineio/client/Transport;)V
    invoke-static {v1, v2}, Lio/socket/engineio/client/Socket;->access$700(Lio/socket/engineio/client/Socket;Lio/socket/engineio/client/Transport;)V

    .line 371
    new-instance v0, Lio/socket/engineio/parser/Packet;

    const-string v1, "upgrade"

    invoke-direct {v0, v1}, Lio/socket/engineio/parser/Packet;-><init>(Ljava/lang/String;)V

    .line 372
    .local v0, "packet":Lio/socket/engineio/parser/Packet;
    iget-object v1, p0, Lio/socket/engineio/client/Socket$7$1$1;->this$2:Lio/socket/engineio/client/Socket$7$1;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v1, v1, v5

    new-array v2, v3, [Lio/socket/engineio/parser/Packet;

    aput-object v0, v2, v5

    invoke-virtual {v1, v2}, Lio/socket/engineio/client/Transport;->send([Lio/socket/engineio/parser/Packet;)V

    .line 373
    iget-object v1, p0, Lio/socket/engineio/client/Socket$7$1$1;->this$2:Lio/socket/engineio/client/Socket$7$1;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    const-string v2, "upgrade"

    new-array v3, v3, [Ljava/lang/Object;

    iget-object v4, p0, Lio/socket/engineio/client/Socket$7$1$1;->this$2:Lio/socket/engineio/client/Socket$7$1;

    iget-object v4, v4, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v4, v4, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v4, v4, v5

    aput-object v4, v3, v5

    invoke-virtual {v1, v2, v3}, Lio/socket/engineio/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 374
    iget-object v1, p0, Lio/socket/engineio/client/Socket$7$1$1;->this$2:Lio/socket/engineio/client/Socket$7$1;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7;->val$transport:[Lio/socket/engineio/client/Transport;

    const/4 v2, 0x0

    aput-object v2, v1, v5

    .line 375
    iget-object v1, p0, Lio/socket/engineio/client/Socket$7$1$1;->this$2:Lio/socket/engineio/client/Socket$7$1;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    # setter for: Lio/socket/engineio/client/Socket;->upgrading:Z
    invoke-static {v1, v5}, Lio/socket/engineio/client/Socket;->access$1302(Lio/socket/engineio/client/Socket;Z)Z

    .line 376
    iget-object v1, p0, Lio/socket/engineio/client/Socket$7$1$1;->this$2:Lio/socket/engineio/client/Socket$7$1;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7$1;->this$1:Lio/socket/engineio/client/Socket$7;

    iget-object v1, v1, Lio/socket/engineio/client/Socket$7;->val$self:Lio/socket/engineio/client/Socket;

    # invokes: Lio/socket/engineio/client/Socket;->flush()V
    invoke-static {v1}, Lio/socket/engineio/client/Socket;->access$1400(Lio/socket/engineio/client/Socket;)V

    goto :goto_0
.end method
