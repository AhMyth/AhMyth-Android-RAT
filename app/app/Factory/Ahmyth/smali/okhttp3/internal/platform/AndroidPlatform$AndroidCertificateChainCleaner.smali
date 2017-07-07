.class final Lokhttp3/internal/platform/AndroidPlatform$AndroidCertificateChainCleaner;
.super Lokhttp3/internal/tls/CertificateChainCleaner;
.source "AndroidPlatform.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lokhttp3/internal/platform/AndroidPlatform;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "AndroidCertificateChainCleaner"
.end annotation


# instance fields
.field private final checkServerTrusted:Ljava/lang/reflect/Method;

.field private final x509TrustManagerExtensions:Ljava/lang/Object;


# direct methods
.method constructor <init>(Ljava/lang/Object;Ljava/lang/reflect/Method;)V
    .locals 0
    .param p1, "x509TrustManagerExtensions"    # Ljava/lang/Object;
    .param p2, "checkServerTrusted"    # Ljava/lang/reflect/Method;

    .prologue
    .line 222
    invoke-direct {p0}, Lokhttp3/internal/tls/CertificateChainCleaner;-><init>()V

    .line 223
    iput-object p1, p0, Lokhttp3/internal/platform/AndroidPlatform$AndroidCertificateChainCleaner;->x509TrustManagerExtensions:Ljava/lang/Object;

    .line 224
    iput-object p2, p0, Lokhttp3/internal/platform/AndroidPlatform$AndroidCertificateChainCleaner;->checkServerTrusted:Ljava/lang/reflect/Method;

    .line 225
    return-void
.end method


# virtual methods
.method public clean(Ljava/util/List;Ljava/lang/String;)Ljava/util/List;
    .locals 8
    .param p2, "hostname"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Ljava/security/cert/Certificate;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/security/cert/Certificate;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/net/ssl/SSLPeerUnverifiedException;
        }
    .end annotation

    .prologue
    .line 231
    .local p1, "chain":Ljava/util/List;, "Ljava/util/List<Ljava/security/cert/Certificate;>;"
    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    new-array v3, v3, [Ljava/security/cert/X509Certificate;

    invoke-interface {p1, v3}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/security/cert/X509Certificate;

    .line 232
    .local v0, "certificates":[Ljava/security/cert/X509Certificate;
    iget-object v3, p0, Lokhttp3/internal/platform/AndroidPlatform$AndroidCertificateChainCleaner;->checkServerTrusted:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lokhttp3/internal/platform/AndroidPlatform$AndroidCertificateChainCleaner;->x509TrustManagerExtensions:Ljava/lang/Object;

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object v0, v5, v6

    const/4 v6, 0x1

    const-string v7, "RSA"

    aput-object v7, v5, v6

    const/4 v6, 0x2

    aput-object p2, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1

    return-object v3

    .line 234
    .end local v0    # "certificates":[Ljava/security/cert/X509Certificate;
    :catch_0
    move-exception v1

    .line 235
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    new-instance v2, Ljavax/net/ssl/SSLPeerUnverifiedException;

    invoke-virtual {v1}, Ljava/lang/reflect/InvocationTargetException;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljavax/net/ssl/SSLPeerUnverifiedException;-><init>(Ljava/lang/String;)V

    .line 236
    .local v2, "exception":Ljavax/net/ssl/SSLPeerUnverifiedException;
    invoke-virtual {v2, v1}, Ljavax/net/ssl/SSLPeerUnverifiedException;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    .line 237
    throw v2

    .line 238
    .end local v1    # "e":Ljava/lang/reflect/InvocationTargetException;
    .end local v2    # "exception":Ljavax/net/ssl/SSLPeerUnverifiedException;
    :catch_1
    move-exception v1

    .line 239
    .local v1, "e":Ljava/lang/IllegalAccessException;
    new-instance v3, Ljava/lang/AssertionError;

    invoke-direct {v3, v1}, Ljava/lang/AssertionError;-><init>(Ljava/lang/Object;)V

    throw v3
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 1
    .param p1, "other"    # Ljava/lang/Object;

    .prologue
    .line 244
    instance-of v0, p1, Lokhttp3/internal/platform/AndroidPlatform$AndroidCertificateChainCleaner;

    return v0
.end method

.method public hashCode()I
    .locals 1

    .prologue
    .line 248
    const/4 v0, 0x0

    return v0
.end method
