.class public Lio/socket/engineio/client/transports/PollingXHR$Request$Options;
.super Ljava/lang/Object;
.source "PollingXHR.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/engineio/client/transports/PollingXHR$Request;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Options"
.end annotation


# instance fields
.field public data:[B

.field public hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

.field public method:Ljava/lang/String;

.field public proxy:Ljava/net/Proxy;

.field public sslContext:Ljavax/net/ssl/SSLContext;

.field public uri:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 314
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
