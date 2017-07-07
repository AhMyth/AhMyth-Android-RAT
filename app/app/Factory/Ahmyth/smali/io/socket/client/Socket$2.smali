.class Lio/socket/client/Socket$2;
.super Ljava/util/LinkedList;
.source "Socket.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Socket;->subEvents()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/LinkedList",
        "<",
        "Lio/socket/client/On$Handle;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Socket;

.field final synthetic val$io:Lio/socket/client/Manager;


# direct methods
.method constructor <init>(Lio/socket/client/Socket;Lio/socket/client/Manager;)V
    .locals 3
    .param p1, "this$0"    # Lio/socket/client/Socket;

    .prologue
    .line 101
    iput-object p1, p0, Lio/socket/client/Socket$2;->this$0:Lio/socket/client/Socket;

    iput-object p2, p0, Lio/socket/client/Socket$2;->val$io:Lio/socket/client/Manager;

    invoke-direct {p0}, Ljava/util/LinkedList;-><init>()V

    .line 102
    iget-object v0, p0, Lio/socket/client/Socket$2;->val$io:Lio/socket/client/Manager;

    const-string v1, "open"

    new-instance v2, Lio/socket/client/Socket$2$1;

    invoke-direct {v2, p0}, Lio/socket/client/Socket$2$1;-><init>(Lio/socket/client/Socket$2;)V

    invoke-static {v0, v1, v2}, Lio/socket/client/On;->on(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/On$Handle;

    move-result-object v0

    invoke-virtual {p0, v0}, Lio/socket/client/Socket$2;->add(Ljava/lang/Object;)Z

    .line 108
    iget-object v0, p0, Lio/socket/client/Socket$2;->val$io:Lio/socket/client/Manager;

    const-string v1, "packet"

    new-instance v2, Lio/socket/client/Socket$2$2;

    invoke-direct {v2, p0}, Lio/socket/client/Socket$2$2;-><init>(Lio/socket/client/Socket$2;)V

    invoke-static {v0, v1, v2}, Lio/socket/client/On;->on(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/On$Handle;

    move-result-object v0

    invoke-virtual {p0, v0}, Lio/socket/client/Socket$2;->add(Ljava/lang/Object;)Z

    .line 114
    iget-object v0, p0, Lio/socket/client/Socket$2;->val$io:Lio/socket/client/Manager;

    const-string v1, "close"

    new-instance v2, Lio/socket/client/Socket$2$3;

    invoke-direct {v2, p0}, Lio/socket/client/Socket$2$3;-><init>(Lio/socket/client/Socket$2;)V

    invoke-static {v0, v1, v2}, Lio/socket/client/On;->on(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/On$Handle;

    move-result-object v0

    invoke-virtual {p0, v0}, Lio/socket/client/Socket$2;->add(Ljava/lang/Object;)Z

    .line 120
    return-void
.end method
