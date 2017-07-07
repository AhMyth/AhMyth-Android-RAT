.class public final Lokhttp3/Response;
.super Ljava/lang/Object;
.source "Response.java"

# interfaces
.implements Ljava/io/Closeable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lokhttp3/Response$Builder;
    }
.end annotation


# instance fields
.field final body:Lokhttp3/ResponseBody;

.field private volatile cacheControl:Lokhttp3/CacheControl;

.field final cacheResponse:Lokhttp3/Response;

.field final code:I

.field final handshake:Lokhttp3/Handshake;

.field final headers:Lokhttp3/Headers;

.field final message:Ljava/lang/String;

.field final networkResponse:Lokhttp3/Response;

.field final priorResponse:Lokhttp3/Response;

.field final protocol:Lokhttp3/Protocol;

.field final receivedResponseAtMillis:J

.field final request:Lokhttp3/Request;

.field final sentRequestAtMillis:J


# direct methods
.method constructor <init>(Lokhttp3/Response$Builder;)V
    .locals 2
    .param p1, "builder"    # Lokhttp3/Response$Builder;

    .prologue
    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    iget-object v0, p1, Lokhttp3/Response$Builder;->request:Lokhttp3/Request;

    iput-object v0, p0, Lokhttp3/Response;->request:Lokhttp3/Request;

    .line 60
    iget-object v0, p1, Lokhttp3/Response$Builder;->protocol:Lokhttp3/Protocol;

    iput-object v0, p0, Lokhttp3/Response;->protocol:Lokhttp3/Protocol;

    .line 61
    iget v0, p1, Lokhttp3/Response$Builder;->code:I

    iput v0, p0, Lokhttp3/Response;->code:I

    .line 62
    iget-object v0, p1, Lokhttp3/Response$Builder;->message:Ljava/lang/String;

    iput-object v0, p0, Lokhttp3/Response;->message:Ljava/lang/String;

    .line 63
    iget-object v0, p1, Lokhttp3/Response$Builder;->handshake:Lokhttp3/Handshake;

    iput-object v0, p0, Lokhttp3/Response;->handshake:Lokhttp3/Handshake;

    .line 64
    iget-object v0, p1, Lokhttp3/Response$Builder;->headers:Lokhttp3/Headers$Builder;

    invoke-virtual {v0}, Lokhttp3/Headers$Builder;->build()Lokhttp3/Headers;

    move-result-object v0

    iput-object v0, p0, Lokhttp3/Response;->headers:Lokhttp3/Headers;

    .line 65
    iget-object v0, p1, Lokhttp3/Response$Builder;->body:Lokhttp3/ResponseBody;

    iput-object v0, p0, Lokhttp3/Response;->body:Lokhttp3/ResponseBody;

    .line 66
    iget-object v0, p1, Lokhttp3/Response$Builder;->networkResponse:Lokhttp3/Response;

    iput-object v0, p0, Lokhttp3/Response;->networkResponse:Lokhttp3/Response;

    .line 67
    iget-object v0, p1, Lokhttp3/Response$Builder;->cacheResponse:Lokhttp3/Response;

    iput-object v0, p0, Lokhttp3/Response;->cacheResponse:Lokhttp3/Response;

    .line 68
    iget-object v0, p1, Lokhttp3/Response$Builder;->priorResponse:Lokhttp3/Response;

    iput-object v0, p0, Lokhttp3/Response;->priorResponse:Lokhttp3/Response;

    .line 69
    iget-wide v0, p1, Lokhttp3/Response$Builder;->sentRequestAtMillis:J

    iput-wide v0, p0, Lokhttp3/Response;->sentRequestAtMillis:J

    .line 70
    iget-wide v0, p1, Lokhttp3/Response$Builder;->receivedResponseAtMillis:J

    iput-wide v0, p0, Lokhttp3/Response;->receivedResponseAtMillis:J

    .line 71
    return-void
.end method


# virtual methods
.method public body()Lokhttp3/ResponseBody;
    .locals 1

    .prologue
    .line 176
    iget-object v0, p0, Lokhttp3/Response;->body:Lokhttp3/ResponseBody;

    return-object v0
.end method

.method public cacheControl()Lokhttp3/CacheControl;
    .locals 2

    .prologue
    .line 249
    iget-object v0, p0, Lokhttp3/Response;->cacheControl:Lokhttp3/CacheControl;

    .line 250
    .local v0, "result":Lokhttp3/CacheControl;
    if-eqz v0, :cond_0

    .end local v0    # "result":Lokhttp3/CacheControl;
    :goto_0
    return-object v0

    .restart local v0    # "result":Lokhttp3/CacheControl;
    :cond_0
    iget-object v1, p0, Lokhttp3/Response;->headers:Lokhttp3/Headers;

    invoke-static {v1}, Lokhttp3/CacheControl;->parse(Lokhttp3/Headers;)Lokhttp3/CacheControl;

    move-result-object v0

    .end local v0    # "result":Lokhttp3/CacheControl;
    iput-object v0, p0, Lokhttp3/Response;->cacheControl:Lokhttp3/CacheControl;

    goto :goto_0
.end method

.method public cacheResponse()Lokhttp3/Response;
    .locals 1

    .prologue
    .line 213
    iget-object v0, p0, Lokhttp3/Response;->cacheResponse:Lokhttp3/Response;

    return-object v0
.end method

.method public challenges()Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Lokhttp3/Challenge;",
            ">;"
        }
    .end annotation

    .prologue
    .line 234
    iget v1, p0, Lokhttp3/Response;->code:I

    const/16 v2, 0x191

    if-ne v1, v2, :cond_0

    .line 235
    const-string v0, "WWW-Authenticate"

    .line 241
    .local v0, "responseField":Ljava/lang/String;
    :goto_0
    invoke-virtual {p0}, Lokhttp3/Response;->headers()Lokhttp3/Headers;

    move-result-object v1

    invoke-static {v1, v0}, Lokhttp3/internal/http/HttpHeaders;->parseChallenges(Lokhttp3/Headers;Ljava/lang/String;)Ljava/util/List;

    move-result-object v1

    .end local v0    # "responseField":Ljava/lang/String;
    :goto_1
    return-object v1

    .line 236
    :cond_0
    iget v1, p0, Lokhttp3/Response;->code:I

    const/16 v2, 0x197

    if-ne v1, v2, :cond_1

    .line 237
    const-string v0, "Proxy-Authenticate"

    .restart local v0    # "responseField":Ljava/lang/String;
    goto :goto_0

    .line 239
    .end local v0    # "responseField":Ljava/lang/String;
    :cond_1
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v1

    goto :goto_1
.end method

.method public close()V
    .locals 1

    .prologue
    .line 273
    iget-object v0, p0, Lokhttp3/Response;->body:Lokhttp3/ResponseBody;

    invoke-virtual {v0}, Lokhttp3/ResponseBody;->close()V

    .line 274
    return-void
.end method

.method public code()I
    .locals 1

    .prologue
    .line 97
    iget v0, p0, Lokhttp3/Response;->code:I

    return v0
.end method

.method public handshake()Lokhttp3/Handshake;
    .locals 1

    .prologue
    .line 118
    iget-object v0, p0, Lokhttp3/Response;->handshake:Lokhttp3/Handshake;

    return-object v0
.end method

.method public header(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 126
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lokhttp3/Response;->header(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public header(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "defaultValue"    # Ljava/lang/String;

    .prologue
    .line 130
    iget-object v1, p0, Lokhttp3/Response;->headers:Lokhttp3/Headers;

    invoke-virtual {v1, p1}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 131
    .local v0, "result":Ljava/lang/String;
    if-eqz v0, :cond_0

    .end local v0    # "result":Ljava/lang/String;
    :goto_0
    return-object v0

    .restart local v0    # "result":Ljava/lang/String;
    :cond_0
    move-object v0, p2

    goto :goto_0
.end method

.method public headers(Ljava/lang/String;)Ljava/util/List;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 122
    iget-object v0, p0, Lokhttp3/Response;->headers:Lokhttp3/Headers;

    invoke-virtual {v0, p1}, Lokhttp3/Headers;->values(Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public headers()Lokhttp3/Headers;
    .locals 1

    .prologue
    .line 135
    iget-object v0, p0, Lokhttp3/Response;->headers:Lokhttp3/Headers;

    return-object v0
.end method

.method public isRedirect()Z
    .locals 1

    .prologue
    .line 185
    iget v0, p0, Lokhttp3/Response;->code:I

    packed-switch v0, :pswitch_data_0

    .line 194
    :pswitch_0
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 192
    :pswitch_1
    const/4 v0, 0x1

    goto :goto_0

    .line 185
    nop

    :pswitch_data_0
    .packed-switch 0x12c
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_1
    .end packed-switch
.end method

.method public isSuccessful()Z
    .locals 2

    .prologue
    .line 105
    iget v0, p0, Lokhttp3/Response;->code:I

    const/16 v1, 0xc8

    if-lt v0, v1, :cond_0

    iget v0, p0, Lokhttp3/Response;->code:I

    const/16 v1, 0x12c

    if-ge v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public message()Ljava/lang/String;
    .locals 1

    .prologue
    .line 110
    iget-object v0, p0, Lokhttp3/Response;->message:Ljava/lang/String;

    return-object v0
.end method

.method public networkResponse()Lokhttp3/Response;
    .locals 1

    .prologue
    .line 204
    iget-object v0, p0, Lokhttp3/Response;->networkResponse:Lokhttp3/Response;

    return-object v0
.end method

.method public newBuilder()Lokhttp3/Response$Builder;
    .locals 1

    .prologue
    .line 180
    new-instance v0, Lokhttp3/Response$Builder;

    invoke-direct {v0, p0}, Lokhttp3/Response$Builder;-><init>(Lokhttp3/Response;)V

    return-object v0
.end method

.method public peekBody(J)Lokhttp3/ResponseBody;
    .locals 7
    .param p1, "byteCount"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 150
    iget-object v3, p0, Lokhttp3/Response;->body:Lokhttp3/ResponseBody;

    invoke-virtual {v3}, Lokhttp3/ResponseBody;->source()Lokio/BufferedSource;

    move-result-object v2

    .line 151
    .local v2, "source":Lokio/BufferedSource;
    invoke-interface {v2, p1, p2}, Lokio/BufferedSource;->request(J)Z

    .line 152
    invoke-interface {v2}, Lokio/BufferedSource;->buffer()Lokio/Buffer;

    move-result-object v3

    invoke-virtual {v3}, Lokio/Buffer;->clone()Lokio/Buffer;

    move-result-object v0

    .line 156
    .local v0, "copy":Lokio/Buffer;
    invoke-virtual {v0}, Lokio/Buffer;->size()J

    move-result-wide v4

    cmp-long v3, v4, p1

    if-lez v3, :cond_0

    .line 157
    new-instance v1, Lokio/Buffer;

    invoke-direct {v1}, Lokio/Buffer;-><init>()V

    .line 158
    .local v1, "result":Lokio/Buffer;
    invoke-virtual {v1, v0, p1, p2}, Lokio/Buffer;->write(Lokio/Buffer;J)V

    .line 159
    invoke-virtual {v0}, Lokio/Buffer;->clear()V

    .line 164
    :goto_0
    iget-object v3, p0, Lokhttp3/Response;->body:Lokhttp3/ResponseBody;

    invoke-virtual {v3}, Lokhttp3/ResponseBody;->contentType()Lokhttp3/MediaType;

    move-result-object v3

    invoke-virtual {v1}, Lokio/Buffer;->size()J

    move-result-wide v4

    invoke-static {v3, v4, v5, v1}, Lokhttp3/ResponseBody;->create(Lokhttp3/MediaType;JLokio/BufferedSource;)Lokhttp3/ResponseBody;

    move-result-object v3

    return-object v3

    .line 161
    .end local v1    # "result":Lokio/Buffer;
    :cond_0
    move-object v1, v0

    .restart local v1    # "result":Lokio/Buffer;
    goto :goto_0
.end method

.method public priorResponse()Lokhttp3/Response;
    .locals 1

    .prologue
    .line 223
    iget-object v0, p0, Lokhttp3/Response;->priorResponse:Lokhttp3/Response;

    return-object v0
.end method

.method public protocol()Lokhttp3/Protocol;
    .locals 1

    .prologue
    .line 92
    iget-object v0, p0, Lokhttp3/Response;->protocol:Lokhttp3/Protocol;

    return-object v0
.end method

.method public receivedResponseAtMillis()J
    .locals 2

    .prologue
    .line 268
    iget-wide v0, p0, Lokhttp3/Response;->receivedResponseAtMillis:J

    return-wide v0
.end method

.method public request()Lokhttp3/Request;
    .locals 1

    .prologue
    .line 85
    iget-object v0, p0, Lokhttp3/Response;->request:Lokhttp3/Request;

    return-object v0
.end method

.method public sentRequestAtMillis()J
    .locals 2

    .prologue
    .line 259
    iget-wide v0, p0, Lokhttp3/Response;->sentRequestAtMillis:J

    return-wide v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 277
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Response{protocol="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lokhttp3/Response;->protocol:Lokhttp3/Protocol;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", code="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lokhttp3/Response;->code:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", message="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lokhttp3/Response;->message:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", url="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lokhttp3/Response;->request:Lokhttp3/Request;

    .line 284
    invoke-virtual {v1}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 277
    return-object v0
.end method
