.class Lio/socket/engineio/client/Socket$8;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Socket;->probe(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/Socket;

.field final synthetic val$cleanup:[Ljava/lang/Runnable;

.field final synthetic val$failed:[Z

.field final synthetic val$transport:[Lio/socket/engineio/client/Transport;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket;[Z[Ljava/lang/Runnable;[Lio/socket/engineio/client/Transport;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/Socket;

    .prologue
    .line 390
    iput-object p1, p0, Lio/socket/engineio/client/Socket$8;->this$0:Lio/socket/engineio/client/Socket;

    iput-object p2, p0, Lio/socket/engineio/client/Socket$8;->val$failed:[Z

    iput-object p3, p0, Lio/socket/engineio/client/Socket$8;->val$cleanup:[Ljava/lang/Runnable;

    iput-object p4, p0, Lio/socket/engineio/client/Socket$8;->val$transport:[Lio/socket/engineio/client/Transport;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 3
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    const/4 v2, 0x0

    .line 393
    iget-object v0, p0, Lio/socket/engineio/client/Socket$8;->val$failed:[Z

    aget-boolean v0, v0, v2

    if-eqz v0, :cond_0

    .line 401
    :goto_0
    return-void

    .line 395
    :cond_0
    iget-object v0, p0, Lio/socket/engineio/client/Socket$8;->val$failed:[Z

    const/4 v1, 0x1

    aput-boolean v1, v0, v2

    .line 397
    iget-object v0, p0, Lio/socket/engineio/client/Socket$8;->val$cleanup:[Ljava/lang/Runnable;

    aget-object v0, v0, v2

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 399
    iget-object v0, p0, Lio/socket/engineio/client/Socket$8;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v0, v0, v2

    invoke-virtual {v0}, Lio/socket/engineio/client/Transport;->close()Lio/socket/engineio/client/Transport;

    .line 400
    iget-object v0, p0, Lio/socket/engineio/client/Socket$8;->val$transport:[Lio/socket/engineio/client/Transport;

    const/4 v1, 0x0

    aput-object v1, v0, v2

    goto :goto_0
.end method
