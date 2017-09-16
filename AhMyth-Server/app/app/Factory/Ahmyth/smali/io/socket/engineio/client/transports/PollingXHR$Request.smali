.class public Lio/socket/engineio/client/transports/PollingXHR$Request;
.super Lio/socket/emitter/Emitter;
.source "PollingXHR.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/engineio/client/transports/PollingXHR;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Request"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/socket/engineio/client/transports/PollingXHR$Request$Options;
    }
.end annotation


# static fields
.field public static final EVENT_DATA:Ljava/lang/String; = "data"

.field public static final EVENT_ERROR:Ljava/lang/String; = "error"

.field public static final EVENT_REQUEST_HEADERS:Ljava/lang/String; = "requestHeaders"

.field public static final EVENT_RESPONSE_HEADERS:Ljava/lang/String; = "responseHeaders"

.field public static final EVENT_SUCCESS:Ljava/lang/String; = "success"


# instance fields
.field private data:[B

.field private hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

.field private method:Ljava/lang/String;

.field private proxy:Ljava/net/Proxy;

.field private sslContext:Ljavax/net/ssl/SSLContext;

.field private uri:Ljava/lang/String;

.field private xhr:Ljava/net/HttpURLConnection;


# direct methods
.method public constructor <init>(Lio/socket/engineio/client/transports/PollingXHR$Request$Options;)V
    .locals 1
    .param p1, "opts"    # Lio/socket/engineio/client/transports/PollingXHR$Request$Options;

    .prologue
    .line 151
    invoke-direct {p0}, Lio/socket/emitter/Emitter;-><init>()V

    .line 152
    iget-object v0, p1, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->method:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->method:Ljava/lang/String;

    :goto_0
    iput-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->method:Ljava/lang/String;

    .line 153
    iget-object v0, p1, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->uri:Ljava/lang/String;

    iput-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->uri:Ljava/lang/String;

    .line 154
    iget-object v0, p1, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->data:[B

    iput-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->data:[B

    .line 155
    iget-object v0, p1, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->sslContext:Ljavax/net/ssl/SSLContext;

    iput-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->sslContext:Ljavax/net/ssl/SSLContext;

    .line 156
    iget-object v0, p1, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    iput-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    .line 157
    iget-object v0, p1, Lio/socket/engineio/client/transports/PollingXHR$Request$Options;->proxy:Ljava/net/Proxy;

    iput-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->proxy:Ljava/net/Proxy;

    .line 158
    return-void

    .line 152
    :cond_0
    const-string v0, "GET"

    goto :goto_0
.end method

.method static synthetic access$300(Lio/socket/engineio/client/transports/PollingXHR$Request;)[B
    .locals 1
    .param p0, "x0"    # Lio/socket/engineio/client/transports/PollingXHR$Request;

    .prologue
    .line 132
    iget-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->data:[B

    return-object v0
.end method

.method static synthetic access$400(Lio/socket/engineio/client/transports/PollingXHR$Request;)Ljava/net/HttpURLConnection;
    .locals 1
    .param p0, "x0"    # Lio/socket/engineio/client/transports/PollingXHR$Request;

    .prologue
    .line 132
    iget-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    return-object v0
.end method

.method static synthetic access$500(Lio/socket/engineio/client/transports/PollingXHR$Request;Ljava/util/Map;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/engineio/client/transports/PollingXHR$Request;
    .param p1, "x1"    # Ljava/util/Map;

    .prologue
    .line 132
    invoke-direct {p0, p1}, Lio/socket/engineio/client/transports/PollingXHR$Request;->onResponseHeaders(Ljava/util/Map;)V

    return-void
.end method

.method static synthetic access$600(Lio/socket/engineio/client/transports/PollingXHR$Request;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/engineio/client/transports/PollingXHR$Request;

    .prologue
    .line 132
    invoke-direct {p0}, Lio/socket/engineio/client/transports/PollingXHR$Request;->onLoad()V

    return-void
.end method

.method static synthetic access$700(Lio/socket/engineio/client/transports/PollingXHR$Request;Ljava/lang/Exception;)V
    .locals 0
    .param p0, "x0"    # Lio/socket/engineio/client/transports/PollingXHR$Request;
    .param p1, "x1"    # Ljava/lang/Exception;

    .prologue
    .line 132
    invoke-direct {p0, p1}, Lio/socket/engineio/client/transports/PollingXHR$Request;->onError(Ljava/lang/Exception;)V

    return-void
.end method

.method private cleanup()V
    .locals 1

    .prologue
    .line 262
    iget-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    if-nez v0, :cond_0

    .line 268
    :goto_0
    return-void

    .line 266
    :cond_0
    iget-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    invoke-virtual {v0}, Ljava/net/HttpURLConnection;->disconnect()V

    .line 267
    const/4 v0, 0x0

    iput-object v0, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    goto :goto_0
.end method

.method private onData(Ljava/lang/String;)V
    .locals 3
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    .line 240
    const-string v0, "data"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-virtual {p0, v0, v1}, Lio/socket/engineio/client/transports/PollingXHR$Request;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 241
    invoke-direct {p0}, Lio/socket/engineio/client/transports/PollingXHR$Request;->onSuccess()V

    .line 242
    return-void
.end method

.method private onData([B)V
    .locals 3
    .param p1, "data"    # [B

    .prologue
    .line 245
    const-string v0, "data"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-virtual {p0, v0, v1}, Lio/socket/engineio/client/transports/PollingXHR$Request;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 246
    invoke-direct {p0}, Lio/socket/engineio/client/transports/PollingXHR$Request;->onSuccess()V

    .line 247
    return-void
.end method

.method private onError(Ljava/lang/Exception;)V
    .locals 3
    .param p1, "err"    # Ljava/lang/Exception;

    .prologue
    .line 250
    const-string v0, "error"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-virtual {p0, v0, v1}, Lio/socket/engineio/client/transports/PollingXHR$Request;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 251
    return-void
.end method

.method private onLoad()V
    .locals 17

    .prologue
    .line 271
    const/4 v8, 0x0

    .line 272
    .local v8, "input":Ljava/io/InputStream;
    const/4 v12, 0x0

    .line 273
    .local v12, "reader":Ljava/io/BufferedReader;
    move-object/from16 v0, p0

    iget-object v15, v0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    invoke-virtual {v15}, Ljava/net/HttpURLConnection;->getContentType()Ljava/lang/String;

    move-result-object v5

    .line 275
    .local v5, "contentType":Ljava/lang/String;
    :try_start_0
    const-string v15, "application/octet-stream"

    invoke-virtual {v15, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v15

    if-eqz v15, :cond_6

    .line 276
    new-instance v9, Ljava/io/BufferedInputStream;

    move-object/from16 v0, p0

    iget-object v15, v0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    invoke-virtual {v15}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v15

    invoke-direct {v9, v15}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_8
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 277
    .end local v8    # "input":Ljava/io/InputStream;
    .local v9, "input":Ljava/io/InputStream;
    :try_start_1
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 278
    .local v3, "buffers":Ljava/util/List;, "Ljava/util/List<[B>;"
    const/4 v4, 0x0

    .line 279
    .local v4, "capacity":I
    const/4 v10, 0x0

    .line 280
    .local v10, "len":I
    const/16 v15, 0x400

    new-array v2, v15, [B

    .line 281
    .local v2, "buffer":[B
    :goto_0
    invoke-virtual {v9, v2}, Ljava/io/InputStream;->read([B)I

    move-result v10

    if-lez v10, :cond_0

    .line 282
    new-array v14, v10, [B

    .line 283
    .local v14, "tempBuffer":[B
    const/4 v15, 0x0

    const/16 v16, 0x0

    move/from16 v0, v16

    invoke-static {v2, v15, v14, v0, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 284
    invoke-interface {v3, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 285
    add-int/2addr v4, v10

    .line 286
    goto :goto_0

    .line 287
    .end local v14    # "tempBuffer":[B
    :cond_0
    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v6

    .line 288
    .local v6, "data":Ljava/nio/ByteBuffer;
    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v15

    :goto_1
    invoke-interface {v15}, Ljava/util/Iterator;->hasNext()Z

    move-result v16

    if-eqz v16, :cond_3

    invoke-interface {v15}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [B

    .line 289
    .local v1, "b":[B
    invoke-virtual {v6, v1}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    .line 301
    .end local v1    # "b":[B
    .end local v2    # "buffer":[B
    .end local v3    # "buffers":Ljava/util/List;, "Ljava/util/List<[B>;"
    .end local v4    # "capacity":I
    .end local v6    # "data":Ljava/nio/ByteBuffer;
    .end local v10    # "len":I
    :catch_0
    move-exception v7

    move-object v8, v9

    .line 302
    .end local v9    # "input":Ljava/io/InputStream;
    .local v7, "e":Ljava/io/IOException;
    .restart local v8    # "input":Ljava/io/InputStream;
    :goto_2
    :try_start_2
    move-object/from16 v0, p0

    invoke-direct {v0, v7}, Lio/socket/engineio/client/transports/PollingXHR$Request;->onError(Ljava/lang/Exception;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 305
    if-eqz v8, :cond_1

    :try_start_3
    invoke-virtual {v8}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_4

    .line 308
    :cond_1
    :goto_3
    if-eqz v12, :cond_2

    :try_start_4
    invoke-virtual {v12}, Ljava/io/BufferedReader;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_5

    .line 310
    :cond_2
    :goto_4
    invoke-direct/range {p0 .. p0}, Lio/socket/engineio/client/transports/PollingXHR$Request;->cleanup()V

    .line 312
    .end local v7    # "e":Ljava/io/IOException;
    :goto_5
    return-void

    .line 291
    .end local v8    # "input":Ljava/io/InputStream;
    .restart local v2    # "buffer":[B
    .restart local v3    # "buffers":Ljava/util/List;, "Ljava/util/List<[B>;"
    .restart local v4    # "capacity":I
    .restart local v6    # "data":Ljava/nio/ByteBuffer;
    .restart local v9    # "input":Ljava/io/InputStream;
    .restart local v10    # "len":I
    :cond_3
    :try_start_5
    invoke-virtual {v6}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v15

    move-object/from16 v0, p0

    invoke-direct {v0, v15}, Lio/socket/engineio/client/transports/PollingXHR$Request;->onData([B)V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    move-object v8, v9

    .line 305
    .end local v2    # "buffer":[B
    .end local v3    # "buffers":Ljava/util/List;, "Ljava/util/List<[B>;"
    .end local v4    # "capacity":I
    .end local v6    # "data":Ljava/nio/ByteBuffer;
    .end local v9    # "input":Ljava/io/InputStream;
    .end local v10    # "len":I
    .restart local v8    # "input":Ljava/io/InputStream;
    :goto_6
    if-eqz v8, :cond_4

    :try_start_6
    invoke-virtual {v8}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_2

    .line 308
    :cond_4
    :goto_7
    if-eqz v12, :cond_5

    :try_start_7
    invoke-virtual {v12}, Ljava/io/BufferedReader;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_3

    .line 310
    :cond_5
    :goto_8
    invoke-direct/range {p0 .. p0}, Lio/socket/engineio/client/transports/PollingXHR$Request;->cleanup()V

    goto :goto_5

    .line 294
    :cond_6
    :try_start_8
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    .line 295
    .local v6, "data":Ljava/lang/StringBuilder;
    new-instance v13, Ljava/io/BufferedReader;

    new-instance v15, Ljava/io/InputStreamReader;

    move-object/from16 v0, p0

    iget-object v0, v0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    move-object/from16 v16, v0

    invoke-virtual/range {v16 .. v16}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v16

    invoke-direct/range {v15 .. v16}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v13, v15}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 296
    .end local v12    # "reader":Ljava/io/BufferedReader;
    .local v13, "reader":Ljava/io/BufferedReader;
    :goto_9
    :try_start_9
    invoke-virtual {v13}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v11

    .local v11, "line":Ljava/lang/String;
    if-eqz v11, :cond_7

    .line 297
    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_9

    .line 301
    .end local v11    # "line":Ljava/lang/String;
    :catch_1
    move-exception v7

    move-object v12, v13

    .end local v13    # "reader":Ljava/io/BufferedReader;
    .restart local v12    # "reader":Ljava/io/BufferedReader;
    goto :goto_2

    .line 299
    .end local v12    # "reader":Ljava/io/BufferedReader;
    .restart local v11    # "line":Ljava/lang/String;
    .restart local v13    # "reader":Ljava/io/BufferedReader;
    :cond_7
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v15

    move-object/from16 v0, p0

    invoke-direct {v0, v15}, Lio/socket/engineio/client/transports/PollingXHR$Request;->onData(Ljava/lang/String;)V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_1
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    move-object v12, v13

    .end local v13    # "reader":Ljava/io/BufferedReader;
    .restart local v12    # "reader":Ljava/io/BufferedReader;
    goto :goto_6

    .line 304
    .end local v6    # "data":Ljava/lang/StringBuilder;
    .end local v11    # "line":Ljava/lang/String;
    :catchall_0
    move-exception v15

    .line 305
    :goto_a
    if-eqz v8, :cond_8

    :try_start_a
    invoke-virtual {v8}, Ljava/io/InputStream;->close()V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_6

    .line 308
    :cond_8
    :goto_b
    if-eqz v12, :cond_9

    :try_start_b
    invoke-virtual {v12}, Ljava/io/BufferedReader;->close()V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_7

    .line 310
    :cond_9
    :goto_c
    invoke-direct/range {p0 .. p0}, Lio/socket/engineio/client/transports/PollingXHR$Request;->cleanup()V

    throw v15

    .line 306
    :catch_2
    move-exception v15

    goto :goto_7

    .line 309
    :catch_3
    move-exception v15

    goto :goto_8

    .line 306
    .restart local v7    # "e":Ljava/io/IOException;
    :catch_4
    move-exception v15

    goto :goto_3

    .line 309
    :catch_5
    move-exception v15

    goto :goto_4

    .line 306
    .end local v7    # "e":Ljava/io/IOException;
    :catch_6
    move-exception v16

    goto :goto_b

    .line 309
    :catch_7
    move-exception v16

    goto :goto_c

    .line 304
    .end local v8    # "input":Ljava/io/InputStream;
    .restart local v9    # "input":Ljava/io/InputStream;
    :catchall_1
    move-exception v15

    move-object v8, v9

    .end local v9    # "input":Ljava/io/InputStream;
    .restart local v8    # "input":Ljava/io/InputStream;
    goto :goto_a

    .end local v12    # "reader":Ljava/io/BufferedReader;
    .restart local v6    # "data":Ljava/lang/StringBuilder;
    .restart local v13    # "reader":Ljava/io/BufferedReader;
    :catchall_2
    move-exception v15

    move-object v12, v13

    .end local v13    # "reader":Ljava/io/BufferedReader;
    .restart local v12    # "reader":Ljava/io/BufferedReader;
    goto :goto_a

    .line 301
    .end local v6    # "data":Ljava/lang/StringBuilder;
    :catch_8
    move-exception v7

    goto :goto_2
.end method

.method private onRequestHeaders(Ljava/util/Map;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;>;)V"
        }
    .end annotation

    .prologue
    .line 254
    .local p1, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    const-string v0, "requestHeaders"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-virtual {p0, v0, v1}, Lio/socket/engineio/client/transports/PollingXHR$Request;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 255
    return-void
.end method

.method private onResponseHeaders(Ljava/util/Map;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;>;)V"
        }
    .end annotation

    .prologue
    .line 258
    .local p1, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    const-string v0, "responseHeaders"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-virtual {p0, v0, v1}, Lio/socket/engineio/client/transports/PollingXHR$Request;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 259
    return-void
.end method

.method private onSuccess()V
    .locals 2

    .prologue
    .line 236
    const-string v0, "success"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lio/socket/engineio/client/transports/PollingXHR$Request;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 237
    return-void
.end method


# virtual methods
.method public create()V
    .locals 14

    .prologue
    const/4 v13, 0x2

    const/4 v12, 0x0

    const/4 v11, 0x1

    .line 161
    move-object v3, p0

    .line 163
    .local v3, "self":Lio/socket/engineio/client/transports/PollingXHR$Request;
    :try_start_0
    # getter for: Lio/socket/engineio/client/transports/PollingXHR;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/engineio/client/transports/PollingXHR;->access$200()Ljava/util/logging/Logger;

    move-result-object v6

    const-string v7, "xhr open %s: %s"

    const/4 v8, 0x2

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    iget-object v10, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->method:Ljava/lang/String;

    aput-object v10, v8, v9

    const/4 v9, 0x1

    iget-object v10, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->uri:Ljava/lang/String;

    aput-object v10, v8, v9

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 164
    new-instance v4, Ljava/net/URL;

    iget-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->uri:Ljava/lang/String;

    invoke-direct {v4, v6}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 165
    .local v4, "url":Ljava/net/URL;
    iget-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->proxy:Ljava/net/Proxy;

    if-eqz v6, :cond_4

    iget-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->proxy:Ljava/net/Proxy;

    invoke-virtual {v4, v6}, Ljava/net/URL;->openConnection(Ljava/net/Proxy;)Ljava/net/URLConnection;

    move-result-object v6

    check-cast v6, Ljava/net/HttpURLConnection;

    .line 166
    :goto_0
    iput-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    .line 167
    iget-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    iget-object v7, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->method:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 173
    iget-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    const/16 v7, 0x2710

    invoke-virtual {v6, v7}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 175
    iget-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    instance-of v6, v6, Ljavax/net/ssl/HttpsURLConnection;

    if-eqz v6, :cond_1

    .line 176
    iget-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->sslContext:Ljavax/net/ssl/SSLContext;

    if-eqz v6, :cond_0

    .line 177
    iget-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    check-cast v6, Ljavax/net/ssl/HttpsURLConnection;

    iget-object v7, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->sslContext:Ljavax/net/ssl/SSLContext;

    invoke-virtual {v7}, Ljavax/net/ssl/SSLContext;->getSocketFactory()Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljavax/net/ssl/HttpsURLConnection;->setSSLSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)V

    .line 179
    :cond_0
    iget-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    if-eqz v6, :cond_1

    .line 180
    iget-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    check-cast v6, Ljavax/net/ssl/HttpsURLConnection;

    iget-object v7, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->hostnameVerifier:Ljavax/net/ssl/HostnameVerifier;

    invoke-virtual {v6, v7}, Ljavax/net/ssl/HttpsURLConnection;->setHostnameVerifier(Ljavax/net/ssl/HostnameVerifier;)V

    .line 184
    :cond_1
    new-instance v2, Ljava/util/TreeMap;

    sget-object v6, Ljava/lang/String;->CASE_INSENSITIVE_ORDER:Ljava/util/Comparator;

    invoke-direct {v2, v6}, Ljava/util/TreeMap;-><init>(Ljava/util/Comparator;)V

    .line 186
    .local v2, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    const-string v6, "POST"

    iget-object v7, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->method:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 187
    iget-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    invoke-virtual {v6, v11}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    .line 188
    const-string v6, "Content-type"

    new-instance v7, Ljava/util/LinkedList;

    new-array v8, v11, [Ljava/lang/String;

    const-string v9, "application/octet-stream"

    aput-object v9, v8, v12

    invoke-static {v8}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/util/LinkedList;-><init>(Ljava/util/Collection;)V

    invoke-interface {v2, v6, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 191
    :cond_2
    invoke-direct {v3, v2}, Lio/socket/engineio/client/transports/PollingXHR$Request;->onRequestHeaders(Ljava/util/Map;)V

    .line 192
    invoke-interface {v2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v6

    invoke-interface {v6}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :cond_3
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_5

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 193
    .local v1, "header":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_1
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 194
    .local v5, "v":Ljava/lang/String;
    iget-object v9, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-virtual {v9, v6, v5}, Ljava/net/HttpURLConnection;->addRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 166
    .end local v1    # "header":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .end local v2    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .end local v5    # "v":Ljava/lang/String;
    :cond_4
    :try_start_1
    invoke-virtual {v4}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v6

    check-cast v6, Ljava/net/HttpURLConnection;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 168
    .end local v4    # "url":Ljava/net/URL;
    :catch_0
    move-exception v0

    .line 169
    .local v0, "e":Ljava/io/IOException;
    invoke-direct {p0, v0}, Lio/socket/engineio/client/transports/PollingXHR$Request;->onError(Ljava/lang/Exception;)V

    .line 233
    .end local v0    # "e":Ljava/io/IOException;
    :goto_2
    return-void

    .line 198
    .restart local v2    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .restart local v4    # "url":Ljava/net/URL;
    :cond_5
    # getter for: Lio/socket/engineio/client/transports/PollingXHR;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/engineio/client/transports/PollingXHR;->access$200()Ljava/util/logging/Logger;

    move-result-object v6

    const-string v7, "sending xhr with url %s | data %s"

    new-array v8, v13, [Ljava/lang/Object;

    iget-object v9, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->uri:Ljava/lang/String;

    aput-object v9, v8, v12

    iget-object v9, p0, Lio/socket/engineio/client/transports/PollingXHR$Request;->data:[B

    aput-object v9, v8, v11

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 199
    new-instance v6, Ljava/lang/Thread;

    new-instance v7, Lio/socket/engineio/client/transports/PollingXHR$Request$1;

    invoke-direct {v7, p0, v3}, Lio/socket/engineio/client/transports/PollingXHR$Request$1;-><init>(Lio/socket/engineio/client/transports/PollingXHR$Request;Lio/socket/engineio/client/transports/PollingXHR$Request;)V

    invoke-direct {v6, v7}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 232
    invoke-virtual {v6}, Ljava/lang/Thread;->start()V

    goto :goto_2
.end method
