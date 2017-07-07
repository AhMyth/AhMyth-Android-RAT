.class Lio/socket/client/Socket$7$1;
.super Ljava/lang/Object;
.source "Socket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Socket$7;->call([Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/client/Socket$7;

.field final synthetic val$args:[Ljava/lang/Object;


# direct methods
.method constructor <init>(Lio/socket/client/Socket$7;[Ljava/lang/Object;)V
    .locals 0
    .param p1, "this$1"    # Lio/socket/client/Socket$7;

    .prologue
    .line 352
    iput-object p1, p0, Lio/socket/client/Socket$7$1;->this$1:Lio/socket/client/Socket$7;

    iput-object p2, p0, Lio/socket/client/Socket$7$1;->val$args:[Ljava/lang/Object;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    .prologue
    const/4 v5, 0x0

    .line 355
    iget-object v4, p0, Lio/socket/client/Socket$7$1;->this$1:Lio/socket/client/Socket$7;

    iget-object v4, v4, Lio/socket/client/Socket$7;->val$sent:[Z

    aget-boolean v4, v4, v5

    if-eqz v4, :cond_0

    .line 369
    :goto_0
    return-void

    .line 356
    :cond_0
    iget-object v4, p0, Lio/socket/client/Socket$7$1;->this$1:Lio/socket/client/Socket$7;

    iget-object v4, v4, Lio/socket/client/Socket$7;->val$sent:[Z

    const/4 v6, 0x1

    aput-boolean v6, v4, v5

    .line 357
    # getter for: Lio/socket/client/Socket;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/client/Socket;->access$800()Ljava/util/logging/Logger;

    move-result-object v6

    const-string v7, "sending ack %s"

    iget-object v4, p0, Lio/socket/client/Socket$7$1;->val$args:[Ljava/lang/Object;

    array-length v4, v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lio/socket/client/Socket$7$1;->val$args:[Ljava/lang/Object;

    :goto_1
    invoke-static {v7, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v6, v4}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 359
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 360
    .local v1, "jsonArgs":Lorg/json/JSONArray;
    iget-object v6, p0, Lio/socket/client/Socket$7$1;->val$args:[Ljava/lang/Object;

    array-length v7, v6

    move v4, v5

    :goto_2
    if-ge v4, v7, :cond_2

    aget-object v0, v6, v4

    .line 361
    .local v0, "arg":Ljava/lang/Object;
    invoke-virtual {v1, v0}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 360
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 357
    .end local v0    # "arg":Ljava/lang/Object;
    .end local v1    # "jsonArgs":Lorg/json/JSONArray;
    :cond_1
    const/4 v4, 0x0

    goto :goto_1

    .line 364
    .restart local v1    # "jsonArgs":Lorg/json/JSONArray;
    :cond_2
    invoke-static {v1}, Lio/socket/hasbinary/HasBinary;->hasBinary(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    const/4 v3, 0x6

    .line 366
    .local v3, "type":I
    :goto_3
    new-instance v2, Lio/socket/parser/Packet;

    invoke-direct {v2, v3, v1}, Lio/socket/parser/Packet;-><init>(ILjava/lang/Object;)V

    .line 367
    .local v2, "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    iget-object v4, p0, Lio/socket/client/Socket$7$1;->this$1:Lio/socket/client/Socket$7;

    iget v4, v4, Lio/socket/client/Socket$7;->val$id:I

    iput v4, v2, Lio/socket/parser/Packet;->id:I

    .line 368
    iget-object v4, p0, Lio/socket/client/Socket$7$1;->this$1:Lio/socket/client/Socket$7;

    iget-object v4, v4, Lio/socket/client/Socket$7;->val$self:Lio/socket/client/Socket;

    # invokes: Lio/socket/client/Socket;->packet(Lio/socket/parser/Packet;)V
    invoke-static {v4, v2}, Lio/socket/client/Socket;->access$1100(Lio/socket/client/Socket;Lio/socket/parser/Packet;)V

    goto :goto_0

    .line 364
    .end local v2    # "packet":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Lorg/json/JSONArray;>;"
    .end local v3    # "type":I
    :cond_3
    const/4 v3, 0x3

    goto :goto_3
.end method
