.class Lio/socket/engineio/client/Socket$17;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket;->send(Ljava/lang/String;Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/Socket;

.field final synthetic val$fn:Ljava/lang/Runnable;

.field final synthetic val$msg:Ljava/lang/String;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket;Ljava/lang/String;Ljava/lang/Runnable;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/Socket;

    .prologue
    .line 656
    iput-object p1, p0, Lio/socket/engineio/client/Socket$17;->this$0:Lio/socket/engineio/client/Socket;

    iput-object p2, p0, Lio/socket/engineio/client/Socket$17;->val$msg:Ljava/lang/String;

    iput-object p3, p0, Lio/socket/engineio/client/Socket$17;->val$fn:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 659
    iget-object v0, p0, Lio/socket/engineio/client/Socket$17;->this$0:Lio/socket/engineio/client/Socket;

    const-string v1, "message"

    iget-object v2, p0, Lio/socket/engineio/client/Socket$17;->val$msg:Ljava/lang/String;

    iget-object v3, p0, Lio/socket/engineio/client/Socket$17;->val$fn:Ljava/lang/Runnable;

    # invokes: Lio/socket/engineio/client/Socket;->sendPacket(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)V
    invoke-static {v0, v1, v2, v3}, Lio/socket/engineio/client/Socket;->access$1800(Lio/socket/engineio/client/Socket;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Runnable;)V

    .line 660
    return-void
.end method
