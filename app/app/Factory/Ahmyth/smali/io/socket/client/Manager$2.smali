.class Lio/socket/client/Manager$2;
.super Ljava/lang/Object;
.source "Manager.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Manager;->onopen()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Manager;


# direct methods
.method constructor <init>(Lio/socket/client/Manager;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Manager;

    .prologue
    .line 345
    iput-object p1, p0, Lio/socket/client/Manager$2;->this$0:Lio/socket/client/Manager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 2
    .param p1, "objects"    # [Ljava/lang/Object;

    .prologue
    .line 348
    const/4 v1, 0x0

    aget-object v0, p1, v1

    .line 349
    .local v0, "data":Ljava/lang/Object;
    instance-of v1, v0, Ljava/lang/String;

    if-eqz v1, :cond_1

    .line 350
    iget-object v1, p0, Lio/socket/client/Manager$2;->this$0:Lio/socket/client/Manager;

    check-cast v0, Ljava/lang/String;

    .end local v0    # "data":Ljava/lang/Object;
    # invokes: Lio/socket/client/Manager;->ondata(Ljava/lang/String;)V
    invoke-static {v1, v0}, Lio/socket/client/Manager;->access$1000(Lio/socket/client/Manager;Ljava/lang/String;)V

    .line 354
    :cond_0
    :goto_0
    return-void

    .line 351
    .restart local v0    # "data":Ljava/lang/Object;
    :cond_1
    instance-of v1, v0, [B

    if-eqz v1, :cond_0

    .line 352
    iget-object v1, p0, Lio/socket/client/Manager$2;->this$0:Lio/socket/client/Manager;

    check-cast v0, [B

    .end local v0    # "data":Ljava/lang/Object;
    check-cast v0, [B

    # invokes: Lio/socket/client/Manager;->ondata([B)V
    invoke-static {v1, v0}, Lio/socket/client/Manager;->access$1100(Lio/socket/client/Manager;[B)V

    goto :goto_0
.end method
