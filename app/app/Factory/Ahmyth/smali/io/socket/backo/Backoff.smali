.class public Lio/socket/backo/Backoff;
.super Ljava/lang/Object;
.source "Backoff.java"


# instance fields
.field private attempts:I

.field private factor:I

.field private jitter:D

.field private max:J

.field private ms:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 8
    const-wide/16 v0, 0x64

    iput-wide v0, p0, Lio/socket/backo/Backoff;->ms:J

    .line 9
    const-wide/16 v0, 0x2710

    iput-wide v0, p0, Lio/socket/backo/Backoff;->max:J

    .line 10
    const/4 v0, 0x2

    iput v0, p0, Lio/socket/backo/Backoff;->factor:I

    .line 14
    return-void
.end method


# virtual methods
.method public duration()J
    .locals 8

    .prologue
    .line 17
    iget-wide v4, p0, Lio/socket/backo/Backoff;->ms:J

    invoke-static {v4, v5}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v4

    iget v5, p0, Lio/socket/backo/Backoff;->factor:I

    int-to-long v6, v5

    .line 18
    invoke-static {v6, v7}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v5

    iget v6, p0, Lio/socket/backo/Backoff;->attempts:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lio/socket/backo/Backoff;->attempts:I

    invoke-virtual {v5, v6}, Ljava/math/BigInteger;->pow(I)Ljava/math/BigInteger;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/math/BigInteger;->multiply(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    move-result-object v1

    .line 19
    .local v1, "ms":Ljava/math/BigInteger;
    iget-wide v4, p0, Lio/socket/backo/Backoff;->jitter:D

    const-wide/16 v6, 0x0

    cmpl-double v4, v4, v6

    if-eqz v4, :cond_0

    .line 20
    invoke-static {}, Ljava/lang/Math;->random()D

    move-result-wide v2

    .line 21
    .local v2, "rand":D
    invoke-static {v2, v3}, Ljava/math/BigDecimal;->valueOf(D)Ljava/math/BigDecimal;

    move-result-object v4

    iget-wide v6, p0, Lio/socket/backo/Backoff;->jitter:D

    .line 22
    invoke-static {v6, v7}, Ljava/math/BigDecimal;->valueOf(D)Ljava/math/BigDecimal;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/math/BigDecimal;->multiply(Ljava/math/BigDecimal;)Ljava/math/BigDecimal;

    move-result-object v4

    new-instance v5, Ljava/math/BigDecimal;

    invoke-direct {v5, v1}, Ljava/math/BigDecimal;-><init>(Ljava/math/BigInteger;)V

    .line 23
    invoke-virtual {v4, v5}, Ljava/math/BigDecimal;->multiply(Ljava/math/BigDecimal;)Ljava/math/BigDecimal;

    move-result-object v4

    invoke-virtual {v4}, Ljava/math/BigDecimal;->toBigInteger()Ljava/math/BigInteger;

    move-result-object v0

    .line 24
    .local v0, "deviation":Ljava/math/BigInteger;
    const-wide/high16 v4, 0x4024000000000000L    # 10.0

    mul-double/2addr v4, v2

    invoke-static {v4, v5}, Ljava/lang/Math;->floor(D)D

    move-result-wide v4

    double-to-int v4, v4

    and-int/lit8 v4, v4, 0x1

    if-nez v4, :cond_1

    invoke-virtual {v1, v0}, Ljava/math/BigInteger;->subtract(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    move-result-object v1

    .line 26
    .end local v0    # "deviation":Ljava/math/BigInteger;
    .end local v2    # "rand":D
    :cond_0
    :goto_0
    iget-wide v4, p0, Lio/socket/backo/Backoff;->max:J

    invoke-static {v4, v5}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/math/BigInteger;->min(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    move-result-object v4

    invoke-virtual {v4}, Ljava/math/BigInteger;->longValue()J

    move-result-wide v4

    return-wide v4

    .line 24
    .restart local v0    # "deviation":Ljava/math/BigInteger;
    .restart local v2    # "rand":D
    :cond_1
    invoke-virtual {v1, v0}, Ljava/math/BigInteger;->add(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    move-result-object v1

    goto :goto_0
.end method

.method public getAttempts()I
    .locals 1

    .prologue
    .line 54
    iget v0, p0, Lio/socket/backo/Backoff;->attempts:I

    return v0
.end method

.method public reset()V
    .locals 1

    .prologue
    .line 30
    const/4 v0, 0x0

    iput v0, p0, Lio/socket/backo/Backoff;->attempts:I

    .line 31
    return-void
.end method

.method public setFactor(I)Lio/socket/backo/Backoff;
    .locals 0
    .param p1, "factor"    # I

    .prologue
    .line 44
    iput p1, p0, Lio/socket/backo/Backoff;->factor:I

    .line 45
    return-object p0
.end method

.method public setJitter(D)Lio/socket/backo/Backoff;
    .locals 1
    .param p1, "jitter"    # D

    .prologue
    .line 49
    iput-wide p1, p0, Lio/socket/backo/Backoff;->jitter:D

    .line 50
    return-object p0
.end method

.method public setMax(J)Lio/socket/backo/Backoff;
    .locals 1
    .param p1, "max"    # J

    .prologue
    .line 39
    iput-wide p1, p0, Lio/socket/backo/Backoff;->max:J

    .line 40
    return-object p0
.end method

.method public setMin(J)Lio/socket/backo/Backoff;
    .locals 1
    .param p1, "min"    # J

    .prologue
    .line 34
    iput-wide p1, p0, Lio/socket/backo/Backoff;->ms:J

    .line 35
    return-object p0
.end method
