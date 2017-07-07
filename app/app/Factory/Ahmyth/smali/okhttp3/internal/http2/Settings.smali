.class public final Lokhttp3/internal/http2/Settings;
.super Ljava/lang/Object;
.source "Settings.java"


# static fields
.field static final COUNT:I = 0xa

.field static final DEFAULT_INITIAL_WINDOW_SIZE:I = 0xffff

.field static final ENABLE_PUSH:I = 0x2

.field static final HEADER_TABLE_SIZE:I = 0x1

.field static final INITIAL_WINDOW_SIZE:I = 0x7

.field static final MAX_CONCURRENT_STREAMS:I = 0x4

.field static final MAX_FRAME_SIZE:I = 0x5

.field static final MAX_HEADER_LIST_SIZE:I = 0x6


# instance fields
.field private set:I

.field private final values:[I


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 51
    const/16 v0, 0xa

    new-array v0, v0, [I

    iput-object v0, p0, Lokhttp3/internal/http2/Settings;->values:[I

    return-void
.end method


# virtual methods
.method clear()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 54
    iput v1, p0, Lokhttp3/internal/http2/Settings;->set:I

    .line 55
    iget-object v0, p0, Lokhttp3/internal/http2/Settings;->values:[I

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 56
    return-void
.end method

.method get(I)I
    .locals 1
    .param p1, "id"    # I

    .prologue
    .line 77
    iget-object v0, p0, Lokhttp3/internal/http2/Settings;->values:[I

    aget v0, v0, p1

    return v0
.end method

.method getEnablePush(Z)Z
    .locals 5
    .param p1, "defaultValue"    # Z

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 93
    const/4 v0, 0x4

    .line 94
    .local v0, "bit":I
    iget v3, p0, Lokhttp3/internal/http2/Settings;->set:I

    and-int/2addr v3, v0

    if-eqz v3, :cond_0

    iget-object v3, p0, Lokhttp3/internal/http2/Settings;->values:[I

    const/4 v4, 0x2

    aget v3, v3, v4

    :goto_0
    if-ne v3, v1, :cond_2

    :goto_1
    return v1

    :cond_0
    if-eqz p1, :cond_1

    move v3, v1

    goto :goto_0

    :cond_1
    move v3, v2

    goto :goto_0

    :cond_2
    move v1, v2

    goto :goto_1
.end method

.method getHeaderTableSize()I
    .locals 3

    .prologue
    .line 87
    const/4 v0, 0x2

    .line 88
    .local v0, "bit":I
    iget v1, p0, Lokhttp3/internal/http2/Settings;->set:I

    and-int/2addr v1, v0

    if-eqz v1, :cond_0

    iget-object v1, p0, Lokhttp3/internal/http2/Settings;->values:[I

    const/4 v2, 0x1

    aget v1, v1, v2

    :goto_0
    return v1

    :cond_0
    const/4 v1, -0x1

    goto :goto_0
.end method

.method getInitialWindowSize()I
    .locals 3

    .prologue
    .line 114
    const/16 v0, 0x80

    .line 115
    .local v0, "bit":I
    iget v1, p0, Lokhttp3/internal/http2/Settings;->set:I

    and-int/2addr v1, v0

    if-eqz v1, :cond_0

    iget-object v1, p0, Lokhttp3/internal/http2/Settings;->values:[I

    const/4 v2, 0x7

    aget v1, v1, v2

    :goto_0
    return v1

    :cond_0
    const v1, 0xffff

    goto :goto_0
.end method

.method getMaxConcurrentStreams(I)I
    .locals 3
    .param p1, "defaultValue"    # I

    .prologue
    .line 99
    const/16 v0, 0x10

    .line 100
    .local v0, "bit":I
    iget v1, p0, Lokhttp3/internal/http2/Settings;->set:I

    and-int/2addr v1, v0

    if-eqz v1, :cond_0

    iget-object v1, p0, Lokhttp3/internal/http2/Settings;->values:[I

    const/4 v2, 0x4

    aget p1, v1, v2

    .end local p1    # "defaultValue":I
    :cond_0
    return p1
.end method

.method getMaxFrameSize(I)I
    .locals 3
    .param p1, "defaultValue"    # I

    .prologue
    .line 104
    const/16 v0, 0x20

    .line 105
    .local v0, "bit":I
    iget v1, p0, Lokhttp3/internal/http2/Settings;->set:I

    and-int/2addr v1, v0

    if-eqz v1, :cond_0

    iget-object v1, p0, Lokhttp3/internal/http2/Settings;->values:[I

    const/4 v2, 0x5

    aget p1, v1, v2

    .end local p1    # "defaultValue":I
    :cond_0
    return p1
.end method

.method getMaxHeaderListSize(I)I
    .locals 3
    .param p1, "defaultValue"    # I

    .prologue
    .line 109
    const/16 v0, 0x40

    .line 110
    .local v0, "bit":I
    iget v1, p0, Lokhttp3/internal/http2/Settings;->set:I

    and-int/2addr v1, v0

    if-eqz v1, :cond_0

    iget-object v1, p0, Lokhttp3/internal/http2/Settings;->values:[I

    const/4 v2, 0x6

    aget p1, v1, v2

    .end local p1    # "defaultValue":I
    :cond_0
    return p1
.end method

.method isSet(I)Z
    .locals 3
    .param p1, "id"    # I

    .prologue
    const/4 v1, 0x1

    .line 71
    shl-int v0, v1, p1

    .line 72
    .local v0, "bit":I
    iget v2, p0, Lokhttp3/internal/http2/Settings;->set:I

    and-int/2addr v2, v0

    if-eqz v2, :cond_0

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method merge(Lokhttp3/internal/http2/Settings;)V
    .locals 2
    .param p1, "other"    # Lokhttp3/internal/http2/Settings;

    .prologue
    .line 123
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/16 v1, 0xa

    if-ge v0, v1, :cond_1

    .line 124
    invoke-virtual {p1, v0}, Lokhttp3/internal/http2/Settings;->isSet(I)Z

    move-result v1

    if-nez v1, :cond_0

    .line 123
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 125
    :cond_0
    invoke-virtual {p1, v0}, Lokhttp3/internal/http2/Settings;->get(I)I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lokhttp3/internal/http2/Settings;->set(II)Lokhttp3/internal/http2/Settings;

    goto :goto_1

    .line 127
    :cond_1
    return-void
.end method

.method set(II)Lokhttp3/internal/http2/Settings;
    .locals 2
    .param p1, "id"    # I
    .param p2, "value"    # I

    .prologue
    .line 59
    iget-object v1, p0, Lokhttp3/internal/http2/Settings;->values:[I

    array-length v1, v1

    if-lt p1, v1, :cond_0

    .line 66
    :goto_0
    return-object p0

    .line 63
    :cond_0
    const/4 v1, 0x1

    shl-int v0, v1, p1

    .line 64
    .local v0, "bit":I
    iget v1, p0, Lokhttp3/internal/http2/Settings;->set:I

    or-int/2addr v1, v0

    iput v1, p0, Lokhttp3/internal/http2/Settings;->set:I

    .line 65
    iget-object v1, p0, Lokhttp3/internal/http2/Settings;->values:[I

    aput p2, v1, p1

    goto :goto_0
.end method

.method size()I
    .locals 1

    .prologue
    .line 82
    iget v0, p0, Lokhttp3/internal/http2/Settings;->set:I

    invoke-static {v0}, Ljava/lang/Integer;->bitCount(I)I

    move-result v0

    return v0
.end method
