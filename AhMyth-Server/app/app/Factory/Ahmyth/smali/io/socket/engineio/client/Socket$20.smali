.class Lio/socket/engineio/client/Socket$20;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket;->close()Lio/socket/engineio/client/Socket;
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
    .line 711
    iput-object p1, p0, Lio/socket/engineio/client/Socket$20;->this$0:Lio/socket/engineio/client/Socket;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    .line 714
    iget-object v4, p0, Lio/socket/engineio/client/Socket$20;->this$0:Lio/socket/engineio/client/Socket;

    # getter for: Lio/socket/engineio/client/Socket;->readyState:Lio/socket/engineio/client/Socket$ReadyState;
    invoke-static {v4}, Lio/socket/engineio/client/Socket;->access$500(Lio/socket/engineio/client/Socket;)Lio/socket/engineio/client/Socket$ReadyState;

    move-result-object v4

    sget-object v5, Lio/socket/engineio/client/Socket$ReadyState;->OPENING:Lio/socket/engineio/client/Socket$ReadyState;

    if-eq v4, v5, :cond_0

    iget-object v4, p0, Lio/socket/engineio/client/Socket$20;->this$0:Lio/socket/engineio/client/Socket;

    # getter for: Lio/socket/engineio/client/Socket;->readyState:Lio/socket/engineio/client/Socket$ReadyState;
    invoke-static {v4}, Lio/socket/engineio/client/Socket;->access$500(Lio/socket/engineio/client/Socket;)Lio/socket/engineio/client/Socket$ReadyState;

    move-result-object v4

    sget-object v5, Lio/socket/engineio/client/Socket$ReadyState;->OPEN:Lio/socket/engineio/client/Socket$ReadyState;

    if-ne v4, v5, :cond_1

    .line 715
    :cond_0
    iget-object v4, p0, Lio/socket/engineio/client/Socket$20;->this$0:Lio/socket/engineio/client/Socket;

    sget-object v5, Lio/socket/engineio/client/Socket$ReadyState;->CLOSING:Lio/socket/engineio/client/Socket$ReadyState;

    # setter for: Lio/socket/engineio/client/Socket;->readyState:Lio/socket/engineio/client/Socket$ReadyState;
    invoke-static {v4, v5}, Lio/socket/engineio/client/Socket;->access$502(Lio/socket/engineio/client/Socket;Lio/socket/engineio/client/Socket$ReadyState;)Lio/socket/engineio/client/Socket$ReadyState;

    .line 717
    iget-object v2, p0, Lio/socket/engineio/client/Socket$20;->this$0:Lio/socket/engineio/client/Socket;

    .line 719
    .local v2, "self":Lio/socket/engineio/client/Socket;
    new-instance v1, Lio/socket/engineio/client/Socket$20$1;

    invoke-direct {v1, p0, v2}, Lio/socket/engineio/client/Socket$20$1;-><init>(Lio/socket/engineio/client/Socket$20;Lio/socket/engineio/client/Socket;)V

    .line 728
    .local v1, "close":Ljava/lang/Runnable;
    const/4 v4, 0x1

    new-array v0, v4, [Lio/socket/emitter/Emitter$Listener;

    .line 729
    .local v0, "cleanupAndClose":[Lio/socket/emitter/Emitter$Listener;
    const/4 v4, 0x0

    new-instance v5, Lio/socket/engineio/client/Socket$20$2;

    invoke-direct {v5, p0, v2, v0, v1}, Lio/socket/engineio/client/Socket$20$2;-><init>(Lio/socket/engineio/client/Socket$20;Lio/socket/engineio/client/Socket;[Lio/socket/emitter/Emitter$Listener;Ljava/lang/Runnable;)V

    aput-object v5, v0, v4

    .line 738
    new-instance v3, Lio/socket/engineio/client/Socket$20$3;

    invoke-direct {v3, p0, v2, v0}, Lio/socket/engineio/client/Socket$20$3;-><init>(Lio/socket/engineio/client/Socket$20;Lio/socket/engineio/client/Socket;[Lio/socket/emitter/Emitter$Listener;)V

    .line 747
    .local v3, "waitForUpgrade":Ljava/lang/Runnable;
    iget-object v4, p0, Lio/socket/engineio/client/Socket$20;->this$0:Lio/socket/engineio/client/Socket;

    iget-object v4, v4, Lio/socket/engineio/client/Socket;->writeBuffer:Ljava/util/LinkedList;

    invoke-virtual {v4}, Ljava/util/LinkedList;->size()I

    move-result v4

    if-lez v4, :cond_2

    .line 748
    iget-object v4, p0, Lio/socket/engineio/client/Socket$20;->this$0:Lio/socket/engineio/client/Socket;

    const-string v5, "drain"

    new-instance v6, Lio/socket/engineio/client/Socket$20$4;

    invoke-direct {v6, p0, v3, v1}, Lio/socket/engineio/client/Socket$20$4;-><init>(Lio/socket/engineio/client/Socket$20;Ljava/lang/Runnable;Ljava/lang/Runnable;)V

    invoke-virtual {v4, v5, v6}, Lio/socket/engineio/client/Socket;->once(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 764
    .end local v0    # "cleanupAndClose":[Lio/socket/emitter/Emitter$Listener;
    .end local v1    # "close":Ljava/lang/Runnable;
    .end local v2    # "self":Lio/socket/engineio/client/Socket;
    .end local v3    # "waitForUpgrade":Ljava/lang/Runnable;
    :cond_1
    :goto_0
    return-void

    .line 758
    .restart local v0    # "cleanupAndClose":[Lio/socket/emitter/Emitter$Listener;
    .restart local v1    # "close":Ljava/lang/Runnable;
    .restart local v2    # "self":Lio/socket/engineio/client/Socket;
    .restart local v3    # "waitForUpgrade":Ljava/lang/Runnable;
    :cond_2
    iget-object v4, p0, Lio/socket/engineio/client/Socket$20;->this$0:Lio/socket/engineio/client/Socket;

    # getter for: Lio/socket/engineio/client/Socket;->upgrading:Z
    invoke-static {v4}, Lio/socket/engineio/client/Socket;->access$1300(Lio/socket/engineio/client/Socket;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 759
    invoke-interface {v3}, Ljava/lang/Runnable;->run()V

    goto :goto_0

    .line 761
    :cond_3
    invoke-interface {v1}, Ljava/lang/Runnable;->run()V

    goto :goto_0
.end method
