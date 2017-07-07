.class Lio/socket/client/Manager$6;
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
    .line 374
    iput-object p1, p0, Lio/socket/client/Manager$6;->this$0:Lio/socket/client/Manager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 2
    .param p1, "objects"    # [Ljava/lang/Object;

    .prologue
    .line 377
    iget-object v1, p0, Lio/socket/client/Manager$6;->this$0:Lio/socket/client/Manager;

    const/4 v0, 0x0

    aget-object v0, p1, v0

    check-cast v0, Ljava/lang/String;

    # invokes: Lio/socket/client/Manager;->onclose(Ljava/lang/String;)V
    invoke-static {v1, v0}, Lio/socket/client/Manager;->access$1500(Lio/socket/client/Manager;Ljava/lang/String;)V

    .line 378
    return-void
.end method
