.class Lio/socket/client/Socket$5;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/client/Socket;

.field final synthetic val$args:[Ljava/lang/Object;

.field final synthetic val$event:Ljava/lang/String;


# direct methods
.method constructor <init>(Lio/socket/client/Socket;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/client/Socket;

    .prologue
    .line 173
    iput-object p1, p0, Lio/socket/client/Socket$5;->this$0:Lio/socket/client/Socket;

    iput-object p2, p0, Lio/socket/client/Socket$5;->val$event:Ljava/lang/String;

    iput-object p3, p0, Lio/socket/client/Socket$5;->val$args:[Ljava/lang/Object;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 10

    .prologue
    .line 176
    sget-object v5, Lio/socket/client/Socket;->events:Ljava/util/Map;

    iget-object v6, p0, Lio/socket/client/Socket$5;->val$event:Ljava/lang/String;

    invoke-interface {v5, v6}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 177
    iget-object v5, p0, Lio/socket/client/Socket$5;->this$0:Lio/socket/client/Socket;

    iget-object v6, p0, Lio/socket/client/Socket$5;->val$event:Ljava/lang/String;

    iget-object v7, p0, Lio/socket/client/Socket$5;->val$args:[Ljava/lang/Object;

    # invokes: Lio/socket/emitter/Emitter;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;
    invoke-static {v5, v6, v7}, Lio/socket/client/Socket;->access$601(Lio/socket/client/Socket;Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 205
    :goto_0
    return-void

    .line 181
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    iget-object v5, p0, Lio/socket/client/Socket$5;->val$args:[Ljava/lang/Object;

    array-length v5, v5

    add-int/lit8 v5, v5, 0x1

    invoke-direct {v0, v5}, Ljava/util/ArrayList;-><init>(I)V

    .line 182
    .local v0, "_args":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    iget-object v5, p0, Lio/socket/client/Socket$5;->val$event:Ljava/lang/String;

    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 183
    iget-object v5, p0, Lio/socket/client/Socket$5;->val$args:[Ljava/lang/Object;

    invoke-static {v5}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v5

    invoke-interface {v0, v5}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 185
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    .line 186
    .local v2, "jsonArgs":Lorg/json/JSONArray;
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_1

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    .line 187
    .local v1, "arg":Ljava/lang/Object;
    invoke-virtual {v2, v1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_1

    .line 189
    .end local v1    # "arg":Ljava/lang/Object;
    :cond_1
    invoke-static {v2}, Lio/socket/hasbinary/HasBinary;->hasBinary(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    const/4 v4, 0x5

    .line 190
    .local v4, "parserType":I
    :goto_2
    new-instance v3, Lio/socket/parser/Packet;

    invoke-direct {v3, v4, v2}, Lio/socket/parser/Packet;-><init>(ILjava/lang/Object;)V

    .line 192
    .local v3, "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v5

    add-int/lit8 v5, v5, -0x1

    invoke-interface {v0, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    instance-of v5, v5, Lio/socket/client/Ack;

    if-eqz v5, :cond_2

    .line 193
    # getter for: Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/client/Socket;->access$800()Ljava/util/logging/Logger;

    move-result-object v5

    const-string v6, "emitting packet with ack id %d"

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    iget-object v9, p0, Lio/socket/client/Socket$5;->this$0:Lio/socket/client/Socket;

    # getter for: Lio/socket/client/Socket;->ids:I
    invoke-static {v9}, Lio/socket/client/Socket;->access$700(Lio/socket/client/Socket;)I

    move-result v9

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v7, v8

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 194
    iget-object v5, p0, Lio/socket/client/Socket$5;->this$0:Lio/socket/client/Socket;

    # getter for: Lio/socket/client/Socket;->acks:Ljava/util/Map;
    invoke-static {v5}, Lio/socket/client/Socket;->access$900(Lio/socket/client/Socket;)Ljava/util/Map;

    move-result-object v6

    iget-object v5, p0, Lio/socket/client/Socket$5;->this$0:Lio/socket/client/Socket;

    # getter for: Lio/socket/client/Socket;->ids:I
    invoke-static {v5}, Lio/socket/client/Socket;->access$700(Lio/socket/client/Socket;)I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v5

    add-int/lit8 v5, v5, -0x1

    invoke-interface {v0, v5}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lio/socket/client/Ack;

    invoke-interface {v6, v7, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 195
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v5

    add-int/lit8 v5, v5, -0x1

    # invokes: Lio/socket/client/Socket;->remove(Lorg/json/JSONArray;I)Lorg/json/JSONArray;
    invoke-static {v2, v5}, Lio/socket/client/Socket;->access$1000(Lorg/json/JSONArray;I)Lorg/json/JSONArray;

    move-result-object v2

    .line 196
    iput-object v2, v3, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    .line 197
    iget-object v5, p0, Lio/socket/client/Socket$5;->this$0:Lio/socket/client/Socket;

    # operator++ for: Lio/socket/client/Socket;->ids:I
    invoke-static {v5}, Lio/socket/client/Socket;->access$708(Lio/socket/client/Socket;)I

    move-result v5

    iput v5, v3, Lio/socket/parser/Packet;->id:I

    .line 200
    :cond_2
    iget-object v5, p0, Lio/socket/client/Socket$5;->this$0:Lio/socket/client/Socket;

    # getter for: Lio/socket/client/Socket;->connected:Z
    invoke-static {v5}, Lio/socket/client/Socket;->access$300(Lio/socket/client/Socket;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 201
    iget-object v5, p0, Lio/socket/client/Socket$5;->this$0:Lio/socket/client/Socket;

    # invokes: Lio/socket/client/Socket;->packet(Lio/socket/parser/Packet;)V
    invoke-static {v5, v3}, Lio/socket/client/Socket;->access$1100(Lio/socket/client/Socket;Lio/socket/parser/Packet;)V

    goto/16 :goto_0

    .line 189
    .end local v3    # "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    .end local v4    # "parserType":I
    :cond_3
    const/4 v4, 0x2

    goto :goto_2

    .line 203
    .restart local v3    # "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    .restart local v4    # "parserType":I
    :cond_4
    iget-object v5, p0, Lio/socket/client/Socket$5;->this$0:Lio/socket/client/Socket;

    # getter for: Lio/socket/client/Socket;->sendBuffer:Ljava/util/Queue;
    invoke-static {v5}, Lio/socket/client/Socket;->access$1200(Lio/socket/client/Socket;)Ljava/util/Queue;

    move-result-object v5

    invoke-interface {v5, v3}, Ljava/util/Queue;->add(Ljava/lang/Object;)Z

    goto/16 :goto_0
.end method
