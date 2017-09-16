.class public Lio/socket/parser/Parser$Encoder;
.super Ljava/lang/Object;
.source "Parser.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/parser/Parser;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Encoder"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/socket/parser/Parser$Encoder$Callback;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private encodeAsBinary(Lio/socket/parser/Packet;Lio/socket/parser/Parser$Encoder$Callback;)V
    .locals 4
    .param p1, "obj"    # Lio/socket/parser/Packet;
    .param p2, "callback"    # Lio/socket/parser/Parser$Encoder$Callback;

    .prologue
    .line 124
    invoke-static {p1}, Lio/socket/parser/Binary;->deconstructPacket(Lio/socket/parser/Packet;)Lio/socket/parser/Binary$DeconstructedPacket;

    move-result-object v1

    .line 125
    .local v1, "deconstruction":Lio/socket/parser/Binary$DeconstructedPacket;
    iget-object v3, v1, Lio/socket/parser/Binary$DeconstructedPacket;->packet:Lio/socket/parser/Packet;

    invoke-direct {p0, v3}, Lio/socket/parser/Parser$Encoder;->encodeAsString(Lio/socket/parser/Packet;)Ljava/lang/String;

    move-result-object v2

    .line 126
    .local v2, "pack":Ljava/lang/String;
    new-instance v0, Ljava/util/ArrayList;

    iget-object v3, v1, Lio/socket/parser/Binary$DeconstructedPacket;->buffers:[[B

    invoke-static {v3}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    invoke-direct {v0, v3}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 128
    .local v0, "buffers":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Object;>;"
    const/4 v3, 0x0

    invoke-interface {v0, v3, v2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 129
    invoke-interface {v0}, Ljava/util/List;->toArray()[Ljava/lang/Object;

    move-result-object v3

    invoke-interface {p2, v3}, Lio/socket/parser/Parser$Encoder$Callback;->call([Ljava/lang/Object;)V

    .line 130
    return-void
.end method

.method private encodeAsString(Lio/socket/parser/Packet;)Ljava/lang/String;
    .locals 6
    .param p1, "obj"    # Lio/socket/parser/Packet;

    .prologue
    .line 91
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 92
    .local v1, "str":Ljava/lang/StringBuilder;
    const/4 v0, 0x0

    .line 94
    .local v0, "nsp":Z
    iget v2, p1, Lio/socket/parser/Packet;->type:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 96
    const/4 v2, 0x5

    iget v3, p1, Lio/socket/parser/Packet;->type:I

    if-eq v2, v3, :cond_0

    const/4 v2, 0x6

    iget v3, p1, Lio/socket/parser/Packet;->type:I

    if-ne v2, v3, :cond_1

    .line 97
    :cond_0
    iget v2, p1, Lio/socket/parser/Packet;->attachments:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 98
    const-string v2, "-"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 101
    :cond_1
    iget-object v2, p1, Lio/socket/parser/Packet;->nsp:Ljava/lang/String;

    if-eqz v2, :cond_2

    iget-object v2, p1, Lio/socket/parser/Packet;->nsp:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_2

    const-string v2, "/"

    iget-object v3, p1, Lio/socket/parser/Packet;->nsp:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 102
    const/4 v0, 0x1

    .line 103
    iget-object v2, p1, Lio/socket/parser/Packet;->nsp:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 106
    :cond_2
    iget v2, p1, Lio/socket/parser/Packet;->id:I

    if-ltz v2, :cond_4

    .line 107
    if-eqz v0, :cond_3

    .line 108
    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 109
    const/4 v0, 0x0

    .line 111
    :cond_3
    iget v2, p1, Lio/socket/parser/Packet;->id:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 114
    :cond_4
    iget-object v2, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    if-eqz v2, :cond_6

    .line 115
    if-eqz v0, :cond_5

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 116
    :cond_5
    iget-object v2, p1, Lio/socket/parser/Packet;->data:Ljava/lang/Object;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 119
    :cond_6
    # getter for: Lio/socket/parser/Parser;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/parser/Parser;->access$000()Ljava/util/logging/Logger;

    move-result-object v2

    const-string v3, "encoded %s as %s"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object p1, v4, v5

    const/4 v5, 0x1

    aput-object v1, v4, v5

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 120
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method


# virtual methods
.method public encode(Lio/socket/parser/Packet;Lio/socket/parser/Parser$Encoder$Callback;)V
    .locals 6
    .param p1, "obj"    # Lio/socket/parser/Packet;
    .param p2, "callback"    # Lio/socket/parser/Parser$Encoder$Callback;

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 80
    # getter for: Lio/socket/parser/Parser;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/parser/Parser;->access$000()Ljava/util/logging/Logger;

    move-result-object v1

    const-string v2, "encoding packet %s"

    new-array v3, v5, [Ljava/lang/Object;

    aput-object p1, v3, v4

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    .line 82
    const/4 v1, 0x5

    iget v2, p1, Lio/socket/parser/Packet;->type:I

    if-eq v1, v2, :cond_0

    const/4 v1, 0x6

    iget v2, p1, Lio/socket/parser/Packet;->type:I

    if-ne v1, v2, :cond_1

    .line 83
    :cond_0
    invoke-direct {p0, p1, p2}, Lio/socket/parser/Parser$Encoder;->encodeAsBinary(Lio/socket/parser/Packet;Lio/socket/parser/Parser$Encoder$Callback;)V

    .line 88
    :goto_0
    return-void

    .line 85
    :cond_1
    invoke-direct {p0, p1}, Lio/socket/parser/Parser$Encoder;->encodeAsString(Lio/socket/parser/Packet;)Ljava/lang/String;

    move-result-object v0

    .line 86
    .local v0, "encoding":Ljava/lang/String;
    new-array v1, v5, [Ljava/lang/String;

    aput-object v0, v1, v4

    invoke-interface {p2, v1}, Lio/socket/parser/Parser$Encoder$Callback;->call([Ljava/lang/Object;)V

    goto :goto_0
.end method
