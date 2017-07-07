.class public abstract Lokhttp3/RequestBody;
.super Ljava/lang/Object;
.source "RequestBody.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static create(Lokhttp3/MediaType;Ljava/io/File;)Lokhttp3/RequestBody;
    .locals 2
    .param p0, "contentType"    # Lokhttp3/MediaType;
    .param p1, "file"    # Ljava/io/File;

    .prologue
    .line 103
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "content == null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 105
    :cond_0
    new-instance v0, Lokhttp3/RequestBody$3;

    invoke-direct {v0, p0, p1}, Lokhttp3/RequestBody$3;-><init>(Lokhttp3/MediaType;Ljava/io/File;)V

    return-object v0
.end method

.method public static create(Lokhttp3/MediaType;Ljava/lang/String;)Lokhttp3/RequestBody;
    .locals 4
    .param p0, "contentType"    # Lokhttp3/MediaType;
    .param p1, "content"    # Ljava/lang/String;

    .prologue
    .line 47
    sget-object v1, Lokhttp3/internal/Util;->UTF_8:Ljava/nio/charset/Charset;

    .line 48
    .local v1, "charset":Ljava/nio/charset/Charset;
    if-eqz p0, :cond_0

    .line 49
    invoke-virtual {p0}, Lokhttp3/MediaType;->charset()Ljava/nio/charset/Charset;

    move-result-object v1

    .line 50
    if-nez v1, :cond_0

    .line 51
    sget-object v1, Lokhttp3/internal/Util;->UTF_8:Ljava/nio/charset/Charset;

    .line 52
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "; charset=utf-8"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object p0

    .line 55
    :cond_0
    invoke-virtual {p1, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    .line 56
    .local v0, "bytes":[B
    invoke-static {p0, v0}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;[B)Lokhttp3/RequestBody;

    move-result-object v2

    return-object v2
.end method

.method public static create(Lokhttp3/MediaType;Lokio/ByteString;)Lokhttp3/RequestBody;
    .locals 1
    .param p0, "contentType"    # Lokhttp3/MediaType;
    .param p1, "content"    # Lokio/ByteString;

    .prologue
    .line 61
    new-instance v0, Lokhttp3/RequestBody$1;

    invoke-direct {v0, p0, p1}, Lokhttp3/RequestBody$1;-><init>(Lokhttp3/MediaType;Lokio/ByteString;)V

    return-object v0
.end method

.method public static create(Lokhttp3/MediaType;[B)Lokhttp3/RequestBody;
    .locals 2
    .param p0, "contentType"    # Lokhttp3/MediaType;
    .param p1, "content"    # [B

    .prologue
    .line 78
    const/4 v0, 0x0

    array-length v1, p1

    invoke-static {p0, p1, v0, v1}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;[BII)Lokhttp3/RequestBody;

    move-result-object v0

    return-object v0
.end method

.method public static create(Lokhttp3/MediaType;[BII)Lokhttp3/RequestBody;
    .locals 6
    .param p0, "contentType"    # Lokhttp3/MediaType;
    .param p1, "content"    # [B
    .param p2, "offset"    # I
    .param p3, "byteCount"    # I

    .prologue
    .line 84
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "content == null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 85
    :cond_0
    array-length v0, p1

    int-to-long v0, v0

    int-to-long v2, p2

    int-to-long v4, p3

    invoke-static/range {v0 .. v5}, Lokhttp3/internal/Util;->checkOffsetAndCount(JJJ)V

    .line 86
    new-instance v0, Lokhttp3/RequestBody$2;

    invoke-direct {v0, p0, p3, p1, p2}, Lokhttp3/RequestBody$2;-><init>(Lokhttp3/MediaType;I[BI)V

    return-object v0
.end method


# virtual methods
.method public contentLength()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 36
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public abstract contentType()Lokhttp3/MediaType;
.end method

.method public abstract writeTo(Lokio/BufferedSink;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method
