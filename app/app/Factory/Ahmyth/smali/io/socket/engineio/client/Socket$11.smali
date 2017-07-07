.class Lio/socket/engineio/client/Socket$11;
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

.field final synthetic val$onerror:Lio/socket/emitter/Emitter$Listener;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket;Lio/socket/emitter/Emitter$Listener;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/Socket;

    .prologue
    .line 435
    iput-object p1, p0, Lio/socket/engineio/client/Socket$11;->this$0:Lio/socket/engineio/client/Socket;

    iput-object p2, p0, Lio/socket/engineio/client/Socket$11;->val$onerror:Lio/socket/emitter/Emitter$Listener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 4
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 438
    iget-object v0, p0, Lio/socket/engineio/client/Socket$11;->val$onerror:Lio/socket/emitter/Emitter$Listener;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, "socket closed"

    aput-object v3, v1, v2

    invoke-interface {v0, v1}, Lio/socket/emitter/Emitter$Listener;->call([Ljava/lang/Object;)V

    .line 439
    return-void
.end method
