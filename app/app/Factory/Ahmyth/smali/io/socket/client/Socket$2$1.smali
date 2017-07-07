.class Lio/socket/client/Socket$2$1;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/client/Socket$2;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/client/Socket$2;


# direct methods
.method constructor <init>(Lio/socket/client/Socket$2;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/client/Socket$2;

    .prologue
    .line 102
    iput-object p1, p0, Lio/socket/client/Socket$2$1;->this$1:Lio/socket/client/Socket$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 1
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 105
    iget-object v0, p0, Lio/socket/client/Socket$2$1;->this$1:Lio/socket/client/Socket$2;

    iget-object v0, v0, Lio/socket/client/Socket$2;->this$0:Lio/socket/client/Socket;

    # invokes: Lio/socket/client/Socket;->onopen()V
    invoke-static {v0}, Lio/socket/client/Socket;->access$000(Lio/socket/client/Socket;)V

    .line 106
    return-void
.end method
