.class Lio/socket/client/Socket$2$3;
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
    .line 114
    iput-object p1, p0, Lio/socket/client/Socket$2$3;->this$1:Lio/socket/client/Socket$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 2
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 117
    iget-object v0, p0, Lio/socket/client/Socket$2$3;->this$1:Lio/socket/client/Socket$2;

    iget-object v1, v0, Lio/socket/client/Socket$2;->this$0:Lio/socket/client/Socket;

    array-length v0, p1

    if-lez v0, :cond_0

    const/4 v0, 0x0

    aget-object v0, p1, v0

    check-cast v0, Ljava/lang/String;

    :goto_0
    # invokes: Lio/socket/client/Socket;->onclose(Ljava/lang/String;)V
    invoke-static {v1, v0}, Lio/socket/client/Socket;->access$200(Lio/socket/client/Socket;Ljava/lang/String;)V

    .line 118
    return-void

    .line 117
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method
