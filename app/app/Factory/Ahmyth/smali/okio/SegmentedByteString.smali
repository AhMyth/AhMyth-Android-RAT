.class final Lokio/SegmentedByteString;
.super Lokio/ByteString;
.source "SegmentedByteString.java"


# instance fields
.field final transient directory:[I

.field final transient segments:[[B


# direct methods
.method constructor <init>(Lokio/Buffer;I)V
    .locals 9
    .param p1, "buffer"    # Lokio/Buffer;
    .param p2, "byteCount"    # I

    .prologue
    .line 57
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lokio/ByteString;-><init>([B)V

    .line 58
    iget-wide v0, p1, Lokio/Buffer;->size:J

    const-wide/16 v2, 0x0

    int-to-long v4, p2

    invoke-static/range {v0 .. v5}, Lokio/Util;->checkOffsetAndCount(JJJ)V

    .line 61
    const/4 v6, 0x0

    .line 62
    .local v6, "offset":I
    const/4 v8, 0x0

    .line 63
    .local v8, "segmentCount":I
    iget-object v7, p1, Lokio/Buffer;->head:Lokio/Segment;

    .local v7, "s":Lokio/Segment;
    :goto_0
    if-ge v6, p2, :cond_1

    .line 64
    iget v0, v7, Lokio/Segment;->limit:I

    iget v1, v7, Lokio/Segment;->pos:I

    if-ne v0, v1, :cond_0

    .line 65
    new-instance v0, Ljava/lang/AssertionError;

    const-string v1, "s.limit == s.pos"

    invoke-direct {v0, v1}, Ljava/lang/AssertionError;-><init>(Ljava/lang/Object;)V

    throw v0

    .line 67
    :cond_0
    iget v0, v7, Lokio/Segment;->limit:I

    iget v1, v7, Lokio/Segment;->pos:I

    sub-int/2addr v0, v1

    add-int/2addr v6, v0

    .line 68
    add-int/lit8 v8, v8, 0x1

    .line 63
    iget-object v7, v7, Lokio/Segment;->next:Lokio/Segment;

    goto :goto_0

    .line 72
    :cond_1
    new-array v0, v8, [[B

    iput-object v0, p0, Lokio/SegmentedByteString;->segments:[[B

    .line 73
    mul-int/lit8 v0, v8, 0x2

    new-array v0, v0, [I

    iput-object v0, p0, Lokio/SegmentedByteString;->directory:[I

    .line 74
    const/4 v6, 0x0

    .line 75
    const/4 v8, 0x0

    .line 76
    iget-object v7, p1, Lokio/Buffer;->head:Lokio/Segment;

    :goto_1
    if-ge v6, p2, :cond_3

    .line 77
    iget-object v0, p0, Lokio/SegmentedByteString;->segments:[[B

    iget-object v1, v7, Lokio/Segment;->data:[B

    aput-object v1, v0, v8

    .line 78
    iget v0, v7, Lokio/Segment;->limit:I

    iget v1, v7, Lokio/Segment;->pos:I

    sub-int/2addr v0, v1

    add-int/2addr v6, v0

    .line 79
    if-le v6, p2, :cond_2

    .line 80
    move v6, p2

    .line 82
    :cond_2
    iget-object v0, p0, Lokio/SegmentedByteString;->directory:[I

    aput v6, v0, v8

    .line 83
    iget-object v0, p0, Lokio/SegmentedByteString;->directory:[I

    iget-object v1, p0, Lokio/SegmentedByteString;->segments:[[B

    array-length v1, v1

    add-int/2addr v1, v8

    iget v2, v7, Lokio/Segment;->pos:I

    aput v2, v0, v1

    .line 84
    const/4 v0, 0x1

    iput-boolean v0, v7, Lokio/Segment;->shared:Z

    .line 85
    add-int/lit8 v8, v8, 0x1

    .line 76
    iget-object v7, v7, Lokio/Segment;->next:Lokio/Segment;

    goto :goto_1

    .line 87
    :cond_3
    return-void
.end method

.method private segment(I)I
    .locals 5
    .param p1, "pos"    # I

    .prologue
    .line 156
    iget-object v1, p0, Lokio/SegmentedByteString;->directory:[I

    const/4 v2, 0x0

    iget-object v3, p0, Lokio/SegmentedByteString;->segments:[[B

    array-length v3, v3

    add-int/lit8 v4, p1, 0x1

    invoke-static {v1, v2, v3, v4}, Ljava/util/Arrays;->binarySearch([IIII)I

    move-result v0

    .line 157
    .local v0, "i":I
    if-ltz v0, :cond_0

    .end local v0    # "i":I
    :goto_0
    return v0

    .restart local v0    # "i":I
    :cond_0
    xor-int/lit8 v0, v0, -0x1

    goto :goto_0
.end method

.method private toByteString()Lokio/ByteString;
    .locals 2

    .prologue
    .line 257
    new-instance v0, Lokio/ByteString;

    invoke-virtual {p0}, Lokio/SegmentedByteString;->toByteArray()[B

    move-result-object v1

    invoke-direct {v0, v1}, Lokio/ByteString;-><init>([B)V

    return-object v0
.end method

.method private writeReplace()Ljava/lang/Object;
    .locals 1

    .prologue
    .line 296
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public asByteBuffer()Ljava/nio/ByteBuffer;
    .locals 1

    .prologue
    .line 178
    invoke-virtual {p0}, Lokio/SegmentedByteString;->toByteArray()[B

    move-result-object v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->asReadOnlyBuffer()Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0
.end method

.method public base64()Ljava/lang/String;
    .locals 1

    .prologue
    .line 98
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0}, Lokio/ByteString;->base64()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public base64Url()Ljava/lang/String;
    .locals 1

    .prologue
    .line 134
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0}, Lokio/ByteString;->base64Url()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 4
    .param p1, "o"    # Ljava/lang/Object;

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 265
    if-ne p1, p0, :cond_0

    .line 266
    .end local p1    # "o":Ljava/lang/Object;
    :goto_0
    return v1

    .restart local p1    # "o":Ljava/lang/Object;
    :cond_0
    instance-of v0, p1, Lokio/ByteString;

    if-eqz v0, :cond_1

    move-object v0, p1

    check-cast v0, Lokio/ByteString;

    .line 267
    invoke-virtual {v0}, Lokio/ByteString;->size()I

    move-result v0

    invoke-virtual {p0}, Lokio/SegmentedByteString;->size()I

    move-result v3

    if-ne v0, v3, :cond_1

    check-cast p1, Lokio/ByteString;

    .line 268
    .end local p1    # "o":Ljava/lang/Object;
    invoke-virtual {p0}, Lokio/SegmentedByteString;->size()I

    move-result v0

    invoke-virtual {p0, v2, p1, v2, v0}, Lokio/SegmentedByteString;->rangeEquals(ILokio/ByteString;II)Z

    move-result v0

    if-eqz v0, :cond_1

    move v0, v1

    :goto_1
    move v1, v0

    .line 266
    goto :goto_0

    :cond_1
    move v0, v2

    .line 268
    goto :goto_1
.end method

.method public getByte(I)B
    .locals 9
    .param p1, "pos"    # I

    .prologue
    .line 146
    iget-object v0, p0, Lokio/SegmentedByteString;->directory:[I

    iget-object v1, p0, Lokio/SegmentedByteString;->segments:[[B

    array-length v1, v1

    add-int/lit8 v1, v1, -0x1

    aget v0, v0, v1

    int-to-long v0, v0

    int-to-long v2, p1

    const-wide/16 v4, 0x1

    invoke-static/range {v0 .. v5}, Lokio/Util;->checkOffsetAndCount(JJJ)V

    .line 147
    invoke-direct {p0, p1}, Lokio/SegmentedByteString;->segment(I)I

    move-result v6

    .line 148
    .local v6, "segment":I
    if-nez v6, :cond_0

    const/4 v7, 0x0

    .line 149
    .local v7, "segmentOffset":I
    :goto_0
    iget-object v0, p0, Lokio/SegmentedByteString;->directory:[I

    iget-object v1, p0, Lokio/SegmentedByteString;->segments:[[B

    array-length v1, v1

    add-int/2addr v1, v6

    aget v8, v0, v1

    .line 150
    .local v8, "segmentPos":I
    iget-object v0, p0, Lokio/SegmentedByteString;->segments:[[B

    aget-object v0, v0, v6

    sub-int v1, p1, v7

    add-int/2addr v1, v8

    aget-byte v0, v0, v1

    return v0

    .line 148
    .end local v7    # "segmentOffset":I
    .end local v8    # "segmentPos":I
    :cond_0
    iget-object v0, p0, Lokio/SegmentedByteString;->directory:[I

    add-int/lit8 v1, v6, -0x1

    aget v7, v0, v1

    goto :goto_0
.end method

.method public hashCode()I
    .locals 13

    .prologue
    .line 272
    iget v3, p0, Lokio/SegmentedByteString;->hashCode:I

    .line 273
    .local v3, "result":I
    if-eqz v3, :cond_0

    move v4, v3

    .line 288
    .end local v3    # "result":I
    .local v4, "result":I
    :goto_0
    return v4

    .line 276
    .end local v4    # "result":I
    .restart local v3    # "result":I
    :cond_0
    const/4 v3, 0x1

    .line 277
    const/4 v8, 0x0

    .line 278
    .local v8, "segmentOffset":I
    const/4 v5, 0x0

    .local v5, "s":I
    iget-object v11, p0, Lokio/SegmentedByteString;->segments:[[B

    array-length v7, v11

    .local v7, "segmentCount":I
    :goto_1
    if-ge v5, v7, :cond_2

    .line 279
    iget-object v11, p0, Lokio/SegmentedByteString;->segments:[[B

    aget-object v6, v11, v5

    .line 280
    .local v6, "segment":[B
    iget-object v11, p0, Lokio/SegmentedByteString;->directory:[I

    add-int v12, v7, v5

    aget v9, v11, v12

    .line 281
    .local v9, "segmentPos":I
    iget-object v11, p0, Lokio/SegmentedByteString;->directory:[I

    aget v2, v11, v5

    .line 282
    .local v2, "nextSegmentOffset":I
    sub-int v10, v2, v8

    .line 283
    .local v10, "segmentSize":I
    move v0, v9

    .local v0, "i":I
    add-int v1, v9, v10

    .local v1, "limit":I
    :goto_2
    if-ge v0, v1, :cond_1

    .line 284
    mul-int/lit8 v11, v3, 0x1f

    aget-byte v12, v6, v0

    add-int v3, v11, v12

    .line 283
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 286
    :cond_1
    move v8, v2

    .line 278
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 288
    .end local v0    # "i":I
    .end local v1    # "limit":I
    .end local v2    # "nextSegmentOffset":I
    .end local v6    # "segment":[B
    .end local v9    # "segmentPos":I
    .end local v10    # "segmentSize":I
    :cond_2
    iput v3, p0, Lokio/SegmentedByteString;->hashCode:I

    move v4, v3

    .end local v3    # "result":I
    .restart local v4    # "result":I
    goto :goto_0
.end method

.method public hex()Ljava/lang/String;
    .locals 1

    .prologue
    .line 102
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0}, Lokio/ByteString;->hex()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public hmacSha1(Lokio/ByteString;)Lokio/ByteString;
    .locals 1
    .param p1, "key"    # Lokio/ByteString;

    .prologue
    .line 126
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0, p1}, Lokio/ByteString;->hmacSha1(Lokio/ByteString;)Lokio/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public hmacSha256(Lokio/ByteString;)Lokio/ByteString;
    .locals 1
    .param p1, "key"    # Lokio/ByteString;

    .prologue
    .line 130
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0, p1}, Lokio/ByteString;->hmacSha256(Lokio/ByteString;)Lokio/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public indexOf([BI)I
    .locals 1
    .param p1, "other"    # [B
    .param p2, "fromIndex"    # I

    .prologue
    .line 248
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lokio/ByteString;->indexOf([BI)I

    move-result v0

    return v0
.end method

.method internalArray()[B
    .locals 1

    .prologue
    .line 261
    invoke-virtual {p0}, Lokio/SegmentedByteString;->toByteArray()[B

    move-result-object v0

    return-object v0
.end method

.method public lastIndexOf([BI)I
    .locals 1
    .param p1, "other"    # [B
    .param p2, "fromIndex"    # I

    .prologue
    .line 252
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lokio/ByteString;->lastIndexOf([BI)I

    move-result v0

    return v0
.end method

.method public md5()Lokio/ByteString;
    .locals 1

    .prologue
    .line 114
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0}, Lokio/ByteString;->md5()Lokio/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public rangeEquals(ILokio/ByteString;II)Z
    .locals 9
    .param p1, "offset"    # I
    .param p2, "other"    # Lokio/ByteString;
    .param p3, "otherOffset"    # I
    .param p4, "byteCount"    # I

    .prologue
    const/4 v6, 0x0

    .line 211
    if-ltz p1, :cond_0

    invoke-virtual {p0}, Lokio/SegmentedByteString;->size()I

    move-result v7

    sub-int/2addr v7, p4

    if-le p1, v7, :cond_1

    .line 224
    :cond_0
    :goto_0
    return v6

    .line 213
    :cond_1
    invoke-direct {p0, p1}, Lokio/SegmentedByteString;->segment(I)I

    move-result v1

    .local v1, "s":I
    :goto_1
    if-lez p4, :cond_3

    .line 214
    if-nez v1, :cond_2

    move v2, v6

    .line 215
    .local v2, "segmentOffset":I
    :goto_2
    iget-object v7, p0, Lokio/SegmentedByteString;->directory:[I

    aget v7, v7, v1

    sub-int v4, v7, v2

    .line 216
    .local v4, "segmentSize":I
    add-int v7, v2, v4

    sub-int/2addr v7, p1

    invoke-static {p4, v7}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 217
    .local v5, "stepSize":I
    iget-object v7, p0, Lokio/SegmentedByteString;->directory:[I

    iget-object v8, p0, Lokio/SegmentedByteString;->segments:[[B

    array-length v8, v8

    add-int/2addr v8, v1

    aget v3, v7, v8

    .line 218
    .local v3, "segmentPos":I
    sub-int v7, p1, v2

    add-int v0, v7, v3

    .line 219
    .local v0, "arrayOffset":I
    iget-object v7, p0, Lokio/SegmentedByteString;->segments:[[B

    aget-object v7, v7, v1

    invoke-virtual {p2, p3, v7, v0, v5}, Lokio/ByteString;->rangeEquals(I[BII)Z

    move-result v7

    if-eqz v7, :cond_0

    .line 220
    add-int/2addr p1, v5

    .line 221
    add-int/2addr p3, v5

    .line 222
    sub-int/2addr p4, v5

    .line 213
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 214
    .end local v0    # "arrayOffset":I
    .end local v2    # "segmentOffset":I
    .end local v3    # "segmentPos":I
    .end local v4    # "segmentSize":I
    .end local v5    # "stepSize":I
    :cond_2
    iget-object v7, p0, Lokio/SegmentedByteString;->directory:[I

    add-int/lit8 v8, v1, -0x1

    aget v2, v7, v8

    goto :goto_2

    .line 224
    :cond_3
    const/4 v6, 0x1

    goto :goto_0
.end method

.method public rangeEquals(I[BII)Z
    .locals 9
    .param p1, "offset"    # I
    .param p2, "other"    # [B
    .param p3, "otherOffset"    # I
    .param p4, "byteCount"    # I

    .prologue
    const/4 v6, 0x0

    .line 228
    if-ltz p1, :cond_0

    invoke-virtual {p0}, Lokio/SegmentedByteString;->size()I

    move-result v7

    sub-int/2addr v7, p4

    if-gt p1, v7, :cond_0

    if-ltz p3, :cond_0

    array-length v7, p2

    sub-int/2addr v7, p4

    if-le p3, v7, :cond_1

    .line 244
    :cond_0
    :goto_0
    return v6

    .line 233
    :cond_1
    invoke-direct {p0, p1}, Lokio/SegmentedByteString;->segment(I)I

    move-result v1

    .local v1, "s":I
    :goto_1
    if-lez p4, :cond_3

    .line 234
    if-nez v1, :cond_2

    move v2, v6

    .line 235
    .local v2, "segmentOffset":I
    :goto_2
    iget-object v7, p0, Lokio/SegmentedByteString;->directory:[I

    aget v7, v7, v1

    sub-int v4, v7, v2

    .line 236
    .local v4, "segmentSize":I
    add-int v7, v2, v4

    sub-int/2addr v7, p1

    invoke-static {p4, v7}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 237
    .local v5, "stepSize":I
    iget-object v7, p0, Lokio/SegmentedByteString;->directory:[I

    iget-object v8, p0, Lokio/SegmentedByteString;->segments:[[B

    array-length v8, v8

    add-int/2addr v8, v1

    aget v3, v7, v8

    .line 238
    .local v3, "segmentPos":I
    sub-int v7, p1, v2

    add-int v0, v7, v3

    .line 239
    .local v0, "arrayOffset":I
    iget-object v7, p0, Lokio/SegmentedByteString;->segments:[[B

    aget-object v7, v7, v1

    invoke-static {v7, v0, p2, p3, v5}, Lokio/Util;->arrayRangeEquals([BI[BII)Z

    move-result v7

    if-eqz v7, :cond_0

    .line 240
    add-int/2addr p1, v5

    .line 241
    add-int/2addr p3, v5

    .line 242
    sub-int/2addr p4, v5

    .line 233
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 234
    .end local v0    # "arrayOffset":I
    .end local v2    # "segmentOffset":I
    .end local v3    # "segmentPos":I
    .end local v4    # "segmentSize":I
    .end local v5    # "stepSize":I
    :cond_2
    iget-object v7, p0, Lokio/SegmentedByteString;->directory:[I

    add-int/lit8 v8, v1, -0x1

    aget v2, v7, v8

    goto :goto_2

    .line 244
    :cond_3
    const/4 v6, 0x1

    goto :goto_0
.end method

.method public sha1()Lokio/ByteString;
    .locals 1

    .prologue
    .line 118
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0}, Lokio/ByteString;->sha1()Lokio/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public sha256()Lokio/ByteString;
    .locals 1

    .prologue
    .line 122
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0}, Lokio/ByteString;->sha256()Lokio/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public size()I
    .locals 2

    .prologue
    .line 161
    iget-object v0, p0, Lokio/SegmentedByteString;->directory:[I

    iget-object v1, p0, Lokio/SegmentedByteString;->segments:[[B

    array-length v1, v1

    add-int/lit8 v1, v1, -0x1

    aget v0, v0, v1

    return v0
.end method

.method public string(Ljava/nio/charset/Charset;)Ljava/lang/String;
    .locals 1
    .param p1, "charset"    # Ljava/nio/charset/Charset;

    .prologue
    .line 94
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0, p1}, Lokio/ByteString;->string(Ljava/nio/charset/Charset;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public substring(I)Lokio/ByteString;
    .locals 1
    .param p1, "beginIndex"    # I

    .prologue
    .line 138
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0, p1}, Lokio/ByteString;->substring(I)Lokio/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public substring(II)Lokio/ByteString;
    .locals 1
    .param p1, "beginIndex"    # I
    .param p2, "endIndex"    # I

    .prologue
    .line 142
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lokio/ByteString;->substring(II)Lokio/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public toAsciiLowercase()Lokio/ByteString;
    .locals 1

    .prologue
    .line 106
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0}, Lokio/ByteString;->toAsciiLowercase()Lokio/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public toAsciiUppercase()Lokio/ByteString;
    .locals 1

    .prologue
    .line 110
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0}, Lokio/ByteString;->toAsciiUppercase()Lokio/ByteString;

    move-result-object v0

    return-object v0
.end method

.method public toByteArray()[B
    .locals 8

    .prologue
    .line 165
    iget-object v6, p0, Lokio/SegmentedByteString;->directory:[I

    iget-object v7, p0, Lokio/SegmentedByteString;->segments:[[B

    array-length v7, v7

    add-int/lit8 v7, v7, -0x1

    aget v6, v6, v7

    new-array v1, v6, [B

    .line 166
    .local v1, "result":[B
    const/4 v4, 0x0

    .line 167
    .local v4, "segmentOffset":I
    const/4 v2, 0x0

    .local v2, "s":I
    iget-object v6, p0, Lokio/SegmentedByteString;->segments:[[B

    array-length v3, v6

    .local v3, "segmentCount":I
    :goto_0
    if-ge v2, v3, :cond_0

    .line 168
    iget-object v6, p0, Lokio/SegmentedByteString;->directory:[I

    add-int v7, v3, v2

    aget v5, v6, v7

    .line 169
    .local v5, "segmentPos":I
    iget-object v6, p0, Lokio/SegmentedByteString;->directory:[I

    aget v0, v6, v2

    .line 170
    .local v0, "nextSegmentOffset":I
    iget-object v6, p0, Lokio/SegmentedByteString;->segments:[[B

    aget-object v6, v6, v2

    sub-int v7, v0, v4

    invoke-static {v6, v5, v1, v4, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 172
    move v4, v0

    .line 167
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 174
    .end local v0    # "nextSegmentOffset":I
    .end local v5    # "segmentPos":I
    :cond_0
    return-object v1
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 292
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0}, Lokio/ByteString;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public utf8()Ljava/lang/String;
    .locals 1

    .prologue
    .line 90
    invoke-direct {p0}, Lokio/SegmentedByteString;->toByteString()Lokio/ByteString;

    move-result-object v0

    invoke-virtual {v0}, Lokio/ByteString;->utf8()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public write(Ljava/io/OutputStream;)V
    .locals 7
    .param p1, "out"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 182
    if-nez p1, :cond_0

    new-instance v5, Ljava/lang/IllegalArgumentException;

    const-string v6, "out == null"

    invoke-direct {v5, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 183
    :cond_0
    const/4 v3, 0x0

    .line 184
    .local v3, "segmentOffset":I
    const/4 v1, 0x0

    .local v1, "s":I
    iget-object v5, p0, Lokio/SegmentedByteString;->segments:[[B

    array-length v2, v5

    .local v2, "segmentCount":I
    :goto_0
    if-ge v1, v2, :cond_1

    .line 185
    iget-object v5, p0, Lokio/SegmentedByteString;->directory:[I

    add-int v6, v2, v1

    aget v4, v5, v6

    .line 186
    .local v4, "segmentPos":I
    iget-object v5, p0, Lokio/SegmentedByteString;->directory:[I

    aget v0, v5, v1

    .line 187
    .local v0, "nextSegmentOffset":I
    iget-object v5, p0, Lokio/SegmentedByteString;->segments:[[B

    aget-object v5, v5, v1

    sub-int v6, v0, v3

    invoke-virtual {p1, v5, v4, v6}, Ljava/io/OutputStream;->write([BII)V

    .line 188
    move v3, v0

    .line 184
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 190
    .end local v0    # "nextSegmentOffset":I
    .end local v4    # "segmentPos":I
    :cond_1
    return-void
.end method

.method write(Lokio/Buffer;)V
    .locals 10
    .param p1, "buffer"    # Lokio/Buffer;

    .prologue
    .line 193
    const/4 v4, 0x0

    .line 194
    .local v4, "segmentOffset":I
    const/4 v1, 0x0

    .local v1, "s":I
    iget-object v6, p0, Lokio/SegmentedByteString;->segments:[[B

    array-length v3, v6

    .local v3, "segmentCount":I
    :goto_0
    if-ge v1, v3, :cond_1

    .line 195
    iget-object v6, p0, Lokio/SegmentedByteString;->directory:[I

    add-int v7, v3, v1

    aget v5, v6, v7

    .line 196
    .local v5, "segmentPos":I
    iget-object v6, p0, Lokio/SegmentedByteString;->directory:[I

    aget v0, v6, v1

    .line 197
    .local v0, "nextSegmentOffset":I
    new-instance v2, Lokio/Segment;

    iget-object v6, p0, Lokio/SegmentedByteString;->segments:[[B

    aget-object v6, v6, v1

    add-int v7, v5, v0

    sub-int/2addr v7, v4

    invoke-direct {v2, v6, v5, v7}, Lokio/Segment;-><init>([BII)V

    .line 199
    .local v2, "segment":Lokio/Segment;
    iget-object v6, p1, Lokio/Buffer;->head:Lokio/Segment;

    if-nez v6, :cond_0

    .line 200
    iput-object v2, v2, Lokio/Segment;->prev:Lokio/Segment;

    iput-object v2, v2, Lokio/Segment;->next:Lokio/Segment;

    iput-object v2, p1, Lokio/Buffer;->head:Lokio/Segment;

    .line 204
    :goto_1
    move v4, v0

    .line 194
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 202
    :cond_0
    iget-object v6, p1, Lokio/Buffer;->head:Lokio/Segment;

    iget-object v6, v6, Lokio/Segment;->prev:Lokio/Segment;

    invoke-virtual {v6, v2}, Lokio/Segment;->push(Lokio/Segment;)Lokio/Segment;

    goto :goto_1

    .line 206
    .end local v0    # "nextSegmentOffset":I
    .end local v2    # "segment":Lokio/Segment;
    .end local v5    # "segmentPos":I
    :cond_1
    iget-wide v6, p1, Lokio/Buffer;->size:J

    int-to-long v8, v4

    add-long/2addr v6, v8

    iput-wide v6, p1, Lokio/Buffer;->size:J

    .line 207
    return-void
.end method
