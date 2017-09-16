.class public Lio/socket/engineio/client/Transport$Options;
.super Ljava/lang/Object;
.source "Transport.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/engineio/client/Transport;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Options"
.end annotation


# instance fields
.field public hostname:Ljava/lang/String;

.field public hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

.field public path:Ljava/lang/String;

.field public policyPort:I

.field public port:I

.field public proxy:Ljava/net/Proxy;

.field public proxyLogin:Ljava/lang/String;

.field public proxyPassword:Ljava/lang/String;

.field public query:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public secure:Z

.field protected socket:Lio/socket/engineio/client/Socket;

.field public sslContext:Ljavax/net/ssl/SSLContext;

.field public timestampParam:Ljava/lang/String;

.field public timestampRequests:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, -0x1

    .line 149
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 156
    iput v0, p0, Lio/socket/engineio/client/Transport$Options;->port:I

    .line 157
    iput v0, p0, Lio/socket/engineio/client/Transport$Options;->policyPort:I

    return-void
.end method
