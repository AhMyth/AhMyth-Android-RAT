.class Lio/socket/client/Manager$Engine;
.super Lio/socket/engineio/client/Socket;
.source "Manager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/client/Manager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "Engine"
.end annotation


# direct methods
.method constructor <init>(Ljava/net/URI;Lio/socket/engineio/client/Socket$Options;)V
    .locals 0
    .param p1, "uri"    # Ljava/net/URI;
    .param p2, "opts"    # Lio/socket/engineio/client/Socket$Options;

    .prologue
    .line 606
    invoke-direct {p0, p1, p2}, Lio/socket/engineio/client/Socket;-><init>(Ljava/net/URI;Lio/socket/engineio/client/Socket$Options;)V

    .line 607
    return-void
.end method
