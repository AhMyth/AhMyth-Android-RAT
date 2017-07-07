.class Lio/socket/engineio/client/Socket$19;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket;->sendPacket(Lio/socket/engineio/parser/Packet;Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/Socket;

.field final synthetic val$fn:Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket;Ljava/lang/Runnable;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/Socket;

    .prologue
    .line 695
    iput-object p1, p0, Lio/socket/engineio/client/Socket$19;->this$0:Lio/socket/engineio/client/Socket;

    iput-object p2, p0, Lio/socket/engineio/client/Socket$19;->val$fn:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 1
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 698
    iget-object v0, p0, Lio/socket/engineio/client/Socket$19;->val$fn:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 699
    return-void
.end method
