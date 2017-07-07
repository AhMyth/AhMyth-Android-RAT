.class public final Lokhttp3/internal/connection/RouteException;
.super Ljava/lang/RuntimeException;
.source "RouteException.java"


# static fields
.field private static final addSuppressedExceptionMethod:Ljava/lang/reflect/Method;


# instance fields
.field private lastException:Ljava/io/IOException;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .prologue
    .line 32
    :try_start_0
    const-class v2, Ljava/lang/Throwable;

    const-string v3, "addSuppressed"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, Ljava/lang/Throwable;

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 36
    .local v1, "m":Ljava/lang/reflect/Method;
    :goto_0
    sput-object v1, Lokhttp3/internal/connection/RouteException;->addSuppressedExceptionMethod:Ljava/lang/reflect/Method;

    .line 37
    return-void

    .line 33
    .end local v1    # "m":Ljava/lang/reflect/Method;
    :catch_0
    move-exception v0

    .line 34
    .local v0, "e":Ljava/lang/Exception;
    const/4 v1, 0x0

    .restart local v1    # "m":Ljava/lang/reflect/Method;
    goto :goto_0
.end method

.method public constructor <init>(Ljava/io/IOException;)V
    .locals 0
    .param p1, "cause"    # Ljava/io/IOException;

    .prologue
    .line 42
    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    .line 43
    iput-object p1, p0, Lokhttp3/internal/connection/RouteException;->lastException:Ljava/io/IOException;

    .line 44
    return-void
.end method

.method private addSuppressedIfPossible(Ljava/io/IOException;Ljava/io/IOException;)V
    .locals 3
    .param p1, "e"    # Ljava/io/IOException;
    .param p2, "suppressed"    # Ljava/io/IOException;

    .prologue
    .line 56
    sget-object v0, Lokhttp3/internal/connection/RouteException;->addSuppressedExceptionMethod:Ljava/lang/reflect/Method;

    if-eqz v0, :cond_0

    .line 58
    :try_start_0
    sget-object v0, Lokhttp3/internal/connection/RouteException;->addSuppressedExceptionMethod:Ljava/lang/reflect/Method;

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p2, v1, v2

    invoke-virtual {v0, p1, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    .line 62
    :cond_0
    :goto_0
    return-void

    .line 59
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0
.end method


# virtual methods
.method public addConnectException(Ljava/io/IOException;)V
    .locals 1
    .param p1, "e"    # Ljava/io/IOException;

    .prologue
    .line 51
    iget-object v0, p0, Lokhttp3/internal/connection/RouteException;->lastException:Ljava/io/IOException;

    invoke-direct {p0, p1, v0}, Lokhttp3/internal/connection/RouteException;->addSuppressedIfPossible(Ljava/io/IOException;Ljava/io/IOException;)V

    .line 52
    iput-object p1, p0, Lokhttp3/internal/connection/RouteException;->lastException:Ljava/io/IOException;

    .line 53
    return-void
.end method

.method public getLastConnectException()Ljava/io/IOException;
    .locals 1

    .prologue
    .line 47
    iget-object v0, p0, Lokhttp3/internal/connection/RouteException;->lastException:Ljava/io/IOException;

    return-object v0
.end method
