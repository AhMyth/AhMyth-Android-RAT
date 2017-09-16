.class Lio/socket/client/Socket$6$1;
.super Ljava/util/ArrayList;
.source "Socket.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/Socket$6;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/ArrayList",
        "<",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$1:Lio/socket/client/Socket$6;


# direct methods
.method constructor <init>(Lio/socket/client/Socket$6;)V
    .locals 1
    .param p1, "this$1"    # Lio/socket/client/Socket$6;

    .prologue
    .line 238
    iput-object p1, p0, Lio/socket/client/Socket$6$1;->this$1:Lio/socket/client/Socket$6;

    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    .line 239
    iget-object v0, p0, Lio/socket/client/Socket$6$1;->this$1:Lio/socket/client/Socket$6;

    iget-object v0, v0, Lio/socket/client/Socket$6;->val$event:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lio/socket/client/Socket$6$1;->add(Ljava/lang/Object;)Z

    .line 240
    iget-object v0, p0, Lio/socket/client/Socket$6$1;->this$1:Lio/socket/client/Socket$6;

    iget-object v0, v0, Lio/socket/client/Socket$6;->val$args:[Ljava/lang/Object;

    if-eqz v0, :cond_0

    .line 241
    iget-object v0, p0, Lio/socket/client/Socket$6$1;->this$1:Lio/socket/client/Socket$6;

    iget-object v0, v0, Lio/socket/client/Socket$6;->val$args:[Ljava/lang/Object;

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {p0, v0}, Lio/socket/client/Socket$6$1;->addAll(Ljava/util/Collection;)Z

    .line 243
    :cond_0
    return-void
.end method
