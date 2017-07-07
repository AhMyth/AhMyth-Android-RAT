.class Lio/socket/engineio/client/Socket$5;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket;->setTransport(Lio/socket/engineio/client/Transport;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/Socket;

.field final synthetic val$self:Lio/socket/engineio/client/Socket;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket;Lio/socket/engineio/client/Socket;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/Socket;

    .prologue
    .line 310
    iput-object p1, p0, Lio/socket/engineio/client/Socket$5;->this$0:Lio/socket/engineio/client/Socket;

    iput-object p2, p0, Lio/socket/engineio/client/Socket$5;->val$self:Lio/socket/engineio/client/Socket;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 2
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 313
    iget-object v1, p0, Lio/socket/engineio/client/Socket$5;->val$self:Lio/socket/engineio/client/Socket;

    array-length v0, p1

    if-lez v0, :cond_0

    const/4 v0, 0x0

    aget-object v0, p1, v0

    check-cast v0, Lio/socket/engineio/parser/Packet;

    :goto_0
    # invokes: Lio/socket/engineio/client/Socket;->onPacket(Lio/socket/engineio/parser/Packet;)V
    invoke-static {v1, v0}, Lio/socket/engineio/client/Socket;->access$1000(Lio/socket/engineio/client/Socket;Lio/socket/engineio/parser/Packet;)V

    .line 314
    return-void

    .line 313
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
