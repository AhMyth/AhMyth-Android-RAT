.class final Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;
.super Ljava/lang/Object;
.source "AndroidPlatform.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lokhttp3/internal/platform/AndroidPlatform;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "CloseGuard"
.end annotation


# instance fields
.field private final getMethod:Ljava/lang/reflect/Method;

.field private final openMethod:Ljava/lang/reflect/Method;

.field private final warnIfOpenMethod:Ljava/lang/reflect/Method;


# direct methods
.method constructor <init>(Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;)V
    .locals 0
    .param p1, "getMethod"    # Ljava/lang/reflect/Method;
    .param p2, "openMethod"    # Ljava/lang/reflect/Method;
    .param p3, "warnIfOpenMethod"    # Ljava/lang/reflect/Method;

    .prologue
    .line 262
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 263
    iput-object p1, p0, Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;->getMethod:Ljava/lang/reflect/Method;

    .line 264
    iput-object p2, p0, Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;->openMethod:Ljava/lang/reflect/Method;

    .line 265
    iput-object p3, p0, Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;->warnIfOpenMethod:Ljava/lang/reflect/Method;

    .line 266
    return-void
.end method

.method static get()Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;
    .locals 9

    .prologue
    .line 298
    :try_start_0
    const-string v5, "dalvik.system.CloseGuard"

    invoke-static {v5}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 299
    .local v0, "closeGuardClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v5, "get"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Class;

    invoke-virtual {v0, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 300
    .local v1, "getMethod":Ljava/lang/reflect/Method;
    const-string v5, "open"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Class;

    const/4 v7, 0x0

    const-class v8, Ljava/lang/String;

    aput-object v8, v6, v7

    invoke-virtual {v0, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 301
    .local v3, "openMethod":Ljava/lang/reflect/Method;
    const-string v5, "warnIfOpen"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Class;

    invoke-virtual {v0, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v4

    .line 307
    .local v4, "warnIfOpenMethod":Ljava/lang/reflect/Method;
    :goto_0
    new-instance v5, Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;

    invoke-direct {v5, v1, v3, v4}, Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;-><init>(Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;Ljava/lang/reflect/Method;)V

    return-object v5

    .line 302
    .end local v1    # "getMethod":Ljava/lang/reflect/Method;
    .end local v3    # "openMethod":Ljava/lang/reflect/Method;
    .end local v4    # "warnIfOpenMethod":Ljava/lang/reflect/Method;
    :catch_0
    move-exception v2

    .line 303
    .local v2, "ignored":Ljava/lang/Exception;
    const/4 v1, 0x0

    .line 304
    .restart local v1    # "getMethod":Ljava/lang/reflect/Method;
    const/4 v3, 0x0

    .line 305
    .restart local v3    # "openMethod":Ljava/lang/reflect/Method;
    const/4 v4, 0x0

    .restart local v4    # "warnIfOpenMethod":Ljava/lang/reflect/Method;
    goto :goto_0
.end method


# virtual methods
.method createAndOpen(Ljava/lang/String;)Ljava/lang/Object;
    .locals 5
    .param p1, "closer"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x0

    .line 269
    iget-object v2, p0, Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;->getMethod:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_0

    .line 271
    :try_start_0
    iget-object v2, p0, Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;->getMethod:Ljava/lang/reflect/Method;

    const/4 v3, 0x0

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 272
    .local v0, "closeGuardInstance":Ljava/lang/Object;
    iget-object v2, p0, Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;->openMethod:Ljava/lang/reflect/Method;

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    invoke-virtual {v2, v0, v3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 277
    .end local v0    # "closeGuardInstance":Ljava/lang/Object;
    :goto_0
    return-object v0

    .line 274
    :catch_0
    move-exception v2

    :cond_0
    move-object v0, v1

    .line 277
    goto :goto_0
.end method

.method warnIfOpen(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "closeGuardInstance"    # Ljava/lang/Object;

    .prologue
    .line 281
    const/4 v0, 0x0

    .line 282
    .local v0, "reported":Z
    if-eqz p1, :cond_0

    .line 284
    :try_start_0
    iget-object v1, p0, Lokhttp3/internal/platform/AndroidPlatform$CloseGuard;->warnIfOpenMethod:Ljava/lang/reflect/Method;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v1, p1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 285
    const/4 v0, 0x1

    .line 289
    :cond_0
    :goto_0
    return v0

    .line 286
    :catch_0
    move-exception v1

    goto :goto_0
.end method
