.class public Lio/socket/hasbinary/HasBinary;
.super Ljava/lang/Object;
.source "HasBinary.java"


# static fields
.field private static final logger:Ljava/util/logging/Logger;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 13
    const-class v0, Lio/socket/hasbinary/HasBinary;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lio/socket/hasbinary/HasBinary;->logger:Ljava/util/logging/Logger;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static _hasBinary(Ljava/lang/Object;)Z
    .locals 11
    .param p0, "obj"    # Ljava/lang/Object;

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 22
    if-nez p0, :cond_1

    .line 61
    :cond_0
    :goto_0
    return v7

    .line 24
    :cond_1
    instance-of v9, p0, [B

    if-eqz v9, :cond_2

    move v7, v8

    .line 25
    goto :goto_0

    .line 28
    :cond_2
    instance-of v9, p0, Lorg/json/JSONArray;

    if-eqz v9, :cond_5

    move-object v0, p0

    .line 29
    check-cast v0, Lorg/json/JSONArray;

    .line 30
    .local v0, "_obj":Lorg/json/JSONArray;
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v5

    .line 31
    .local v5, "length":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    if-ge v2, v5, :cond_0

    .line 34
    :try_start_0
    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->isNull(I)Z
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v9

    if-eqz v9, :cond_3

    const/4 v6, 0x0

    .line 39
    .local v6, "v":Ljava/lang/Object;
    :goto_2
    invoke-static {v6}, Lio/socket/hasbinary/HasBinary;->_hasBinary(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_4

    move v7, v8

    .line 40
    goto :goto_0

    .line 34
    .end local v6    # "v":Ljava/lang/Object;
    :cond_3
    :try_start_1
    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->get(I)Ljava/lang/Object;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v6

    goto :goto_2

    .line 35
    :catch_0
    move-exception v1

    .line 36
    .local v1, "e":Lorg/json/JSONException;
    sget-object v8, Lio/socket/hasbinary/HasBinary;->logger:Ljava/util/logging/Logger;

    sget-object v9, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v10, "An error occured while retrieving data from JSONArray"

    invoke-virtual {v8, v9, v10, v1}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0

    .line 31
    .end local v1    # "e":Lorg/json/JSONException;
    .restart local v6    # "v":Ljava/lang/Object;
    :cond_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 43
    .end local v0    # "_obj":Lorg/json/JSONArray;
    .end local v2    # "i":I
    .end local v5    # "length":I
    .end local v6    # "v":Ljava/lang/Object;
    :cond_5
    instance-of v9, p0, Lorg/json/JSONObject;

    if-eqz v9, :cond_0

    move-object v0, p0

    .line 44
    check-cast v0, Lorg/json/JSONObject;

    .line 45
    .local v0, "_obj":Lorg/json/JSONObject;
    invoke-virtual {v0}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v4

    .line 46
    .local v4, "keys":Ljava/util/Iterator;
    :cond_6
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_0

    .line 47
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 50
    .local v3, "key":Ljava/lang/String;
    :try_start_2
    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_1

    move-result-object v6

    .line 55
    .restart local v6    # "v":Ljava/lang/Object;
    invoke-static {v6}, Lio/socket/hasbinary/HasBinary;->_hasBinary(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_6

    move v7, v8

    .line 56
    goto :goto_0

    .line 51
    .end local v6    # "v":Ljava/lang/Object;
    :catch_1
    move-exception v1

    .line 52
    .restart local v1    # "e":Lorg/json/JSONException;
    sget-object v8, Lio/socket/hasbinary/HasBinary;->logger:Ljava/util/logging/Logger;

    sget-object v9, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v10, "An error occured while retrieving data from JSONObject"

    invoke-virtual {v8, v9, v10, v1}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_0
.end method

.method public static hasBinary(Ljava/lang/Object;)Z
    .locals 1
    .param p0, "data"    # Ljava/lang/Object;

    .prologue
    .line 18
    invoke-static {p0}, Lio/socket/hasbinary/HasBinary;->_hasBinary(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method
