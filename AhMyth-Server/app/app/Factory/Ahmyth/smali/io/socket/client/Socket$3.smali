.class Lio/socket/client/Socket$3;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Socket;->open()Lio/socket/client/Socket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Socket;


# direct methods
.method constructor <init>(Lio/socket/client/Socket;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Socket;

    .prologue
    .line 127
    iput-object p1, p0, Lio/socket/client/Socket$3;->this$0:Lio/socket/client/Socket;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 130
    iget-object v0, p0, Lio/socket/client/Socket$3;->this$0:Lio/socket/client/Socket;

    # getter for: Lio/socket/client/Socket;->connected:Z
    invoke-static {v0}, Lio/socket/client/Socket;->access$300(Lio/socket/client/Socket;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 136
    :goto_0
    return-void

    .line 132
    :cond_0
    iget-object v0, p0, Lio/socket/client/Socket$3;->this$0:Lio/socket/client/Socket;

    # invokes: Lio/socket/client/Socket;->subEvents()V
    invoke-static {v0}, Lio/socket/client/Socket;->access$400(Lio/socket/client/Socket;)V

    .line 133
    iget-object v0, p0, Lio/socket/client/Socket$3;->this$0:Lio/socket/client/Socket;

    # getter for: Lio/socket/client/Socket;->io:Lio/socket/client/Manager;
    invoke-static {v0}, Lio/socket/client/Socket;->access$500(Lio/socket/client/Socket;)Lio/socket/client/Manager;

    move-result-object v0

    invoke-virtual {v0}, Lio/socket/client/Manager;->open()Lio/socket/client/Manager;

    .line 134
    sget-object v0, Lio/socket/client/Manager$ReadyState;->OPEN:Lio/socket/client/Manager$ReadyState;

    iget-object v1, p0, Lio/socket/client/Socket$3;->this$0:Lio/socket/client/Socket;

    # getter for: Lio/socket/client/Socket;->io:Lio/socket/client/Manager;
    invoke-static {v1}, Lio/socket/client/Socket;->access$500(Lio/socket/client/Socket;)Lio/socket/client/Manager;

    move-result-object v1

    iget-object v1, v1, Lio/socket/client/Manager;->readyState:Lio/socket/client/Manager$ReadyState;

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lio/socket/client/Socket$3;->this$0:Lio/socket/client/Socket;

    # invokes: Lio/socket/client/Socket;->onopen()V
    invoke-static {v0}, Lio/socket/client/Socket;->access$000(Lio/socket/client/Socket;)V

    .line 135
    :cond_1
    iget-object v0, p0, Lio/socket/client/Socket$3;->this$0:Lio/socket/client/Socket;

    const-string v1, "connecting"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    goto :goto_0
.end method
