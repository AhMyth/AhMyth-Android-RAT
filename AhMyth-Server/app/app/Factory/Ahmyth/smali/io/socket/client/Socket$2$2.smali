.class Lio/socket/client/Socket$2$2;
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
    .line 108
    iput-object p1, p0, Lio/socket/client/Socket$2$2;->this$1:Lio/socket/client/Socket$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 2
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 111
    iget-object v0, p0, Lio/socket/client/Socket$2$2;->this$1:Lio/socket/client/Socket$2;

    iget-object v1, v0, Lio/socket/client/Socket$2;->this$0:Lio/socket/client/Socket;

    const/4 v0, 0x0

    aget-object v0, p1, v0

    check-cast v0, Lio/socket/parser/Packet;

    # invokes: Lio/socket/client/Socket;->onpacket(Lio/socket/parser/Packet;)V
    invoke-static {v1, v0}, Lio/socket/client/Socket;->access$100(Lio/socket/client/Socket;Lio/socket/parser/Packet;)V

    .line 112
    return-void
.end method
