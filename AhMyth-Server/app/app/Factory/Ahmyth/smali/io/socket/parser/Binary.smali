.class public Lio/socket/parser/Binary;
.super Ljava/lang/Object;
.source "Binary.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/socket/parser/Binary$DeconstructedPacket;
    }
.end annotation


# static fields
.field private static final KEY_NUM:Ljava/lang/String; = "num"

.field private static final KEY_PLACEHOLDER:Ljava/lang/String; = "_placeholder"

.field private static final logger:Ljava/util/logging/Logger;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 19
    const-class v0, Lio/socket/parser/Binary;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lio/socket/parser/Binary;->logger:Ljava/util/logging/Logger;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static _deconstructPacket(Ljava/lang/Object;Ljava/util/List;)Ljava/lang/Object;
    .locals 12
    .param p0, "data"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Ljava/util/List",
            "<[B>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .prologue
    .local p1, "buffers":Ljava/util/List;, "Ljava/util/List<[B>;"
    const/4 v8, 0x0

    .line 35
    if-nez p0, :cond_1

    move-object v6, v8

    .line 76
    .end local p0    # "data":Ljava/lang/Object;
    :cond_0
    :goto_0
    return-object v6

    .line 37
    .restart local p0    # "data":Ljava/lang/Object;
    :cond_1
    instance-of v9, p0, [B

    if-eqz v9, :cond_2

    .line 38
    new-instance v7, Lorg/json/JSONObject;

    invoke-direct {v7}, Lorg/json/JSONObject;-><init>()V

    .line 40
    .local v7, "placeholder":Lorg/json/JSONObject;
    :try_start_0
    const-string v9, "_placeholder"

    const/4 v10, 0x1

    invoke-virtual {v7, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    .line 41
    const-string v9, "num"

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v10

    invoke-virtual {v7, v9, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 46
    check-cast p0, [B

    .end local p0    # "data":Ljava/lang/Object;
    check-cast p0, [B

    invoke-interface {p1, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object v6, v7

    .line 47
    goto :goto_0

    .line 42
    .restart local p0    # "data":Ljava/lang/Object;
    :catch_0
    move-exception v1

    .line 43
    .local v1, "e":Lorg/json/JSONException;
    sget-object v9, Lio/socket/parser/Binary;->logger:Ljava/util/logging/Logger;

    sget-object v10, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v11, "An error occured while putting data to JSONObject"

    invoke-virtual {v9, v10, v11, v1}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    move-object v6, v8

    .line 44
    goto :goto_0

    .line 48
    .end local v1    # "e":Lorg/json/JSONException;
    .end local v7    # "placeholder":Lorg/json/JSONObject;
    :cond_2
    instance-of v9, p0, Lorg/json/JSONArray;

    if-eqz v9, :cond_3

    .line 49
    new-instance v6, Lorg/json/JSONArray;

    invoke-direct {v6}, Lorg/json/JSONArray;-><init>()V

    .local v6, "newData":Lorg/json/JSONArray;
    move-object v0, p0

    .line 50
    check-cast v0, Lorg/json/JSONArray;

    .line 51
    .local v0, "_data":Lorg/json/JSONArray;
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v5

    .line 52
    .local v5, "len":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    if-ge v2, v5, :cond_0

    .line 54
    :try_start_1
    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->get(I)Ljava/lang/Object;

    move-result-object v9

    invoke-static {v9, p1}, Lio/socket/parser/Binary;->_deconstructPacket(Ljava/lang/Object;Ljava/util/List;)Ljava/lang/Object;

    move-result-object v9

    invoke-virtual {v6, v2, v9}, Lorg/json/JSONArray;->put(ILjava/lang/Object;)Lorg/json/JSONArray;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    .line 52
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 55
    :catch_1
    move-exception v1

    .line 56
    .restart local v1    # "e":Lorg/json/JSONException;
    sget-object v9, Lio/socket/parser/Binary;->logger:Ljava/util/logging/Logger;

    sget-object v10, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v11, "An error occured while putting packet data to JSONObject"

    invoke-virtual {v9, v10, v11, v1}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    move-object v6, v8

    .line 57
    goto :goto_0

    .line 61
    .end local v0    # "_data":Lorg/json/JSONArray;
    .end local v1    # "e":Lorg/json/JSONException;
    .end local v2    # "i":I
    .end local v5    # "len":I
    .end local v6    # "newData":Lorg/json/JSONArray;
    :cond_3
    instance-of v9, p0, Lorg/json/JSONObject;

    if-eqz v9, :cond_4

    .line 62
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .local v6, "newData":Lorg/json/JSONObject;
    move-object v0, p0

    .line 63
    check-cast v0, Lorg/json/JSONObject;

    .line 64
    .local v0, "_data":Lorg/json/JSONObject;
    invoke-virtual {v0}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v3

    .line 65
    .local v3, "iterator":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_0

    .line 66
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 68
    .local v4, "key":Ljava/lang/String;
    :try_start_2
    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v9

    invoke-static {v9, p1}, Lio/socket/parser/Binary;->_deconstructPacket(Ljava/lang/Object;Ljava/util/List;)Ljava/lang/Object;

    move-result-object v9

    invoke-virtual {v6, v4, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_2

    .line 69
    :catch_2
    move-exception v1

    .line 70
    .restart local v1    # "e":Lorg/json/JSONException;
    sget-object v9, Lio/socket/parser/Binary;->logger:Ljava/util/logging/Logger;

    sget-object v10, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v11, "An error occured while putting data to JSONObject"

    invoke-virtual {v9, v10, v11, v1}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    move-object v6, v8

    .line 71
    goto/16 :goto_0

    .end local v0    # "_data":Lorg/json/JSONObject;
    .end local v1    # "e":Lorg/json/JSONException;
    .end local v3    # "iterator":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    .end local v4    # "key":Ljava/lang/String;
    .end local v6    # "newData":Lorg/json/JSONObject;
    :cond_4
    move-object v6, p0

    .line 76
    goto/16 :goto_0
.end method

.method private static _reconstructPacket(Ljava/lang/Object;[[B)Ljava/lang/Object;
    .locals 11
    .param p0, "data"    # Ljava/lang/Object;
    .param p1, "buffers"    # [[B

    .prologue
    const/4 v7, 0x0

    .line 87
    instance-of v8, p0, Lorg/json/JSONArray;

    if-eqz v8, :cond_2

    move-object v0, p0

    .line 88
    check-cast v0, Lorg/json/JSONArray;

    .line 89
    .local v0, "_data":Lorg/json/JSONArray;
    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v5

    .line 90
    .local v5, "len":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v5, :cond_1

    .line 92
    :try_start_0
    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->get(I)Ljava/lang/Object;

    move-result-object v8

    invoke-static {v8, p1}, Lio/socket/parser/Binary;->_reconstructPacket(Ljava/lang/Object;[[B)Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {v0, v2, v8}, Lorg/json/JSONArray;->put(ILjava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 90
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 93
    :catch_0
    move-exception v1

    .line 94
    .local v1, "e":Lorg/json/JSONException;
    sget-object v8, Lio/socket/parser/Binary;->logger:Ljava/util/logging/Logger;

    sget-object v9, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v10, "An error occured while putting packet data to JSONObject"

    invoke-virtual {v8, v9, v10, v1}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 117
    .end local v0    # "_data":Lorg/json/JSONArray;
    .end local v1    # "e":Lorg/json/JSONException;
    .end local v2    # "i":I
    .end local v5    # "len":I
    :cond_0
    :goto_1
    return-object v7

    .restart local v0    # "_data":Lorg/json/JSONArray;
    .restart local v2    # "i":I
    .restart local v5    # "len":I
    :cond_1
    move-object v7, v0

    .line 98
    goto :goto_1

    .line 99
    .end local v0    # "_data":Lorg/json/JSONArray;
    .end local v2    # "i":I
    .end local v5    # "len":I
    :cond_2
    instance-of v8, p0, Lorg/json/JSONObject;

    if-eqz v8, :cond_5

    move-object v0, p0

    .line 100
    check-cast v0, Lorg/json/JSONObject;

    .line 101
    .local v0, "_data":Lorg/json/JSONObject;
    const-string v8, "_placeholder"

    invoke-virtual {v0, v8}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_3

    .line 102
    const-string v8, "num"

    const/4 v9, -0x1

    invoke-virtual {v0, v8, v9}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v6

    .line 103
    .local v6, "num":I
    if-ltz v6, :cond_0

    array-length v8, p1

    if-ge v6, v8, :cond_0

    aget-object v7, p1, v6

    goto :goto_1

    .line 105
    .end local v6    # "num":I
    :cond_3
    invoke-virtual {v0}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v3

    .line 106
    .local v3, "iterator":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_4

    .line 107
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 109
    .local v4, "key":Ljava/lang/String;
    :try_start_1
    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v8

    invoke-static {v8, p1}, Lio/socket/parser/Binary;->_reconstructPacket(Ljava/lang/Object;[[B)Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {v0, v4, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    .line 110
    :catch_1
    move-exception v1

    .line 111
    .restart local v1    # "e":Lorg/json/JSONException;
    sget-object v8, Lio/socket/parser/Binary;->logger:Ljava/util/logging/Logger;

    sget-object v9, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v10, "An error occured while putting data to JSONObject"

    invoke-virtual {v8, v9, v10, v1}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_1

    .end local v1    # "e":Lorg/json/JSONException;
    .end local v4    # "key":Ljava/lang/String;
    :cond_4
    move-object v7, v0

    .line 115
    goto :goto_1

    .end local v0    # "_data":Lorg/json/JSONObject;
    .end local v3    # "iterator":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :cond_5
    move-object v7, p0

    .line 117
    goto :goto_1
.end method

.method public static deconstructPacket(Lio/socket/parser/Packet;)Lio/socket/parser/Binary$DeconstructedPacket;
    .locals 3
    .param p0, "packet"    # Lio/socket/parser/Packet;

    .prologue
    .line 23
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 25
    .local v0, "buffers":Ljava/util/List;, "Ljava/util/List<[B>;"
    iget-object v2, p0, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    invoke-static {v2, v0}, Lio/socket/parser/Binary;->_deconstructPacket(Ljava/lang/Object;Ljava/util/List;)Ljava/lang/Object;

    move-result-object v2

    iput-object v2, p0, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    .line 26
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    iput v2, p0, Lio/socket/parser/Packet;->attachments:I

    .line 28
    new-instance v1, Lio/socket/parser/Binary$DeconstructedPacket;

    invoke-direct {v1}, Lio/socket/parser/Binary$DeconstructedPacket;-><init>()V

    .line 29
    .local v1, "result":Lio/socket/parser/Binary$DeconstructedPacket;
    iput-object p0, v1, Lio/socket/parser/Binary$DeconstructedPacket;->packet:Lio/socket/parser/Packet;

    .line 30
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    new-array v2, v2, [[B

    invoke-interface {v0, v2}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [[B

    iput-object v2, v1, Lio/socket/parser/Binary$DeconstructedPacket;->buffers:[[B

    .line 31
    return-object v1
.end method

.method public static reconstructPacket(Lio/socket/parser/Packet;[[B)Lio/socket/parser/Packet;
    .locals 1
    .param p0, "packet"    # Lio/socket/parser/Packet;
    .param p1, "buffers"    # [[B

    .prologue
    .line 81
    iget-object v0, p0, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    invoke-static {v0, p1}, Lio/socket/parser/Binary;->_reconstructPacket(Ljava/lang/Object;[[B)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    .line 82
    const/4 v0, -0x1

    iput v0, p0, Lio/socket/parser/Packet;->attachments:I

    .line 83
    return-object p0
.end method
