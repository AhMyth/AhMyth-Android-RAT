.class Lio/socket/client/Socket$6;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;Lio/socket/client/Ack;)Lio/socket/emitter/Emitter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Socket;

.field final synthetic val$ack:Lio/socket/client/Ack;

.field final synthetic val$args:[Ljava/lang/Object;

.field final synthetic val$event:Ljava/lang/String;


# direct methods
.method constructor <init>(Lio/socket/client/Socket;Ljava/lang/String;[Ljava/lang/Object;Lio/socket/client/Ack;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Socket;

    .prologue
    .line 235
    iput-object p1, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    iput-object p2, p0, Lio/socket/client/Socket$6;->val$event:Ljava/lang/String;

    iput-object p3, p0, Lio/socket/client/Socket$6;->val$args:[Ljava/lang/Object;

    iput-object p4, p0, Lio/socket/client/Socket$6;->val$ack:Lio/socket/client/Ack;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 10

    .prologue
    .line 238
    new-instance v1, Lio/socket/client/Socket$6$1;

    invoke-direct {v1, p0}, Lio/socket/client/Socket$6$1;-><init>(Lio/socket/client/Socket$6;)V

    .line 245
    .local v1, "_args":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    .line 246
    .local v2, "jsonArgs":Lorg/json/JSONArray;
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    .line 247
    .local v0, "_arg":Ljava/lang/Object;
    invoke-virtual {v2, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_0

    .line 249
    .end local v0    # "_arg":Ljava/lang/Object;
    :cond_0
    invoke-static {v2}, Lio/socket/hasbinary/HasBinary;->hasBinary(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    const/4 v4, 0x5

    .line 250
    .local v4, "parserType":I
    :goto_1
    new-instance v3, Lio/socket/parser/Packet;

    invoke-direct {v3, v4, v2}, Lio/socket/parser/Packet;-><init>(ILjava/lang/Object;)V

    .line 252
    .local v3, "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    # getter for: Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/client/Socket;->access$800()Ljava/util/logging/Logger;

    move-result-object v5

    const-string v6, "emitting packet with ack id %d"

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    iget-object v9, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    # getter for: Lio/socket/client/Socket;->ids:I
    invoke-static {v9}, Lio/socket/client/Socket;->access$700(Lio/socket/client/Socket;)I

    move-result v9

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v7, v8

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 253
    iget-object v5, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    # getter for: Lio/socket/client/Socket;->acks:Ljava/util/Map;
    invoke-static {v5}, Lio/socket/client/Socket;->access$900(Lio/socket/client/Socket;)Ljava/util/Map;

    move-result-object v5

    iget-object v6, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    # getter for: Lio/socket/client/Socket;->ids:I
    invoke-static {v6}, Lio/socket/client/Socket;->access$700(Lio/socket/client/Socket;)I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    iget-object v7, p0, Lio/socket/client/Socket$6;->val$ack:Lio/socket/client/Ack;

    invoke-interface {v5, v6, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 254
    iget-object v5, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    # operator++ for: Lio/socket/client/Socket;->ids:I
    invoke-static {v5}, Lio/socket/client/Socket;->access$708(Lio/socket/client/Socket;)I

    move-result v5

    iput v5, v3, Lio/socket/parser/Packet;->id:I

    .line 256
    iget-object v5, p0, Lio/socket/client/Socket$6;->this$0:Lio/socket/client/Socket;

    # invokes: Lio/socket/client/Socket;->packet(Lio/socket/parser/Packet;)V
    invoke-static {v5, v3}, Lio/socket/client/Socket;->access$1100(Lio/socket/client/Socket;Lio/socket/parser/Packet;)V

    .line 257
    return-void

    .line 249
    .end local v3    # "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    .end local v4    # "parserType":I
    :cond_1
    const/4 v4, 0x2

    goto :goto_1
.end method
