.class final Lio/socket/engineio/parser/Parser$2;
.super Ljava/lang/Object;
.source "Parser.java"

# interfaces
.implements Lio/socket/engineio/parser/Parser$EncodeCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/parser/Parser;->encodePayload([Lio/socket/engineio/parser/Packet;Lio/socket/engineio/parser/Parser$EncodeCallback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$results:Ljava/util/ArrayList;


# direct methods
.method constructor <init>(Ljava/util/ArrayList;)V
    .locals 0

    .prologue
    .line 121
    iput-object p1, p0, Lio/socket/engineio/parser/Parser$2;->val$results:Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public call(Ljava/lang/Object;)V
    .locals 9
    .param p1, "packet"    # Ljava/lang/Object;

    .prologue
    const/4 v8, 0x2

    const/4 v7, -0x1

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 124
    instance-of v3, p1, Ljava/lang/String;

    if-eqz v3, :cond_1

    move-object v3, p1

    .line 125
    check-cast v3, Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    .line 126
    .local v0, "encodingLength":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, 0x2

    new-array v2, v3, [B

    .line 128
    .local v2, "sizeBuffer":[B
    aput-byte v5, v2, v5

    .line 129
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v1, v3, :cond_0

    .line 130
    add-int/lit8 v3, v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljava/lang/Character;->getNumericValue(C)I

    move-result v4

    int-to-byte v4, v4

    aput-byte v4, v2, v3

    .line 129
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 132
    :cond_0
    array-length v3, v2

    add-int/lit8 v3, v3, -0x1

    aput-byte v7, v2, v3

    .line 133
    iget-object v3, p0, Lio/socket/engineio/parser/Parser$2;->val$results:Ljava/util/ArrayList;

    new-array v4, v8, [[B

    aput-object v2, v4, v5

    check-cast p1, Ljava/lang/String;

    .end local p1    # "packet":Ljava/lang/Object;
    # invokes: Lio/socket/engineio/parser/Parser;->stringToByteArray(Ljava/lang/String;)[B
    invoke-static {p1}, Lio/socket/engineio/parser/Parser;->access$000(Ljava/lang/String;)[B

    move-result-object v5

    aput-object v5, v4, v6

    invoke-static {v4}, Lio/socket/engineio/parser/Buffer;->concat([[B)[B

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 145
    :goto_1
    return-void

    .end local v0    # "encodingLength":Ljava/lang/String;
    .end local v1    # "i":I
    .end local v2    # "sizeBuffer":[B
    .restart local p1    # "packet":Ljava/lang/Object;
    :cond_1
    move-object v3, p1

    .line 137
    check-cast v3, [B

    check-cast v3, [B

    array-length v3, v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    .line 138
    .restart local v0    # "encodingLength":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, 0x2

    new-array v2, v3, [B

    .line 139
    .restart local v2    # "sizeBuffer":[B
    aput-byte v6, v2, v5

    .line 140
    const/4 v1, 0x0

    .restart local v1    # "i":I
    :goto_2
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v1, v3, :cond_2

    .line 141
    add-int/lit8 v3, v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljava/lang/Character;->getNumericValue(C)I

    move-result v4

    int-to-byte v4, v4

    aput-byte v4, v2, v3

    .line 140
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 143
    :cond_2
    array-length v3, v2

    add-int/lit8 v3, v3, -0x1

    aput-byte v7, v2, v3

    .line 144
    iget-object v3, p0, Lio/socket/engineio/parser/Parser$2;->val$results:Ljava/util/ArrayList;

    new-array v4, v8, [[B

    aput-object v2, v4, v5

    check-cast p1, [B

    .end local p1    # "packet":Ljava/lang/Object;
    check-cast p1, [B

    aput-object p1, v4, v6

    invoke-static {v4}, Lio/socket/engineio/parser/Buffer;->concat([[B)[B

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1
.end method
