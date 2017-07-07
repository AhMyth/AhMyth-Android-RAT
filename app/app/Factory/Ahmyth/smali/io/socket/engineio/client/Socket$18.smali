.class Lio/socket/engineio/client/Socket$18;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket;->send([BLjava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/Socket;

.field final synthetic val$fn:Ljava/lang/Runnable;

.field final synthetic val$msg:[B


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket;[BLjava/lang/Runnable;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/Socket;

    .prologue
    .line 665
    iput-object p1, p0, Lio/socket/engineio/client/Socket$18;->this$0:Lio/socket/engineio/client/Socket;

    iput-object p2, p0, Lio/socket/engineio/client/Socket$18;->val$msg:[B

    iput-object p3, p0, Lio/socket/engineio/client/Socket$18;->val$fn:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 668
    iget-object v0, p0, Lio/socket/engineio/client/Socket$18;->this$0:Lio/socket/engineio/client/Socket;

    const-string v1, "message"

    iget-object v2, p0, Lio/socket/engineio/client/Socket$18;->val$msg:[B

    iget-object v3, p0, Lio/socket/engineio/client/Socket$18;->val$fn:Ljava/lang/Runnable;

    # invokes: Lio/socket/engineio/client/Socket;->sendPacket(Ljava/lang/String;[BLjava/lang/Runnable;)V
    invoke-static {v0, v1, v2, v3}, Lio/socket/engineio/client/Socket;->access$1900(Lio/socket/engineio/client/Socket;Ljava/lang/String;[BLjava/lang/Runnable;)V

    .line 669
    return-void
.end method
