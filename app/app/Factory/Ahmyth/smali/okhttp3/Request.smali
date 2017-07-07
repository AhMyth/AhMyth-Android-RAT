.class public final Lokhttp3/Request;
.super Ljava/lang/Object;
.source "Request.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lokhttp3/Request$Builder;
    }
.end annotation


# instance fields
.field final body:Lokhttp3/RequestBody;

.field private volatile cacheControl:Lokhttp3/CacheControl;

.field final headers:Lokhttp3/Headers;

.field final method:Ljava/lang/String;

.field final tag:Ljava/lang/Object;

.field final url:Lokhttp3/HttpUrl;


# direct methods
.method constructor <init>(Lokhttp3/Request$Builder;)V
    .locals 1
    .param p1, "builder"    # Lokhttp3/Request$Builder;

    .prologue
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    iget-object v0, p1, Lokhttp3/Request$Builder;->url:Lokhttp3/HttpUrl;

    iput-object v0, p0, Lokhttp3/Request;->url:Lokhttp3/HttpUrl;

    .line 38
    iget-object v0, p1, Lokhttp3/Request$Builder;->method:Ljava/lang/String;

    iput-object v0, p0, Lokhttp3/Request;->method:Ljava/lang/String;

    .line 39
    iget-object v0, p1, Lokhttp3/Request$Builder;->headers:Lokhttp3/Headers$Builder;

    invoke-virtual {v0}, Lokhttp3/Headers$Builder;->build()Lokhttp3/Headers;

    move-result-object v0

    iput-object v0, p0, Lokhttp3/Request;->headers:Lokhttp3/Headers;

    .line 40
    iget-object v0, p1, Lokhttp3/Request$Builder;->body:Lokhttp3/RequestBody;

    iput-object v0, p0, Lokhttp3/Request;->body:Lokhttp3/RequestBody;

    .line 41
    iget-object v0, p1, Lokhttp3/Request$Builder;->tag:Ljava/lang/Object;

    if-eqz v0, :cond_0

    iget-object v0, p1, Lokhttp3/Request$Builder;->tag:Ljava/lang/Object;

    :goto_0
    iput-object v0, p0, Lokhttp3/Request;->tag:Ljava/lang/Object;

    .line 42
    return-void

    :cond_0
    move-object v0, p0

    .line 41
    goto :goto_0
.end method


# virtual methods
.method public body()Lokhttp3/RequestBody;
    .locals 1

    .prologue
    .line 65
    iget-object v0, p0, Lokhttp3/Request;->body:Lokhttp3/RequestBody;

    return-object v0
.end method

.method public cacheControl()Lokhttp3/CacheControl;
    .locals 2

    .prologue
    .line 81
    iget-object v0, p0, Lokhttp3/Request;->cacheControl:Lokhttp3/CacheControl;

    .line 82
    .local v0, "result":Lokhttp3/CacheControl;
    if-eqz v0, :cond_0

    .end local v0    # "result":Lokhttp3/CacheControl;
    :goto_0
    return-object v0

    .restart local v0    # "result":Lokhttp3/CacheControl;
    :cond_0
    iget-object v1, p0, Lokhttp3/Request;->headers:Lokhttp3/Headers;

    invoke-static {v1}, Lokhttp3/CacheControl;->parse(Lokhttp3/Headers;)Lokhttp3/CacheControl;

    move-result-object v0

    .end local v0    # "result":Lokhttp3/CacheControl;
    iput-object v0, p0, Lokhttp3/Request;->cacheControl:Lokhttp3/CacheControl;

    goto :goto_0
.end method

.method public header(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 57
    iget-object v0, p0, Lokhttp3/Request;->headers:Lokhttp3/Headers;

    invoke-virtual {v0, p1}, Lokhttp3/Headers;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
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
    .line 61
    iget-object v0, p0, Lokhttp3/Request;->headers:Lokhttp3/Headers;

    invoke-virtual {v0, p1}, Lokhttp3/Headers;->values(Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public headers()Lokhttp3/Headers;
    .locals 1

    .prologue
    .line 53
    iget-object v0, p0, Lokhttp3/Request;->headers:Lokhttp3/Headers;

    return-object v0
.end method

.method public isHttps()Z
    .locals 1

    .prologue
    .line 86
    iget-object v0, p0, Lokhttp3/Request;->url:Lokhttp3/HttpUrl;

    invoke-virtual {v0}, Lokhttp3/HttpUrl;->isHttps()Z

    move-result v0

    return v0
.end method

.method public method()Ljava/lang/String;
    .locals 1

    .prologue
    .line 49
    iget-object v0, p0, Lokhttp3/Request;->method:Ljava/lang/String;

    return-object v0
.end method

.method public newBuilder()Lokhttp3/Request$Builder;
    .locals 1

    .prologue
    .line 73
    new-instance v0, Lokhttp3/Request$Builder;

    invoke-direct {v0, p0}, Lokhttp3/Request$Builder;-><init>(Lokhttp3/Request;)V

    return-object v0
.end method

.method public tag()Ljava/lang/Object;
    .locals 1

    .prologue
    .line 69
    iget-object v0, p0, Lokhttp3/Request;->tag:Ljava/lang/Object;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 90
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Request{method="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lokhttp3/Request;->method:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", url="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lokhttp3/Request;->url:Lokhttp3/HttpUrl;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", tag="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v0, p0, Lokhttp3/Request;->tag:Ljava/lang/Object;

    if-eq v0, p0, :cond_0

    iget-object v0, p0, Lokhttp3/Request;->tag:Ljava/lang/Object;

    :goto_0
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x7d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public url()Lokhttp3/HttpUrl;
    .locals 1

    .prologue
    .line 45
    iget-object v0, p0, Lokhttp3/Request;->url:Lokhttp3/HttpUrl;

    return-object v0
.end method
