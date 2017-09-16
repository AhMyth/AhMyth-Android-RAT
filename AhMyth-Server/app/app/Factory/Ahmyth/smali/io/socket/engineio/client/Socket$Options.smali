.class public Lio/socket/engineio/client/Socket$Options;
.super Lio/socket/engineio/client/Transport$Options;
.source "Socket.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/engineio/client/Socket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Options"
.end annotation


# instance fields
.field public host:Ljava/lang/String;

.field public query:Ljava/lang/String;

.field public rememberUpgrade:Z

.field public transports:[Ljava/lang/String;

.field public upgrade:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 844
    invoke-direct {p0}, Lio/socket/engineio/client/Transport$Options;-><init>()V

    .line 854
    const/4 v0, 0x1

    iput-boolean v0, p0, Lio/socket/engineio/client/Socket$Options;->upgrade:Z

    return-void
.end method

.method static synthetic access$100(Ljava/net/URI;Lio/socket/engineio/client/Socket$Options;)Lio/socket/engineio/client/Socket$Options;
    .locals 1
    .param p0, "x0"    # Ljava/net/URI;
    .param p1, "x1"    # Lio/socket/engineio/client/Socket$Options;

    .prologue
    .line 844
    invoke-static {p0, p1}, Lio/socket/engineio/client/Socket$Options;->fromURI(Ljava/net/URI;Lio/socket/engineio/client/Socket$Options;)Lio/socket/engineio/client/Socket$Options;

    move-result-object v0

    return-object v0
.end method

.method private static fromURI(Ljava/net/URI;Lio/socket/engineio/client/Socket$Options;)Lio/socket/engineio/client/Socket$Options;
    .locals 3
    .param p0, "uri"    # Ljava/net/URI;
    .param p1, "opts"    # Lio/socket/engineio/client/Socket$Options;

    .prologue
    .line 862
    if-nez p1, :cond_0

    .line 863
    new-instance p1, Lio/socket/engineio/client/Socket$Options;

    .end local p1    # "opts":Lio/socket/engineio/client/Socket$Options;
    invoke-direct {p1}, Lio/socket/engineio/client/Socket$Options;-><init>()V

    .line 866
    .restart local p1    # "opts":Lio/socket/engineio/client/Socket$Options;
    :cond_0
    invoke-virtual {p0}, Ljava/net/URI;->getHost()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p1, Lio/socket/engineio/client/Socket$Options;->host:Ljava/lang/String;

    .line 867
    const-string v1, "https"

    invoke-virtual {p0}, Ljava/net/URI;->getScheme()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "wss"

    invoke-virtual {p0}, Ljava/net/URI;->getScheme()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    :cond_1
    const/4 v1, 0x1

    :goto_0
    iput-boolean v1, p1, Lio/socket/engineio/client/Socket$Options;->secure:Z

    .line 868
    invoke-virtual {p0}, Ljava/net/URI;->getPort()I

    move-result v1

    iput v1, p1, Lio/socket/engineio/client/Socket$Options;->port:I

    .line 870
    invoke-virtual {p0}, Ljava/net/URI;->getRawQuery()Ljava/lang/String;

    move-result-object v0

    .line 871
    .local v0, "query":Ljava/lang/String;
    if-eqz v0, :cond_2

    .line 872
    iput-object v0, p1, Lio/socket/engineio/client/Socket$Options;->query:Ljava/lang/String;

    .line 875
    :cond_2
    return-object p1

    .line 867
    .end local v0    # "query":Ljava/lang/String;
    :cond_3
    const/4 v1, 0x0

    goto :goto_0
.end method
