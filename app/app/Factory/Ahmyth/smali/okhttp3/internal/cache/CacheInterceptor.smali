.class public final Lokhttp3/internal/cache/CacheInterceptor;
.super Ljava/lang/Object;
.source "CacheInterceptor.java"

# interfaces
.implements Lokhttp3/Interceptor;


# instance fields
.field final cache:Lokhttp3/internal/cache/InternalCache;


# direct methods
.method public constructor <init>(Lokhttp3/internal/cache/InternalCache;)V
    .locals 0
    .param p1, "cache"    # Lokhttp3/internal/cache/InternalCache;

    .prologue
    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    iput-object p1, p0, Lokhttp3/internal/cache/CacheInterceptor;->cache:Lokhttp3/internal/cache/InternalCache;

    .line 50
    return-void
.end method

.method private cacheWritingResponse(Lokhttp3/internal/cache/CacheRequest;Lokhttp3/Response;)Lokhttp3/Response;
    .locals 8
    .param p1, "cacheRequest"    # Lokhttp3/internal/cache/CacheRequest;
    .param p2, "response"    # Lokhttp3/Response;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 170
    if-nez p1, :cond_1

    .line 219
    .end local p2    # "response":Lokhttp3/Response;
    :cond_0
    :goto_0
    return-object p2

    .line 171
    .restart local p2    # "response":Lokhttp3/Response;
    :cond_1
    invoke-interface {p1}, Lokhttp3/internal/cache/CacheRequest;->body()Lokio/Sink;

    move-result-object v1

    .line 172
    .local v1, "cacheBodyUnbuffered":Lokio/Sink;
    if-eqz v1, :cond_0

    .line 174
    invoke-virtual {p2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v4

    invoke-virtual {v4}, Lokhttp3/ResponseBody;->source()Lokio/BufferedSource;

    move-result-object v3

    .line 175
    .local v3, "source":Lokio/BufferedSource;
    invoke-static {v1}, Lokio/Okio;->buffer(Lokio/Sink;)Lokio/BufferedSink;

    move-result-object v0

    .line 177
    .local v0, "cacheBody":Lokio/BufferedSink;
    new-instance v2, Lokhttp3/internal/cache/CacheInterceptor$1;

    invoke-direct {v2, p0, v3, p1, v0}, Lokhttp3/internal/cache/CacheInterceptor$1;-><init>(Lokhttp3/internal/cache/CacheInterceptor;Lokio/BufferedSource;Lokhttp3/internal/cache/CacheRequest;Lokio/BufferedSink;)V

    .line 219
    .local v2, "cacheWritingSource":Lokio/Source;
    invoke-virtual {p2}, Lokhttp3/Response;->newBuilder()Lokhttp3/Response$Builder;

    move-result-object v4

    new-instance v5, Lokhttp3/internal/http/RealResponseBody;

    .line 220
    invoke-virtual {p2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v6

    invoke-static {v2}, Lokio/Okio;->buffer(Lokio/Source;)Lokio/BufferedSource;

    move-result-object v7

    invoke-direct {v5, v6, v7}, Lokhttp3/internal/http/RealResponseBody;-><init>(Lokhttp3/Headers;Lokio/BufferedSource;)V

    invoke-virtual {v4, v5}, Lokhttp3/Response$Builder;->body(Lokhttp3/ResponseBody;)Lokhttp3/Response$Builder;

    move-result-object v4

    .line 221
    invoke-virtual {v4}, Lokhttp3/Response$Builder;->build()Lokhttp3/Response;

    move-result-object p2

    goto :goto_0
.end method

.method private static combine(Lokhttp3/Headers;Lokhttp3/Headers;)Lokhttp3/Headers;
    .locals 7
    .param p0, "cachedHeaders"    # Lokhttp3/Headers;
    .param p1, "networkHeaders"    # Lokhttp3/Headers;

    .prologue
    .line 226
    new-instance v2, Lokhttp3/Headers$Builder;

    invoke-direct {v2}, Lokhttp3/Headers$Builder;-><init>()V

    .line 228
    .local v2, "result":Lokhttp3/Headers$Builder;
    const/4 v1, 0x0

    .local v1, "i":I
    invoke-virtual {p0}, Lokhttp3/Headers;->size()I

    move-result v3

    .local v3, "size":I
    :goto_0
    if-ge v1, v3, :cond_3

    .line 229
    invoke-virtual {p0, v1}, Lokhttp3/Headers;->name(I)Ljava/lang/String;

    move-result-object v0

    .line 230
    .local v0, "fieldName":Ljava/lang/String;
    invoke-virtual {p0, v1}, Lokhttp3/Headers;->value(I)Ljava/lang/String;

    move-result-object v4

    .line 231
    .local v4, "value":Ljava/lang/String;
    const-string v5, "Warning"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    const-string v5, "1"

    invoke-virtual {v4, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 228
    :cond_0
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 234
    :cond_1
    invoke-static {v0}, Lokhttp3/internal/cache/CacheInterceptor;->isEndToEnd(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-virtual {p1, v0}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    if-nez v5, :cond_0

    .line 235
    :cond_2
    sget-object v5, Lokhttp3/internal/Internal;->instance:Lokhttp3/internal/Internal;

    invoke-virtual {v5, v2, v0, v4}, Lokhttp3/internal/Internal;->addLenient(Lokhttp3/Headers$Builder;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 239
    .end local v0    # "fieldName":Ljava/lang/String;
    .end local v4    # "value":Ljava/lang/String;
    :cond_3
    const/4 v1, 0x0

    invoke-virtual {p1}, Lokhttp3/Headers;->size()I

    move-result v3

    :goto_2
    if-ge v1, v3, :cond_6

    .line 240
    invoke-virtual {p1, v1}, Lokhttp3/Headers;->name(I)Ljava/lang/String;

    move-result-object v0

    .line 241
    .restart local v0    # "fieldName":Ljava/lang/String;
    const-string v5, "Content-Length"

    invoke-virtual {v5, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_5

    .line 239
    :cond_4
    :goto_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 244
    :cond_5
    invoke-static {v0}, Lokhttp3/internal/cache/CacheInterceptor;->isEndToEnd(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 245
    sget-object v5, Lokhttp3/internal/Internal;->instance:Lokhttp3/internal/Internal;

    invoke-virtual {p1, v1}, Lokhttp3/Headers;->value(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v2, v0, v6}, Lokhttp3/internal/Internal;->addLenient(Lokhttp3/Headers$Builder;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    .line 249
    .end local v0    # "fieldName":Ljava/lang/String;
    :cond_6
    invoke-virtual {v2}, Lokhttp3/Headers$Builder;->build()Lokhttp3/Headers;

    move-result-object v5

    return-object v5
.end method

.method static isEndToEnd(Ljava/lang/String;)Z
    .locals 1
    .param p0, "fieldName"    # Ljava/lang/String;

    .prologue
    .line 257
    const-string v0, "Connection"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Keep-Alive"

    .line 258
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Proxy-Authenticate"

    .line 259
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Proxy-Authorization"

    .line 260
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "TE"

    .line 261
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Trailers"

    .line 262
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Transfer-Encoding"

    .line 263
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "Upgrade"

    .line 264
    invoke-virtual {v0, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    .line 257
    :goto_0
    return v0

    .line 264
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private maybeCache(Lokhttp3/Response;Lokhttp3/Request;Lokhttp3/internal/cache/InternalCache;)Lokhttp3/internal/cache/CacheRequest;
    .locals 2
    .param p1, "userResponse"    # Lokhttp3/Response;
    .param p2, "networkRequest"    # Lokhttp3/Request;
    .param p3, "responseCache"    # Lokhttp3/internal/cache/InternalCache;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    .line 144
    if-nez p3, :cond_1

    .line 159
    :cond_0
    :goto_0
    return-object v0

    .line 147
    :cond_1
    invoke-static {p1, p2}, Lokhttp3/internal/cache/CacheStrategy;->isCacheable(Lokhttp3/Response;Lokhttp3/Request;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 148
    invoke-virtual {p2}, Lokhttp3/Request;->method()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lokhttp3/internal/http/HttpMethod;->invalidatesCache(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 150
    :try_start_0
    invoke-interface {p3, p2}, Lokhttp3/internal/cache/InternalCache;->remove(Lokhttp3/Request;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 151
    :catch_0
    move-exception v1

    goto :goto_0

    .line 159
    :cond_2
    invoke-interface {p3, p1}, Lokhttp3/internal/cache/InternalCache;->put(Lokhttp3/Response;)Lokhttp3/internal/cache/CacheRequest;

    move-result-object v0

    goto :goto_0
.end method

.method private static stripBody(Lokhttp3/Response;)Lokhttp3/Response;
    .locals 2
    .param p0, "response"    # Lokhttp3/Response;

    .prologue
    .line 137
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 138
    invoke-virtual {p0}, Lokhttp3/Response;->newBuilder()Lokhttp3/Response$Builder;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lokhttp3/Response$Builder;->body(Lokhttp3/ResponseBody;)Lokhttp3/Response$Builder;

    move-result-object v0

    invoke-virtual {v0}, Lokhttp3/Response$Builder;->build()Lokhttp3/Response;

    move-result-object p0

    .line 137
    .end local p0    # "response":Lokhttp3/Response;
    :cond_0
    return-object p0
.end method


# virtual methods
.method public intercept(Lokhttp3/Interceptor$Chain;)Lokhttp3/Response;
    .locals 12
    .param p1, "chain"    # Lokhttp3/Interceptor$Chain;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 53
    iget-object v9, p0, Lokhttp3/internal/cache/CacheInterceptor;->cache:Lokhttp3/internal/cache/InternalCache;

    if-eqz v9, :cond_3

    iget-object v9, p0, Lokhttp3/internal/cache/CacheInterceptor;->cache:Lokhttp3/internal/cache/InternalCache;

    .line 54
    invoke-interface {p1}, Lokhttp3/Interceptor$Chain;->request()Lokhttp3/Request;

    move-result-object v10

    invoke-interface {v9, v10}, Lokhttp3/internal/cache/InternalCache;->get(Lokhttp3/Request;)Lokhttp3/Response;

    move-result-object v0

    .line 57
    .local v0, "cacheCandidate":Lokhttp3/Response;
    :goto_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    .line 59
    .local v6, "now":J
    new-instance v9, Lokhttp3/internal/cache/CacheStrategy$Factory;

    invoke-interface {p1}, Lokhttp3/Interceptor$Chain;->request()Lokhttp3/Request;

    move-result-object v10

    invoke-direct {v9, v6, v7, v10, v0}, Lokhttp3/internal/cache/CacheStrategy$Factory;-><init>(JLokhttp3/Request;Lokhttp3/Response;)V

    invoke-virtual {v9}, Lokhttp3/internal/cache/CacheStrategy$Factory;->get()Lokhttp3/internal/cache/CacheStrategy;

    move-result-object v8

    .line 60
    .local v8, "strategy":Lokhttp3/internal/cache/CacheStrategy;
    iget-object v3, v8, Lokhttp3/internal/cache/CacheStrategy;->networkRequest:Lokhttp3/Request;

    .line 61
    .local v3, "networkRequest":Lokhttp3/Request;
    iget-object v2, v8, Lokhttp3/internal/cache/CacheStrategy;->cacheResponse:Lokhttp3/Response;

    .line 63
    .local v2, "cacheResponse":Lokhttp3/Response;
    iget-object v9, p0, Lokhttp3/internal/cache/CacheInterceptor;->cache:Lokhttp3/internal/cache/InternalCache;

    if-eqz v9, :cond_0

    .line 64
    iget-object v9, p0, Lokhttp3/internal/cache/CacheInterceptor;->cache:Lokhttp3/internal/cache/InternalCache;

    invoke-interface {v9, v8}, Lokhttp3/internal/cache/InternalCache;->trackResponse(Lokhttp3/internal/cache/CacheStrategy;)V

    .line 67
    :cond_0
    if-eqz v0, :cond_1

    if-nez v2, :cond_1

    .line 68
    invoke-virtual {v0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v9

    invoke-static {v9}, Lokhttp3/internal/Util;->closeQuietly(Ljava/io/Closeable;)V

    .line 72
    :cond_1
    if-nez v3, :cond_4

    if-nez v2, :cond_4

    .line 73
    new-instance v9, Lokhttp3/Response$Builder;

    invoke-direct {v9}, Lokhttp3/Response$Builder;-><init>()V

    .line 74
    invoke-interface {p1}, Lokhttp3/Interceptor$Chain;->request()Lokhttp3/Request;

    move-result-object v10

    invoke-virtual {v9, v10}, Lokhttp3/Response$Builder;->request(Lokhttp3/Request;)Lokhttp3/Response$Builder;

    move-result-object v9

    sget-object v10, Lokhttp3/Protocol;->HTTP_1_1:Lokhttp3/Protocol;

    .line 75
    invoke-virtual {v9, v10}, Lokhttp3/Response$Builder;->protocol(Lokhttp3/Protocol;)Lokhttp3/Response$Builder;

    move-result-object v9

    const/16 v10, 0x1f8

    .line 76
    invoke-virtual {v9, v10}, Lokhttp3/Response$Builder;->code(I)Lokhttp3/Response$Builder;

    move-result-object v9

    const-string v10, "Unsatisfiable Request (only-if-cached)"

    .line 77
    invoke-virtual {v9, v10}, Lokhttp3/Response$Builder;->message(Ljava/lang/String;)Lokhttp3/Response$Builder;

    move-result-object v9

    sget-object v10, Lokhttp3/internal/Util;->EMPTY_RESPONSE:Lokhttp3/ResponseBody;

    .line 78
    invoke-virtual {v9, v10}, Lokhttp3/Response$Builder;->body(Lokhttp3/ResponseBody;)Lokhttp3/Response$Builder;

    move-result-object v9

    const-wide/16 v10, -0x1

    .line 79
    invoke-virtual {v9, v10, v11}, Lokhttp3/Response$Builder;->sentRequestAtMillis(J)Lokhttp3/Response$Builder;

    move-result-object v9

    .line 80
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v10

    invoke-virtual {v9, v10, v11}, Lokhttp3/Response$Builder;->receivedResponseAtMillis(J)Lokhttp3/Response$Builder;

    move-result-object v9

    .line 81
    invoke-virtual {v9}, Lokhttp3/Response$Builder;->build()Lokhttp3/Response;

    move-result-object v5

    .line 133
    :cond_2
    :goto_1
    return-object v5

    .line 54
    .end local v0    # "cacheCandidate":Lokhttp3/Response;
    .end local v2    # "cacheResponse":Lokhttp3/Response;
    .end local v3    # "networkRequest":Lokhttp3/Request;
    .end local v6    # "now":J
    .end local v8    # "strategy":Lokhttp3/internal/cache/CacheStrategy;
    :cond_3
    const/4 v0, 0x0

    goto :goto_0

    .line 85
    .restart local v0    # "cacheCandidate":Lokhttp3/Response;
    .restart local v2    # "cacheResponse":Lokhttp3/Response;
    .restart local v3    # "networkRequest":Lokhttp3/Request;
    .restart local v6    # "now":J
    .restart local v8    # "strategy":Lokhttp3/internal/cache/CacheStrategy;
    :cond_4
    if-nez v3, :cond_5

    .line 86
    invoke-virtual {v2}, Lokhttp3/Response;->newBuilder()Lokhttp3/Response$Builder;

    move-result-object v9

    .line 87
    invoke-static {v2}, Lokhttp3/internal/cache/CacheInterceptor;->stripBody(Lokhttp3/Response;)Lokhttp3/Response;

    move-result-object v10

    invoke-virtual {v9, v10}, Lokhttp3/Response$Builder;->cacheResponse(Lokhttp3/Response;)Lokhttp3/Response$Builder;

    move-result-object v9

    .line 88
    invoke-virtual {v9}, Lokhttp3/Response$Builder;->build()Lokhttp3/Response;

    move-result-object v5

    goto :goto_1

    .line 91
    :cond_5
    const/4 v4, 0x0

    .line 93
    .local v4, "networkResponse":Lokhttp3/Response;
    :try_start_0
    invoke-interface {p1, v3}, Lokhttp3/Interceptor$Chain;->proceed(Lokhttp3/Request;)Lokhttp3/Response;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v4

    .line 96
    if-nez v4, :cond_6

    if-eqz v0, :cond_6

    .line 97
    invoke-virtual {v0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v9

    invoke-static {v9}, Lokhttp3/internal/Util;->closeQuietly(Ljava/io/Closeable;)V

    .line 102
    :cond_6
    if-eqz v2, :cond_9

    .line 103
    invoke-virtual {v4}, Lokhttp3/Response;->code()I

    move-result v9

    const/16 v10, 0x130

    if-ne v9, v10, :cond_8

    .line 104
    invoke-virtual {v2}, Lokhttp3/Response;->newBuilder()Lokhttp3/Response$Builder;

    move-result-object v9

    .line 105
    invoke-virtual {v2}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v10

    invoke-virtual {v4}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v11

    invoke-static {v10, v11}, Lokhttp3/internal/cache/CacheInterceptor;->combine(Lokhttp3/Headers;Lokhttp3/Headers;)Lokhttp3/Headers;

    move-result-object v10

    invoke-virtual {v9, v10}, Lokhttp3/Response$Builder;->headers(Lokhttp3/Headers;)Lokhttp3/Response$Builder;

    move-result-object v9

    .line 106
    invoke-virtual {v4}, Lokhttp3/Response;->sentRequestAtMillis()J

    move-result-wide v10

    invoke-virtual {v9, v10, v11}, Lokhttp3/Response$Builder;->sentRequestAtMillis(J)Lokhttp3/Response$Builder;

    move-result-object v9

    .line 107
    invoke-virtual {v4}, Lokhttp3/Response;->receivedResponseAtMillis()J

    move-result-wide v10

    invoke-virtual {v9, v10, v11}, Lokhttp3/Response$Builder;->receivedResponseAtMillis(J)Lokhttp3/Response$Builder;

    move-result-object v9

    .line 108
    invoke-static {v2}, Lokhttp3/internal/cache/CacheInterceptor;->stripBody(Lokhttp3/Response;)Lokhttp3/Response;

    move-result-object v10

    invoke-virtual {v9, v10}, Lokhttp3/Response$Builder;->cacheResponse(Lokhttp3/Response;)Lokhttp3/Response$Builder;

    move-result-object v9

    .line 109
    invoke-static {v4}, Lokhttp3/internal/cache/CacheInterceptor;->stripBody(Lokhttp3/Response;)Lokhttp3/Response;

    move-result-object v10

    invoke-virtual {v9, v10}, Lokhttp3/Response$Builder;->networkResponse(Lokhttp3/Response;)Lokhttp3/Response$Builder;

    move-result-object v9

    .line 110
    invoke-virtual {v9}, Lokhttp3/Response$Builder;->build()Lokhttp3/Response;

    move-result-object v5

    .line 111
    .local v5, "response":Lokhttp3/Response;
    invoke-virtual {v4}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v9

    invoke-virtual {v9}, Lokhttp3/ResponseBody;->close()V

    .line 115
    iget-object v9, p0, Lokhttp3/internal/cache/CacheInterceptor;->cache:Lokhttp3/internal/cache/InternalCache;

    invoke-interface {v9}, Lokhttp3/internal/cache/InternalCache;->trackConditionalCacheHit()V

    .line 116
    iget-object v9, p0, Lokhttp3/internal/cache/CacheInterceptor;->cache:Lokhttp3/internal/cache/InternalCache;

    invoke-interface {v9, v2, v5}, Lokhttp3/internal/cache/InternalCache;->update(Lokhttp3/Response;Lokhttp3/Response;)V

    goto :goto_1

    .line 96
    .end local v5    # "response":Lokhttp3/Response;
    :catchall_0
    move-exception v9

    if-nez v4, :cond_7

    if-eqz v0, :cond_7

    .line 97
    invoke-virtual {v0}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v10

    invoke-static {v10}, Lokhttp3/internal/Util;->closeQuietly(Ljava/io/Closeable;)V

    :cond_7
    throw v9

    .line 119
    :cond_8
    invoke-virtual {v2}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v9

    invoke-static {v9}, Lokhttp3/internal/Util;->closeQuietly(Ljava/io/Closeable;)V

    .line 123
    :cond_9
    invoke-virtual {v4}, Lokhttp3/Response;->newBuilder()Lokhttp3/Response$Builder;

    move-result-object v9

    .line 124
    invoke-static {v2}, Lokhttp3/internal/cache/CacheInterceptor;->stripBody(Lokhttp3/Response;)Lokhttp3/Response;

    move-result-object v10

    invoke-virtual {v9, v10}, Lokhttp3/Response$Builder;->cacheResponse(Lokhttp3/Response;)Lokhttp3/Response$Builder;

    move-result-object v9

    .line 125
    invoke-static {v4}, Lokhttp3/internal/cache/CacheInterceptor;->stripBody(Lokhttp3/Response;)Lokhttp3/Response;

    move-result-object v10

    invoke-virtual {v9, v10}, Lokhttp3/Response$Builder;->networkResponse(Lokhttp3/Response;)Lokhttp3/Response$Builder;

    move-result-object v9

    .line 126
    invoke-virtual {v9}, Lokhttp3/Response$Builder;->build()Lokhttp3/Response;

    move-result-object v5

    .line 128
    .restart local v5    # "response":Lokhttp3/Response;
    invoke-static {v5}, Lokhttp3/internal/http/HttpHeaders;->hasBody(Lokhttp3/Response;)Z

    move-result v9

    if-eqz v9, :cond_2

    .line 129
    invoke-virtual {v4}, Lokhttp3/Response;->request()Lokhttp3/Request;

    move-result-object v9

    iget-object v10, p0, Lokhttp3/internal/cache/CacheInterceptor;->cache:Lokhttp3/internal/cache/InternalCache;

    invoke-direct {p0, v5, v9, v10}, Lokhttp3/internal/cache/CacheInterceptor;->maybeCache(Lokhttp3/Response;Lokhttp3/Request;Lokhttp3/internal/cache/InternalCache;)Lokhttp3/internal/cache/CacheRequest;

    move-result-object v1

    .line 130
    .local v1, "cacheRequest":Lokhttp3/internal/cache/CacheRequest;
    invoke-direct {p0, v1, v5}, Lokhttp3/internal/cache/CacheInterceptor;->cacheWritingResponse(Lokhttp3/internal/cache/CacheRequest;Lokhttp3/Response;)Lokhttp3/Response;

    move-result-object v5

    goto/16 :goto_1
.end method
