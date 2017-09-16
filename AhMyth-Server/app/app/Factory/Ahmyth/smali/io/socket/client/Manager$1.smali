.class Lio/socket/client/Manager$1;
.super Ljava/lang/Object;
.source "Manager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Manager;->open(Lio/socket/client/Manager$OpenCallback;)Lio/socket/client/Manager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Manager;

.field final synthetic val$fn:Lio/socket/client/Manager$OpenCallback;


# direct methods
.method constructor <init>(Lio/socket/client/Manager;Lio/socket/client/Manager$OpenCallback;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Manager;

    .prologue
    .line 250
    iput-object p1, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    iput-object p2, p0, Lio/socket/client/Manager$1;->val$fn:Lio/socket/client/Manager$OpenCallback;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 14

    .prologue
    const/4 v13, 0x1

    const/4 v12, 0x0

    .line 253
    # getter for: Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/client/Manager;->access$000()Ljava/util/logging/Logger;

    move-result-object v0

    const-string v1, "readyState %s"

    new-array v9, v13, [Ljava/lang/Object;

    iget-object v10, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    iget-object v10, v10, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    aput-object v10, v9, v12

    invoke-static {v1, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 254
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    iget-object v0, v0, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    sget-object v1, Lio/socket/client/Manager$ReadyState;->OPEN:Lio/socket/client/Manager$ReadyState;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    iget-object v0, v0, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    sget-object v1, Lio/socket/client/Manager$ReadyState;->OPENING:Lio/socket/client/Manager$ReadyState;

    if-ne v0, v1, :cond_1

    .line 331
    :cond_0
    :goto_0
    return-void

    .line 256
    :cond_1
    # getter for: Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/client/Manager;->access$000()Ljava/util/logging/Logger;

    move-result-object v0

    const-string v1, "opening %s"

    new-array v9, v13, [Ljava/lang/Object;

    iget-object v10, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    # getter for: Lio/socket/client/Manager;->uri:Ljava/net/URI;
    invoke-static {v10}, Lio/socket/client/Manager;->access$100(Lio/socket/client/Manager;)Ljava/net/URI;

    move-result-object v10

    aput-object v10, v9, v12

    invoke-static {v1, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 257
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    new-instance v1, Lio/socket/client/Manager$Engine;

    iget-object v9, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    # getter for: Lio/socket/client/Manager;->uri:Ljava/net/URI;
    invoke-static {v9}, Lio/socket/client/Manager;->access$100(Lio/socket/client/Manager;)Ljava/net/URI;

    move-result-object v9

    iget-object v10, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    # getter for: Lio/socket/client/Manager;->opts:Lio/socket/client/Manager$Options;
    invoke-static {v10}, Lio/socket/client/Manager;->access$200(Lio/socket/client/Manager;)Lio/socket/client/Manager$Options;

    move-result-object v10

    invoke-direct {v1, v9, v10}, Lio/socket/client/Manager$Engine;-><init>(Ljava/net/URI;Lio/socket/engineio/client/Socket$Options;)V

    iput-object v1, v0, Lio/socket/client/Manager;->engine:Lio/socket/engineio/client/Socket;

    .line 258
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    iget-object v5, v0, Lio/socket/client/Manager;->engine:Lio/socket/engineio/client/Socket;

    .line 259
    .local v5, "socket":Lio/socket/engineio/client/Socket;
    iget-object v6, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    .line 260
    .local v6, "self":Lio/socket/client/Manager;
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    sget-object v1, Lio/socket/client/Manager$ReadyState;->OPENING:Lio/socket/client/Manager$ReadyState;

    iput-object v1, v0, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    .line 261
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    # setter for: Lio/socket/client/Manager;->skipReconnect:Z
    invoke-static {v0, v12}, Lio/socket/client/Manager;->access$302(Lio/socket/client/Manager;Z)Z

    .line 264
    const-string v0, "transport"

    new-instance v1, Lio/socket/client/Manager$1$1;

    invoke-direct {v1, p0, v6}, Lio/socket/client/Manager$1$1;-><init>(Lio/socket/client/Manager$1;Lio/socket/client/Manager;)V

    invoke-virtual {v5, v0, v1}, Lio/socket/engineio/client/Socket;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 271
    const-string v0, "open"

    new-instance v1, Lio/socket/client/Manager$1$2;

    invoke-direct {v1, p0, v6}, Lio/socket/client/Manager$1$2;-><init>(Lio/socket/client/Manager$1;Lio/socket/client/Manager;)V

    invoke-static {v5, v0, v1}, Lio/socket/client/On;->on(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/On$Handle;

    move-result-object v4

    .line 279
    .local v4, "openSub":Lio/socket/client/On$Handle;
    const-string v0, "error"

    new-instance v1, Lio/socket/client/Manager$1$3;

    invoke-direct {v1, p0, v6}, Lio/socket/client/Manager$1$3;-><init>(Lio/socket/client/Manager$1;Lio/socket/client/Manager;)V

    invoke-static {v5, v0, v1}, Lio/socket/client/On;->on(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/On$Handle;

    move-result-object v7

    .line 298
    .local v7, "errorSub":Lio/socket/client/On$Handle;
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    # getter for: Lio/socket/client/Manager;->_timeout:J
    invoke-static {v0}, Lio/socket/client/Manager;->access$800(Lio/socket/client/Manager;)J

    move-result-wide v0

    const-wide/16 v10, 0x0

    cmp-long v0, v0, v10

    if-ltz v0, :cond_2

    .line 299
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    # getter for: Lio/socket/client/Manager;->_timeout:J
    invoke-static {v0}, Lio/socket/client/Manager;->access$800(Lio/socket/client/Manager;)J

    move-result-wide v2

    .line 300
    .local v2, "timeout":J
    # getter for: Lio/socket/client/Manager;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/client/Manager;->access$000()Ljava/util/logging/Logger;

    move-result-object v0

    const-string v1, "connection attempt will timeout after %d"

    new-array v9, v13, [Ljava/lang/Object;

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v10

    aput-object v10, v9, v12

    invoke-static {v1, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 302
    new-instance v8, Ljava/util/Timer;

    invoke-direct {v8}, Ljava/util/Timer;-><init>()V

    .line 303
    .local v8, "timer":Ljava/util/Timer;
    new-instance v0, Lio/socket/client/Manager$1$4;

    move-object v1, p0

    invoke-direct/range {v0 .. v6}, Lio/socket/client/Manager$1$4;-><init>(Lio/socket/client/Manager$1;JLio/socket/client/On$Handle;Lio/socket/engineio/client/Socket;Lio/socket/client/Manager;)V

    invoke-virtual {v8, v0, v2, v3}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V

    .line 319
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    # getter for: Lio/socket/client/Manager;->subs:Ljava/util/Queue;
    invoke-static {v0}, Lio/socket/client/Manager;->access$900(Lio/socket/client/Manager;)Ljava/util/Queue;

    move-result-object v0

    new-instance v1, Lio/socket/client/Manager$1$5;

    invoke-direct {v1, p0, v8}, Lio/socket/client/Manager$1$5;-><init>(Lio/socket/client/Manager$1;Ljava/util/Timer;)V

    invoke-interface {v0, v1}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 327
    .end local v2    # "timeout":J
    .end local v8    # "timer":Ljava/util/Timer;
    :cond_2
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    # getter for: Lio/socket/client/Manager;->subs:Ljava/util/Queue;
    invoke-static {v0}, Lio/socket/client/Manager;->access$900(Lio/socket/client/Manager;)Ljava/util/Queue;

    move-result-object v0

    invoke-interface {v0, v4}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 328
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    # getter for: Lio/socket/client/Manager;->subs:Ljava/util/Queue;
    invoke-static {v0}, Lio/socket/client/Manager;->access$900(Lio/socket/client/Manager;)Ljava/util/Queue;

    move-result-object v0

    invoke-interface {v0, v7}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    .line 330
    iget-object v0, p0, Lio/socket/client/Manager$1;->this$0:Lio/socket/client/Manager;

    iget-object v0, v0, Lio/socket/client/Manager;->engine:Lio/socket/engineio/client/Socket;

    invoke-virtual {v0}, Lio/socket/engineio/client/Socket;->open()Lio/socket/engineio/client/Socket;

    goto/16 :goto_0
.end method
