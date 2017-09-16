.class public Lio/socket/engineio/client/transports/PollingXHR;
.super Lio/socket/engineio/client/transports/Polling;
.source "PollingXHR.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/socket/engineio/client/transports/PollingXHR$Request;
    }
.end annotation


# static fields
.field private static final logger:Ljava/util/logging/Logger;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 21
    const-class v0, Lio/socket/engineio/client/transports/PollingXHR;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lio/socket/engineio/client/transports/PollingXHR;->logger:Ljava/util/logging/Logger;

    return-void
.end method

.method public constructor <init>(Lio/socket/engineio/client/Transport$Options;)V
    .locals 0
    .param p1, "opts"    # Lio/socket/engineio/client/Transport$Options;

    .prologue
    .line 24
    invoke-direct {p0, p1}, Lio/socket/engineio/client/transports/Polling;-><init>(Lio/socket/engineio/client/Transport$Options;)V

    .line 25
    return-void
.end method

.method static synthetic access$000(Lio/socket/engineio/client/transports/PollingXHR;Ljava/lang/String;Ljava/lang/Exception;)Lio/socket/engineio/client/Transport;
    .locals 1
    .param p0, "x0"    # Lio/socket/engineio/client/transports/PollingXHR;
    .param p1, "x1"    # Ljava/lang/String;
    .param p2, "x2"    # Ljava/lang/Exception;

    .prologue
    .line 19
    invoke-virtual {p0, p1, p2}, Lio/socket/engineio/client/transports/PollingXHR;->onError(Ljava/lang/String;Ljava/lang/Exception;)Lio/socket/engineio/client/Transport;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$100(Lio/socket/engineio/client/transports/PollingXHR;Ljava/lang/String;Ljava/lang/Exception;)Lio/socket/engineio/client/Transport;
    .locals 1
    .param p0, "x0"    # Lio/socket/engineio/client/transports/PollingXHR;
    .param p1, "x1"    # Ljava/lang/String;
    .param p2, "x2"    # Ljava/lang/Exception;

    .prologue
    .line 19
    invoke-virtual {p0, p1, p2}, Lio/socket/engineio/client/transports/PollingXHR;->onError(Ljava/lang/String;Ljava/lang/Exception;)Lio/socket/engineio/client/Transport;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$200()Ljava/util/logging/Logger;
    .locals 1

    .prologue
    .line 19
    sget-object v0, Lio/socket/engineio/client/transports/PollingXHR;->logger:Ljava/util/logging/Logger;

    return-object v0
.end method


# virtual methods
.method protected doPoll()V
    .locals 4

    .prologue
    .line 98
    sget-object v2, Lio/socket/engineio/client/transports/PollingXHR;->logger:Ljava/util/logging/Logger;

    const-string v3, "xhr poll"

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 99
    invoke-virtual {p0}, Lio/socket/engineio/client/transports/PollingXHR;->request()Lio/socket/engineio/client/transports/PollingXHR$Request;

    move-result-object v0

    .line 100
    .local v0, "req":Lio/socket/engineio/client/transports/PollingXHR$Request;
    move-object v1, p0

    .line 101
    .local v1, "self":Lio/socket/engineio/client/transports/PollingXHR;
    const-string v2, "data"

    new-instance v3, Lio/socket/engineio/client/transports/PollingXHR$5;

    invoke-direct {v3, p0, v1}, Lio/socket/engineio/client/transports/PollingXHR$5;-><init>(Lio/socket/engineio/client/transports/PollingXHR;Lio/socket/engineio/client/transports/PollingXHR;)V

    invoke-virtual {v0, v2, v3}, Lio/socket/engineio/client/transports/PollingXHR$Request;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 117
    const-string v2, "error"

    new-instance v3, Lio/socket/engineio/client/transports/PollingXHR$6;

    invoke-direct {v3, p0, v1}, Lio/socket/engineio/client/transports/PollingXHR$6;-><init>(Lio/socket/engineio/client/transports/PollingXHR;Lio/socket/engineio/client/transports/PollingXHR;)V

    invoke-virtual {v0, v2, v3}, Lio/socket/engineio/client/transports/PollingXHR$Request;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 129
    invoke-virtual {v0}, Lio/socket/engineio/client/transports/PollingXHR$Request;->create()V

    .line 130
    return-void
.end method

.method protected doWrite([BLjava/lang/Runnable;)V
    .locals 5
    .param p1, "data"    # [B
    .param p2, "fn"    # Ljava/lang/Runnable;

    .prologue
    .line 65
    new-instance v0, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;

    invoke-direct {v0}, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;-><init>()V

    .line 66
    .local v0, "opts":Lio/socket/engineio/client/transports/PollingXHR$Request$Options;
    const-string v3, "POST"

    iput-object v3, v0, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->method:Ljava/lang/String;

    .line 67
    iput-object p1, v0, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->data:[B

    .line 68
    invoke-virtual {p0, v0}, Lio/socket/engineio/client/transports/PollingXHR;->request(Lio/socket/engineio/client/transports/PollingXHR$Request$Options;)Lio/socket/engineio/client/transports/PollingXHR$Request;

    move-result-object v1

    .line 69
    .local v1, "req":Lio/socket/engineio/client/transports/PollingXHR$Request;
    move-object v2, p0

    .line 70
    .local v2, "self":Lio/socket/engineio/client/transports/PollingXHR;
    const-string v3, "success"

    new-instance v4, Lio/socket/engineio/client/transports/PollingXHR$3;

    invoke-direct {v4, p0, p2}, Lio/socket/engineio/client/transports/PollingXHR$3;-><init>(Lio/socket/engineio/client/transports/PollingXHR;Ljava/lang/Runnable;)V

    invoke-virtual {v1, v3, v4}, Lio/socket/engineio/client/transports/PollingXHR$Request;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 81
    const-string v3, "error"

    new-instance v4, Lio/socket/engineio/client/transports/PollingXHR$4;

    invoke-direct {v4, p0, v2}, Lio/socket/engineio/client/transports/PollingXHR$4;-><init>(Lio/socket/engineio/client/transports/PollingXHR;Lio/socket/engineio/client/transports/PollingXHR;)V

    invoke-virtual {v1, v3, v4}, Lio/socket/engineio/client/transports/PollingXHR$Request;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 93
    invoke-virtual {v1}, Lio/socket/engineio/client/transports/PollingXHR$Request;->create()V

    .line 94
    return-void
.end method

.method protected request()Lio/socket/engineio/client/transports/PollingXHR$Request;
    .locals 1

    .prologue
    .line 28
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lio/socket/engineio/client/transports/PollingXHR;->request(Lio/socket/engineio/client/transports/PollingXHR$Request$Options;)Lio/socket/engineio/client/transports/PollingXHR$Request;

    move-result-object v0

    return-object v0
.end method

.method protected request(Lio/socket/engineio/client/transports/PollingXHR$Request$Options;)Lio/socket/engineio/client/transports/PollingXHR$Request;
    .locals 5
    .param p1, "opts"    # Lio/socket/engineio/client/transports/PollingXHR$Request$Options;

    .prologue
    .line 32
    if-nez p1, :cond_0

    .line 33
    new-instance p1, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;

    .end local p1    # "opts":Lio/socket/engineio/client/transports/PollingXHR$Request$Options;
    invoke-direct {p1}, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;-><init>()V

    .line 35
    .restart local p1    # "opts":Lio/socket/engineio/client/transports/PollingXHR$Request$Options;
    :cond_0
    invoke-virtual {p0}, Lio/socket/engineio/client/transports/PollingXHR;->uri()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p1, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->uri:Ljava/lang/String;

    .line 36
    iget-object v2, p0, Lio/socket/engineio/client/transports/PollingXHR;->sslContext:Ljavax/net/ssl/SSLContext;

    iput-object v2, p1, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->sslContext:Ljavax/net/ssl/SSLContext;

    .line 37
    iget-object v2, p0, Lio/socket/engineio/client/transports/PollingXHR;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    iput-object v2, p1, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    .line 38
    iget-object v2, p0, Lio/socket/engineio/client/transports/PollingXHR;->proxy:Ljava/net/Proxy;

    iput-object v2, p1, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->proxy:Ljava/net/Proxy;

    .line 40
    new-instance v0, Lio/socket/engineio/client/transports/PollingXHR$Request;

    invoke-direct {v0, p1}, Lio/socket/engineio/client/transports/PollingXHR$Request;-><init>(Lio/socket/engineio/client/transports/PollingXHR$Request$Options;)V

    .line 42
    .local v0, "req":Lio/socket/engineio/client/transports/PollingXHR$Request;
    move-object v1, p0

    .line 43
    .local v1, "self":Lio/socket/engineio/client/transports/PollingXHR;
    const-string v2, "requestHeaders"

    new-instance v3, Lio/socket/engineio/client/transports/PollingXHR$2;

    invoke-direct {v3, p0, v1}, Lio/socket/engineio/client/transports/PollingXHR$2;-><init>(Lio/socket/engineio/client/transports/PollingXHR;Lio/socket/engineio/client/transports/PollingXHR;)V

    invoke-virtual {v0, v2, v3}, Lio/socket/engineio/client/transports/PollingXHR$Request;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    move-result-object v2

    const-string v3, "responseHeaders"

    new-instance v4, Lio/socket/engineio/client/transports/PollingXHR$1;

    invoke-direct {v4, p0, v1}, Lio/socket/engineio/client/transports/PollingXHR$1;-><init>(Lio/socket/engineio/client/transports/PollingXHR;Lio/socket/engineio/client/transports/PollingXHR;)V

    .line 49
    invoke-virtual {v2, v3, v4}, Lio/socket/emitter/Emitter;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 60
    return-object v0
.end method
