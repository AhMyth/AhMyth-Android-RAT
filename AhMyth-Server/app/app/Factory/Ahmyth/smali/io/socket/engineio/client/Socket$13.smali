.class Lio/socket/engineio/client/Socket$13;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


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

.field final synthetic val$onTransportClose:Lio/socket/emitter/Emitter$Listener;

.field final synthetic val$onTransportOpen:Lio/socket/emitter/Emitter$Listener;

.field final synthetic val$onclose:Lio/socket/emitter/Emitter$Listener;

.field final synthetic val$onerror:Lio/socket/emitter/Emitter$Listener;

.field final synthetic val$onupgrade:Lio/socket/emitter/Emitter$Listener;

.field final synthetic val$self:Lio/socket/engineio/client/Socket;

.field final synthetic val$transport:[Lio/socket/engineio/client/Transport;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/Socket;[Lio/socket/engineio/client/Transport;Lio/socket/emitter/Emitter$Listener;Lio/socket/emitter/Emitter$Listener;Lio/socket/emitter/Emitter$Listener;Lio/socket/engineio/client/Socket;Lio/socket/emitter/Emitter$Listener;Lio/socket/emitter/Emitter$Listener;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/Socket;

    .prologue
    .line 454
    iput-object p1, p0, Lio/socket/engineio/client/Socket$13;->this$0:Lio/socket/engineio/client/Socket;

    iput-object p2, p0, Lio/socket/engineio/client/Socket$13;->val$transport:[Lio/socket/engineio/client/Transport;

    iput-object p3, p0, Lio/socket/engineio/client/Socket$13;->val$onTransportOpen:Lio/socket/emitter/Emitter$Listener;

    iput-object p4, p0, Lio/socket/engineio/client/Socket$13;->val$onerror:Lio/socket/emitter/Emitter$Listener;

    iput-object p5, p0, Lio/socket/engineio/client/Socket$13;->val$onTransportClose:Lio/socket/emitter/Emitter$Listener;

    iput-object p6, p0, Lio/socket/engineio/client/Socket$13;->val$self:Lio/socket/engineio/client/Socket;

    iput-object p7, p0, Lio/socket/engineio/client/Socket$13;->val$onclose:Lio/socket/emitter/Emitter$Listener;

    iput-object p8, p0, Lio/socket/engineio/client/Socket$13;->val$onupgrade:Lio/socket/emitter/Emitter$Listener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 457
    iget-object v0, p0, Lio/socket/engineio/client/Socket$13;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v0, v0, v3

    const-string v1, "open"

    iget-object v2, p0, Lio/socket/engineio/client/Socket$13;->val$onTransportOpen:Lio/socket/emitter/Emitter$Listener;

    invoke-virtual {v0, v1, v2}, Lio/socket/engineio/client/Transport;->off(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 458
    iget-object v0, p0, Lio/socket/engineio/client/Socket$13;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v0, v0, v3

    const-string v1, "error"

    iget-object v2, p0, Lio/socket/engineio/client/Socket$13;->val$onerror:Lio/socket/emitter/Emitter$Listener;

    invoke-virtual {v0, v1, v2}, Lio/socket/engineio/client/Transport;->off(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 459
    iget-object v0, p0, Lio/socket/engineio/client/Socket$13;->val$transport:[Lio/socket/engineio/client/Transport;

    aget-object v0, v0, v3

    const-string v1, "close"

    iget-object v2, p0, Lio/socket/engineio/client/Socket$13;->val$onTransportClose:Lio/socket/emitter/Emitter$Listener;

    invoke-virtual {v0, v1, v2}, Lio/socket/engineio/client/Transport;->off(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 460
    iget-object v0, p0, Lio/socket/engineio/client/Socket$13;->val$self:Lio/socket/engineio/client/Socket;

    const-string v1, "close"

    iget-object v2, p0, Lio/socket/engineio/client/Socket$13;->val$onclose:Lio/socket/emitter/Emitter$Listener;

    invoke-virtual {v0, v1, v2}, Lio/socket/engineio/client/Socket;->off(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 461
    iget-object v0, p0, Lio/socket/engineio/client/Socket$13;->val$self:Lio/socket/engineio/client/Socket;

    const-string v1, "upgrading"

    iget-object v2, p0, Lio/socket/engineio/client/Socket$13;->val$onupgrade:Lio/socket/emitter/Emitter$Listener;

    invoke-virtual {v0, v1, v2}, Lio/socket/engineio/client/Socket;->off(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 462
    return-void
.end method
