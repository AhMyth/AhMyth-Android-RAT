.class public final Lokio/HashingSink;
.super Lokio/ForwardingSink;
.source "HashingSink.java"


# instance fields
.field private final mac:Ljavax/crypto/Mac;

.field private final messageDigest:Ljava/security/MessageDigest;


# direct methods
.method private constructor <init>(Lokio/Sink;Ljava/lang/String;)V
    .locals 2
    .param p1, "sink"    # Lokio/Sink;
    .param p2, "algorithm"    # Ljava/lang/String;

    .prologue
    .line 73
    invoke-direct {p0, p1}, Lokio/ForwardingSink;-><init>(Lokio/Sink;)V

    .line 75
    :try_start_0
    invoke-static {p2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v1

    iput-object v1, p0, Lokio/HashingSink;->messageDigest:Ljava/security/MessageDigest;

    .line 76
    const/4 v1, 0x0

    iput-object v1, p0, Lokio/HashingSink;->mac:Ljavax/crypto/Mac;
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0

    .line 80
    return-void

    .line 77
    :catch_0
    move-exception v0

    .line 78
    .local v0, "e":Ljava/security/NoSuchAlgorithmException;
    new-instance v1, Ljava/lang/AssertionError;

    invoke-direct {v1}, Ljava/lang/AssertionError;-><init>()V

    throw v1
.end method

.method private constructor <init>(Lokio/Sink;Lokio/ByteString;Ljava/lang/String;)V
    .locals 4
    .param p1, "sink"    # Lokio/Sink;
    .param p2, "key"    # Lokio/ByteString;
    .param p3, "algorithm"    # Ljava/lang/String;

    .prologue
    .line 83
    invoke-direct {p0, p1}, Lokio/ForwardingSink;-><init>(Lokio/Sink;)V

    .line 85
    :try_start_0
    invoke-static {p3}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v1

    iput-object v1, p0, Lokio/HashingSink;->mac:Ljavax/crypto/Mac;

    .line 86
    iget-object v1, p0, Lokio/HashingSink;->mac:Ljavax/crypto/Mac;

    new-instance v2, Ljavax/crypto/spec/SecretKeySpec;

    invoke-virtual {p2}, Lokio/ByteString;->toByteArray()[B

    move-result-object v3

    invoke-direct {v2, v3, p3}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    invoke-virtual {v1, v2}, Ljavax/crypto/Mac;->init(Ljava/security/Key;)V

    .line 87
    const/4 v1, 0x0

    iput-object v1, p0, Lokio/HashingSink;->messageDigest:Ljava/security/MessageDigest;
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/security/InvalidKeyException; {:try_start_0 .. :try_end_0} :catch_1

    .line 93
    return-void

    .line 88
    :catch_0
    move-exception v0

    .line 89
    .local v0, "e":Ljava/security/NoSuchAlgorithmException;
    new-instance v1, Ljava/lang/AssertionError;

    invoke-direct {v1}, Ljava/lang/AssertionError;-><init>()V

    throw v1

    .line 90
    .end local v0    # "e":Ljava/security/NoSuchAlgorithmException;
    :catch_1
    move-exception v0

    .line 91
    .local v0, "e":Ljava/security/InvalidKeyException;
    new-instance v1, Ljava/lang/IllegalArgumentException;

    invoke-direct {v1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public static hmacSha1(Lokio/Sink;Lokio/ByteString;)Lokio/HashingSink;
    .locals 2
    .param p0, "sink"    # Lokio/Sink;
    .param p1, "key"    # Lokio/ByteString;

    .prologue
    .line 64
    new-instance v0, Lokio/HashingSink;

    const-string v1, "HmacSHA1"

    invoke-direct {v0, p0, p1, v1}, Lokio/HashingSink;-><init>(Lokio/Sink;Lokio/ByteString;Ljava/lang/String;)V

    return-object v0
.end method

.method public static hmacSha256(Lokio/Sink;Lokio/ByteString;)Lokio/HashingSink;
    .locals 2
    .param p0, "sink"    # Lokio/Sink;
    .param p1, "key"    # Lokio/ByteString;

    .prologue
    .line 69
    new-instance v0, Lokio/HashingSink;

    const-string v1, "HmacSHA256"

    invoke-direct {v0, p0, p1, v1}, Lokio/HashingSink;-><init>(Lokio/Sink;Lokio/ByteString;Ljava/lang/String;)V

    return-object v0
.end method

.method public static md5(Lokio/Sink;)Lokio/HashingSink;
    .locals 2
    .param p0, "sink"    # Lokio/Sink;

    .prologue
    .line 49
    new-instance v0, Lokio/HashingSink;

    const-string v1, "MD5"

    invoke-direct {v0, p0, v1}, Lokio/HashingSink;-><init>(Lokio/Sink;Ljava/lang/String;)V

    return-object v0
.end method

.method public static sha1(Lokio/Sink;)Lokio/HashingSink;
    .locals 2
    .param p0, "sink"    # Lokio/Sink;

    .prologue
    .line 54
    new-instance v0, Lokio/HashingSink;

    const-string v1, "SHA-1"

    invoke-direct {v0, p0, v1}, Lokio/HashingSink;-><init>(Lokio/Sink;Ljava/lang/String;)V

    return-object v0
.end method

.method public static sha256(Lokio/Sink;)Lokio/HashingSink;
    .locals 2
    .param p0, "sink"    # Lokio/Sink;

    .prologue
    .line 59
    new-instance v0, Lokio/HashingSink;

    const-string v1, "SHA-256"

    invoke-direct {v0, p0, v1}, Lokio/HashingSink;-><init>(Lokio/Sink;Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method public hash()Lokio/ByteString;
    .locals 2

    .prologue
    .line 121
    iget-object v1, p0, Lokio/HashingSink;->messageDigest:Ljava/security/MessageDigest;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lokio/HashingSink;->messageDigest:Ljava/security/MessageDigest;

    invoke-virtual {v1}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v0

    .line 122
    .local v0, "result":[B
    :goto_0
    invoke-static {v0}, Lokio/ByteString;->of([B)Lokio/ByteString;

    move-result-object v1

    return-object v1

    .line 121
    .end local v0    # "result":[B
    :cond_0
    iget-object v1, p0, Lokio/HashingSink;->mac:Ljavax/crypto/Mac;

    invoke-virtual {v1}, Ljavax/crypto/Mac;->doFinal()[B

    move-result-object v0

    goto :goto_0
.end method

.method public write(Lokio/Buffer;J)V
    .locals 10
    .param p1, "source"    # Lokio/Buffer;
    .param p2, "byteCount"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 96
    iget-wide v0, p1, Lokio/Buffer;->size:J

    const-wide/16 v2, 0x0

    move-wide v4, p2

    invoke-static/range {v0 .. v5}, Lokio/Util;->checkOffsetAndCount(JJJ)V

    .line 99
    const-wide/16 v6, 0x0

    .line 100
    .local v6, "hashedCount":J
    iget-object v8, p1, Lokio/Buffer;->head:Lokio/Segment;

    .local v8, "s":Lokio/Segment;
    :goto_0
    cmp-long v0, v6, p2

    if-gez v0, :cond_1

    .line 101
    sub-long v0, p2, v6

    iget v2, v8, Lokio/Segment;->limit:I

    iget v3, v8, Lokio/Segment;->pos:I

    sub-int/2addr v2, v3

    int-to-long v2, v2

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v0

    long-to-int v9, v0

    .line 102
    .local v9, "toHash":I
    iget-object v0, p0, Lokio/HashingSink;->messageDigest:Ljava/security/MessageDigest;

    if-eqz v0, :cond_0

    .line 103
    iget-object v0, p0, Lokio/HashingSink;->messageDigest:Ljava/security/MessageDigest;

    iget-object v1, v8, Lokio/Segment;->data:[B

    iget v2, v8, Lokio/Segment;->pos:I

    invoke-virtual {v0, v1, v2, v9}, Ljava/security/MessageDigest;->update([BII)V

    .line 107
    :goto_1
    int-to-long v0, v9

    add-long/2addr v6, v0

    .line 100
    iget-object v8, v8, Lokio/Segment;->next:Lokio/Segment;

    goto :goto_0

    .line 105
    :cond_0
    iget-object v0, p0, Lokio/HashingSink;->mac:Ljavax/crypto/Mac;

    iget-object v1, v8, Lokio/Segment;->data:[B

    iget v2, v8, Lokio/Segment;->pos:I

    invoke-virtual {v0, v1, v2, v9}, Ljavax/crypto/Mac;->update([BII)V

    goto :goto_1

    .line 111
    .end local v9    # "toHash":I
    :cond_1
    invoke-super {p0, p1, p2, p3}, Lokio/ForwardingSink;->write(Lokio/Buffer;J)V

    .line 112
    return-void
.end method
