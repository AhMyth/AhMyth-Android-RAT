.class Lio/socket/client/Manager$8;
.super Ljava/lang/Object;
.source "Manager.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Manager;->socket(Ljava/lang/String;)Lio/socket/client/Socket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Manager;

.field final synthetic val$s:Lio/socket/client/Socket;

.field final synthetic val$self:Lio/socket/client/Manager;


# direct methods
.method constructor <init>(Lio/socket/client/Manager;Lio/socket/client/Manager;Lio/socket/client/Socket;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Manager;

    .prologue
    .line 431
    iput-object p1, p0, Lio/socket/client/Manager$8;->this$0:Lio/socket/client/Manager;

    iput-object p2, p0, Lio/socket/client/Manager$8;->val$self:Lio/socket/client/Manager;

    iput-object p3, p0, Lio/socket/client/Manager$8;->val$s:Lio/socket/client/Socket;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 2
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 434
    iget-object v0, p0, Lio/socket/client/Manager$8;->val$self:Lio/socket/client/Manager;

    # getter for: Lio/socket/client/Manager;->connecting:Ljava/util/Set;
    invoke-static {v0}, Lio/socket/client/Manager;->access$1700(Lio/socket/client/Manager;)Ljava/util/Set;

    move-result-object v0

    iget-object v1, p0, Lio/socket/client/Manager$8;->val$s:Lio/socket/client/Socket;

    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 435
    return-void
.end method
