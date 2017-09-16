.class Lio/socket/engineio/client/Socket$14$1;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket$14;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/Socket$14;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket$14;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/Socket$14;

    .prologue
    .line 548
    iput-object p1, p0, Lio/socket/engineio/client/Socket$14$1;->this$1:Lio/socket/engineio/client/Socket$14;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 551
    iget-object v0, p0, Lio/socket/engineio/client/Socket$14$1;->this$1:Lio/socket/engineio/client/Socket$14;

    iget-object v0, v0, Lio/socket/engineio/client/Socket$14;->val$self:Lio/socket/engineio/client/Socket;

    # getter for: Lio/socket/engineio/client/Socket;->readyState:Lio/socket/engineio/client/Socket$ReadyState;
    invoke-static {v0}, Lio/socket/engineio/client/Socket;->access$500(Lio/socket/engineio/client/Socket;)Lio/socket/engineio/client/Socket$ReadyState;

    move-result-object v0

    sget-object v1, Lio/socket/engineio/client/Socket$ReadyState;->CLOSED:Lio/socket/engineio/client/Socket$ReadyState;

    if-ne v0, v1, :cond_0

    .line 553
    :goto_0
    return-void

    .line 552
    :cond_0
    iget-object v0, p0, Lio/socket/engineio/client/Socket$14$1;->this$1:Lio/socket/engineio/client/Socket$14;

    iget-object v0, v0, Lio/socket/engineio/client/Socket$14;->val$self:Lio/socket/engineio/client/Socket;

    const-string v1, "ping timeout"

    # invokes: Lio/socket/engineio/client/Socket;->onClose(Ljava/lang/String;)V
    invoke-static {v0, v1}, Lio/socket/engineio/client/Socket;->access$800(Lio/socket/engineio/client/Socket;Ljava/lang/String;)V

    goto :goto_0
.end method
