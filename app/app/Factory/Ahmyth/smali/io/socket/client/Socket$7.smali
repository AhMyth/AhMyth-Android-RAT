.class Lio/socket/client/Socket$7;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Lio/socket/client/Ack;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Socket;->ack(I)Lio/socket/client/Ack;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Socket;

.field final synthetic val$id:I

.field final synthetic val$self:Lio/socket/client/Socket;

.field final synthetic val$sent:[Z


# direct methods
.method constructor <init>(Lio/socket/client/Socket;[ZILio/socket/client/Socket;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Socket;

    .prologue
    .line 349
    iput-object p1, p0, Lio/socket/client/Socket$7;->this$0:Lio/socket/client/Socket;

    iput-object p2, p0, Lio/socket/client/Socket$7;->val$sent:[Z

    iput p3, p0, Lio/socket/client/Socket$7;->val$id:I

    iput-object p4, p0, Lio/socket/client/Socket$7;->val$self:Lio/socket/client/Socket;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 1
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 352
    new-instance v0, Lio/socket/client/Socket$7$1;

    invoke-direct {v0, p0, p1}, Lio/socket/client/Socket$7$1;-><init>(Lio/socket/client/Socket$7;[Ljava/lang/Object;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 371
    return-void
.end method
