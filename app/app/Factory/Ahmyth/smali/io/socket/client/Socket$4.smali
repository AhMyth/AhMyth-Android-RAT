.class Lio/socket/client/Socket$4;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Socket;->send([Ljava/lang/Object;)Lio/socket/client/Socket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Socket;

.field final synthetic val$args:[Ljava/lang/Object;


# direct methods
.method constructor <init>(Lio/socket/client/Socket;[Ljava/lang/Object;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Socket;

    .prologue
    .line 155
    iput-object p1, p0, Lio/socket/client/Socket$4;->this$0:Lio/socket/client/Socket;

    iput-object p2, p0, Lio/socket/client/Socket$4;->val$args:[Ljava/lang/Object;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 158
    iget-object v0, p0, Lio/socket/client/Socket$4;->this$0:Lio/socket/client/Socket;

    const-string v1, "message"

    iget-object v2, p0, Lio/socket/client/Socket$4;->val$args:[Ljava/lang/Object;

    invoke-virtual {v0, v1, v2}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 159
    return-void
.end method
