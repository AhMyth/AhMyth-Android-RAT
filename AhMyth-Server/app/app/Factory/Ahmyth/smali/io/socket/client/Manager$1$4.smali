.class Lio/socket/client/Manager$1$4;
.super Ljava/util/TimerTask;
.source "Manager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Manager$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/client/Manager$1;

.field final synthetic val$openSub:Lio/socket/client/On$Handle;

.field final synthetic val$self:Lio/socket/client/Manager;

.field final synthetic val$socket:Lio/socket/engineio/client/Socket;

.field final synthetic val$timeout:J


# direct methods
.method constructor <init>(Lio/socket/client/Manager$1;JLio/socket/client/On$Handle;Lio/socket/engineio/client/Socket;Lio/socket/client/Manager;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/client/Manager$1;

    .prologue
    .line 303
    iput-object p1, p0, Lio/socket/client/Manager$1$4;->this$1:Lio/socket/client/Manager$1;

    iput-wide p2, p0, Lio/socket/client/Manager$1$4;->val$timeout:J

    iput-object p4, p0, Lio/socket/client/Manager$1$4;->val$openSub:Lio/socket/client/On$Handle;

    iput-object p5, p0, Lio/socket/client/Manager$1$4;->val$socket:Lio/socket/engineio/client/Socket;

    iput-object p6, p0, Lio/socket/client/Manager$1$4;->val$self:Lio/socket/client/Manager;

    invoke-direct {p0}, Ljava/util/TimerTask;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 306
    new-instance v0, Lio/socket/client/Manager$1$4$1;

    invoke-direct {v0, p0}, Lio/socket/client/Manager$1$4$1;-><init>(Lio/socket/client/Manager$1$4;)V

    invoke-static {v0}, Lio/socket/thread/EventThread;->exec(Ljava/lang/Runnable;)V

    .line 316
    return-void
.end method
