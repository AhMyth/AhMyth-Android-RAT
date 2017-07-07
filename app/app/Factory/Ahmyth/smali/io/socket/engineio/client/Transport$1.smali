.class Lio/socket/engineio/client/Transport$1;
.super Ljava/lang/Object;
.source "Transport.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/Transport;->open()Lio/socket/engineio/client/Transport;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/Transport;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Transport;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/Transport;

    .prologue
    .line 77
    iput-object p1, p0, Lio/socket/engineio/client/Transport$1;->this$0:Lio/socket/engineio/client/Transport;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 80
    iget-object v0, p0, Lio/socket/engineio/client/Transport$1;->this$0:Lio/socket/engineio/client/Transport;

    iget-object v0, v0, Lio/socket/engineio/client/Transport;->readyState:Lio/socket/engineio/client/Transport$ReadyState;

    sget-object v1, Lio/socket/engineio/client/Transport$ReadyState;->CLOSED:Lio/socket/engineio/client/Transport$ReadyState;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lio/socket/engineio/client/Transport$1;->this$0:Lio/socket/engineio/client/Transport;

    iget-object v0, v0, Lio/socket/engineio/client/Transport;->readyState:Lio/socket/engineio/client/Transport$ReadyState;

    if-nez v0, :cond_1

    .line 81
    :cond_0
    iget-object v0, p0, Lio/socket/engineio/client/Transport$1;->this$0:Lio/socket/engineio/client/Transport;

    sget-object v1, Lio/socket/engineio/client/Transport$ReadyState;->OPENING:Lio/socket/engineio/client/Transport$ReadyState;

    iput-object v1, v0, Lio/socket/engineio/client/Transport;->readyState:Lio/socket/engineio/client/Transport$ReadyState;

    .line 82
    iget-object v0, p0, Lio/socket/engineio/client/Transport$1;->this$0:Lio/socket/engineio/client/Transport;

    invoke-virtual {v0}, Lio/socket/engineio/client/Transport;->doOpen()V

    .line 84
    :cond_1
    return-void
.end method
