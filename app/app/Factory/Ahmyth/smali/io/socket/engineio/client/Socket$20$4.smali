.class Lio/socket/engineio/client/Socket$20$4;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket$20;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/engineio/client/Socket$20;

.field final synthetic val$close:Ljava/lang/Runnable;

.field final synthetic val$waitForUpgrade:Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket$20;Ljava/lang/Runnable;Ljava/lang/Runnable;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/engineio/client/Socket$20;

    .prologue
    .line 748
    iput-object p1, p0, Lio/socket/engineio/client/Socket$20$4;->this$1:Lio/socket/engineio/client/Socket$20;

    iput-object p2, p0, Lio/socket/engineio/client/Socket$20$4;->val$waitForUpgrade:Ljava/lang/Runnable;

    iput-object p3, p0, Lio/socket/engineio/client/Socket$20$4;->val$close:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 1
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 751
    iget-object v0, p0, Lio/socket/engineio/client/Socket$20$4;->this$1:Lio/socket/engineio/client/Socket$20;

    iget-object v0, v0, Lio/socket/engineio/client/Socket$20;->this$0:Lio/socket/engineio/client/Socket;

    # getter for: Lio/socket/engineio/client/Socket;->upgrading:Z
    invoke-static {v0}, Lio/socket/engineio/client/Socket;->access$1300(Lio/socket/engineio/client/Socket;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 752
    iget-object v0, p0, Lio/socket/engineio/client/Socket$20$4;->val$waitForUpgrade:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 756
    :goto_0
    return-void

    .line 754
    :cond_0
    iget-object v0, p0, Lio/socket/engineio/client/Socket$20$4;->val$close:Ljava/lang/Runnable;

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    goto :goto_0
.end method
