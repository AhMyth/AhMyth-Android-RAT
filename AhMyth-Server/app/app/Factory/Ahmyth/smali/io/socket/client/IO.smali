.class public Lio/socket/client/IO;
.super Ljava/lang/Object;
.source "IO.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/socket/client/IO$Options;
    }
.end annotation


# static fields
.field private static final logger:Ljava/util/logging/Logger;

.field private static final managers:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap",
            "<",
            "Ljava/lang/String;",
            "Lio/socket/client/Manager;",
            ">;"
        }
    .end annotation
.end field

.field public static protocol:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 17
    const-class v0, Lio/socket/client/IO;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lio/socket/client/IO;->logger:Ljava/util/logging/Logger;

    .line 19
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lio/socket/client/IO;->managers:Ljava/util/concurrent/ConcurrentHashMap;

    .line 24
    sget v0, Lio/socket/parser/Parser;->protocol:I

    sput v0, Lio/socket/client/IO;->protocol:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static setDefaultHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V
    .locals 0
    .param p0, "hostnameVerifier"    # Ljavax/net/ssl/HostnameVerifier;

    .prologue
    .line 31
    sput-object p0, Lio/socket/client/Manager;->defaultHostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    .line 32
    return-void
.end method

.method public static setDefaultSSLContext(Ljavax/net/ssl/SSLContext;)V
    .locals 0
    .param p0, "sslContext"    # Ljavax/net/ssl/SSLContext;

    .prologue
    .line 27
    sput-object p0, Lio/socket/client/Manager;->defaultSSLContext:Ljavax/net/ssl/SSLContext;

    .line 28
    return-void
.end method

.method public static socket(Ljava/lang/String;)Lio/socket/client/Socket;
    .locals 1
    .param p0, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/net/URISyntaxException;
        }
    .end annotation

    .prologue
    .line 37
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lio/socket/client/IO;->socket(Ljava/lang/String;Lio/socket/client/IO$Options;)Lio/socket/client/Socket;

    move-result-object v0

    return-object v0
.end method

.method public static socket(Ljava/lang/String;Lio/socket/client/IO$Options;)Lio/socket/client/Socket;
    .locals 1
    .param p0, "uri"    # Ljava/lang/String;
    .param p1, "opts"    # Lio/socket/client/IO$Options;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/net/URISyntaxException;
        }
    .end annotation

    .prologue
    .line 41
    new-instance v0, Ljava/net/URI;

    invoke-direct {v0, p0}, Ljava/net/URI;-><init>(Ljava/lang/String;)V

    invoke-static {v0, p1}, Lio/socket/client/IO;->socket(Ljava/net/URI;Lio/socket/client/IO$Options;)Lio/socket/client/Socket;

    move-result-object v0

    return-object v0
.end method

.method public static socket(Ljava/net/URI;)Lio/socket/client/Socket;
    .locals 1
    .param p0, "uri"    # Ljava/net/URI;

    .prologue
    .line 45
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lio/socket/client/IO;->socket(Ljava/net/URI;Lio/socket/client/IO$Options;)Lio/socket/client/Socket;

    move-result-object v0

    return-object v0
.end method

.method public static socket(Ljava/net/URI;Lio/socket/client/IO$Options;)Lio/socket/client/Socket;
    .locals 12
    .param p0, "uri"    # Ljava/net/URI;
    .param p1, "opts"    # Lio/socket/client/IO$Options;

    .prologue
    const/4 v9, 0x1

    const/4 v10, 0x0

    .line 56
    if-nez p1, :cond_0

    .line 57
    new-instance p1, Lio/socket/client/IO$Options;

    .end local p1    # "opts":Lio/socket/client/IO$Options;
    invoke-direct {p1}, Lio/socket/client/IO$Options;-><init>()V

    .line 60
    .restart local p1    # "opts":Lio/socket/client/IO$Options;
    :cond_0
    invoke-static {p0}, Lio/socket/client/Url;->parse(Ljava/net/URI;)Ljava/net/URL;

    move-result-object v4

    .line 63
    .local v4, "parsed":Ljava/net/URL;
    :try_start_0
    invoke-virtual {v4}, Ljava/net/URL;->toURI()Ljava/net/URI;
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v7

    .line 67
    .local v7, "source":Ljava/net/URI;
    invoke-static {v4}, Lio/socket/client/Url;->extractId(Ljava/net/URL;)Ljava/lang/String;

    move-result-object v1

    .line 68
    .local v1, "id":Ljava/lang/String;
    invoke-virtual {v4}, Ljava/net/URL;->getPath()Ljava/lang/String;

    move-result-object v5

    .line 69
    .local v5, "path":Ljava/lang/String;
    sget-object v8, Lio/socket/client/IO;->managers:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v8, v1}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_2

    sget-object v8, Lio/socket/client/IO;->managers:Ljava/util/concurrent/ConcurrentHashMap;

    .line 70
    invoke-virtual {v8, v1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lio/socket/client/Manager;

    iget-object v8, v8, Lio/socket/client/Manager;->nsps:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v8, v5}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_2

    move v6, v9

    .line 71
    .local v6, "sameNamespace":Z
    :goto_0
    iget-boolean v8, p1, Lio/socket/client/IO$Options;->forceNew:Z

    if-nez v8, :cond_1

    iget-boolean v8, p1, Lio/socket/client/IO$Options;->multiplex:Z

    if-eqz v8, :cond_1

    if-eqz v6, :cond_3

    :cond_1
    move v3, v9

    .line 74
    .local v3, "newConnection":Z
    :goto_1
    if-eqz v3, :cond_4

    .line 75
    sget-object v8, Lio/socket/client/IO;->logger:Ljava/util/logging/Logger;

    const-string v11, "ignoring socket cache for %s"

    new-array v9, v9, [Ljava/lang/Object;

    aput-object v7, v9, v10

    invoke-static {v11, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 76
    new-instance v2, Lio/socket/client/Manager;

    invoke-direct {v2, v7, p1}, Lio/socket/client/Manager;-><init>(Ljava/net/URI;Lio/socket/client/Manager$Options;)V

    .line 85
    .local v2, "io":Lio/socket/client/Manager;
    :goto_2
    invoke-virtual {v4}, Ljava/net/URL;->getPath()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2, v8}, Lio/socket/client/Manager;->socket(Ljava/lang/String;)Lio/socket/client/Socket;

    move-result-object v8

    return-object v8

    .line 64
    .end local v1    # "id":Ljava/lang/String;
    .end local v2    # "io":Lio/socket/client/Manager;
    .end local v3    # "newConnection":Z
    .end local v5    # "path":Ljava/lang/String;
    .end local v6    # "sameNamespace":Z
    .end local v7    # "source":Ljava/net/URI;
    :catch_0
    move-exception v0

    .line 65
    .local v0, "e":Ljava/net/URISyntaxException;
    new-instance v8, Ljava/lang/RuntimeException;

    invoke-direct {v8, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v8

    .end local v0    # "e":Ljava/net/URISyntaxException;
    .restart local v1    # "id":Ljava/lang/String;
    .restart local v5    # "path":Ljava/lang/String;
    .restart local v7    # "source":Ljava/net/URI;
    :cond_2
    move v6, v10

    .line 70
    goto :goto_0

    .restart local v6    # "sameNamespace":Z
    :cond_3
    move v3, v10

    .line 71
    goto :goto_1

    .line 78
    .restart local v3    # "newConnection":Z
    :cond_4
    sget-object v8, Lio/socket/client/IO;->managers:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v8, v1}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_5

    .line 79
    sget-object v8, Lio/socket/client/IO;->logger:Ljava/util/logging/Logger;

    const-string v11, "new io instance for %s"

    new-array v9, v9, [Ljava/lang/Object;

    aput-object v7, v9, v10

    invoke-static {v11, v9}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 80
    sget-object v8, Lio/socket/client/IO;->managers:Ljava/util/concurrent/ConcurrentHashMap;

    new-instance v9, Lio/socket/client/Manager;

    invoke-direct {v9, v7, p1}, Lio/socket/client/Manager;-><init>(Ljava/net/URI;Lio/socket/client/Manager$Options;)V

    invoke-virtual {v8, v1, v9}, Ljava/util/concurrent/ConcurrentHashMap;->putIfAbsent(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 82
    :cond_5
    sget-object v8, Lio/socket/client/IO;->managers:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v8, v1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lio/socket/client/Manager;

    .restart local v2    # "io":Lio/socket/client/Manager;
    goto :goto_2
.end method
