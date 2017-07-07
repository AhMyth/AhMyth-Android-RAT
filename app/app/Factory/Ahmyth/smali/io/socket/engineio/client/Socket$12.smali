.class Lio/socket/engineio/client/Socket$12;
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

.field final synthetic val$freezeTransport:Lio/socket/emitter/Emitter$Listener;

.field final synthetic val$transport:[Lio/socket/engineio/client/Transport;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket;[Lio/socket/engineio/client/Transport;Lio/socket/emitter/Emitter$Listener;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/Socket;

    .prologue
    .line 443
    iput-object p1, p0, Lio/socket/engineio/client/Socket$12;->this$0:Lio/socket/engineio/client/Socket;

    iput-object p2, p0, Lio/socket/engineio/client/Socket$12;->val$transport:[Lio/socket/engineio/client/Transport;

    iput-object p3, p0, Lio/socket/engineio/client/Socket$12;->val$freezeTransport:Lio/socket/emitter/Emitter$Listener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 7
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    const/4 v6, 0x0

    .line 446
    aget-object v0, p1, v6

    check-cast v0, Lio/socket/engineio/client/Transport;

    .line 447
    .local v0, "to":Lio/socket/engineio/client/Transport;
    iget-object v1, p0, Lio/socket/engineio/client/Socket$12;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v1, v1, v6

    if-eqz v1, :cond_0

    iget-object v1, v0, Lio/socket/engineio/client/Transport;->name:Ljava/lang/String;

    iget-object v2, p0, Lio/socket/engineio/client/Socket$12;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v2, v2, v6

    iget-object v2, v2, Lio/socket/engineio/client/Transport;->name:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 448
    # getter for: Lio/socket/engineio/client/Socket;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/engineio/client/Socket;->access$1200()Ljava/util/logging/Logger;

    move-result-object v1

    const-string v2, "\'%s\' works - aborting \'%s\'"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    iget-object v4, v0, Lio/socket/engineio/client/Transport;->name:Ljava/lang/String;

    aput-object v4, v3, v6

    const/4 v4, 0x1

    iget-object v5, p0, Lio/socket/engineio/client/Socket$12;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v5, v5, v6

    iget-object v5, v5, Lio/socket/engineio/client/Transport;->name:Ljava/lang/String;

    aput-object v5, v3, v4

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 449
    iget-object v1, p0, Lio/socket/engineio/client/Socket$12;->val$freezeTransport:Lio/socket/emitter/Emitter$Listener;

    new-array v2, v6, [Ljava/lang/Object;

    invoke-interface {v1, v2}, Lio/socket/emitter/Emitter$Listener;->call([Ljava/lang/Object;)V

    .line 451
    :cond_0
    return-void
.end method
