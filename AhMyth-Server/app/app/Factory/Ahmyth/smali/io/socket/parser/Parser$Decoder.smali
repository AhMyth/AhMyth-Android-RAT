.class public Lio/socket/parser/Parser$Decoder;
.super Lio/socket/emitter/Emitter;
.source "Parser.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/parser/Parser;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Decoder"
.end annotation


# static fields
.field public static EVENT_DECODED:Ljava/lang/String;


# instance fields
.field reconstructor:Lio/socket/parser/Parser$BinaryReconstructor;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 140
    const-string v0, "decoded"

    sput-object v0, Lio/socket/parser/Parser$Decoder;->EVENT_DECODED:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 144
    invoke-direct {p0}, Lio/socket/emitter/Emitter;-><init>()V

    .line 145
    const/4 v0, 0x0

    iput-object v0, p0, Lio/socket/parser/Parser$Decoder;->reconstructor:Lio/socket/parser/Parser$BinaryReconstructor;

    .line 146
    return-void
.end method

.method private static decodeString(Ljava/lang/String;)Lio/socket/parser/Packet;
    .locals 14
    .param p0, "str"    # Ljava/lang/String;

    .prologue
    const/4 v13, 0x1

    const/4 v12, 0x0

    .line 174
    new-instance v8, Lio/socket/parser/Packet;

    invoke-direct {v8}, Lio/socket/parser/Packet;-><init>()V

    .line 175
    .local v8, "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Ljava/lang/Object;>;"
    const/4 v3, 0x0

    .line 176
    .local v3, "i":I
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v5

    .line 178
    .local v5, "length":I
    invoke-virtual {p0, v12}, Ljava/lang/String;->charAt(I)C

    move-result v9

    invoke-static {v9}, Ljava/lang/Character;->getNumericValue(C)I

    move-result v9

    iput v9, v8, Lio/socket/parser/Packet;->type:I

    .line 179
    iget v9, v8, Lio/socket/parser/Packet;->type:I

    if-ltz v9, :cond_0

    iget v9, v8, Lio/socket/parser/Packet;->type:I

    sget-object v10, Lio/socket/parser/Parser;->types:[Ljava/lang/String;

    array-length v10, v10

    add-int/lit8 v10, v10, -0x1

    if-le v9, v10, :cond_1

    :cond_0
    # invokes: Lio/socket/parser/Parser;->error()Lio/socket/parser/Packet;
    invoke-static {}, Lio/socket/parser/Parser;->access$100()Lio/socket/parser/Packet;

    move-result-object v8

    .line 237
    .end local v8    # "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Ljava/lang/Object;>;"
    :goto_0
    return-object v8

    .line 181
    .restart local v8    # "p":Lio/socket/parser/Packet;, "Lio/socket/parser/Packet<Ljava/lang/Object;>;"
    :cond_1
    const/4 v9, 0x5

    iget v10, v8, Lio/socket/parser/Packet;->type:I

    if-eq v9, v10, :cond_2

    const/4 v9, 0x6

    iget v10, v8, Lio/socket/parser/Packet;->type:I

    if-ne v9, v10, :cond_6

    .line 182
    :cond_2
    const-string v9, "-"

    invoke-virtual {p0, v9}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_3

    if-gt v5, v13, :cond_4

    :cond_3
    # invokes: Lio/socket/parser/Parser;->error()Lio/socket/parser/Packet;
    invoke-static {}, Lio/socket/parser/Parser;->access$100()Lio/socket/parser/Packet;

    move-result-object v8

    goto :goto_0

    .line 183
    :cond_4
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 184
    .local v0, "attachments":Ljava/lang/StringBuilder;
    :goto_1
    add-int/lit8 v3, v3, 0x1

    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v9

    const/16 v10, 0x2d

    if-eq v9, v10, :cond_5

    .line 185
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v9

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 187
    :cond_5
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v9

    iput v9, v8, Lio/socket/parser/Packet;->attachments:I

    .line 190
    .end local v0    # "attachments":Ljava/lang/StringBuilder;
    :cond_6
    add-int/lit8 v9, v3, 0x1

    if-le v5, v9, :cond_c

    const/16 v9, 0x2f

    add-int/lit8 v10, v3, 0x1

    invoke-virtual {p0, v10}, Ljava/lang/String;->charAt(I)C

    move-result v10

    if-ne v9, v10, :cond_c

    .line 191
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    .line 193
    .local v7, "nsp":Ljava/lang/StringBuilder;
    :cond_7
    add-int/lit8 v3, v3, 0x1

    .line 194
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 195
    .local v1, "c":C
    const/16 v9, 0x2c

    if-ne v9, v1, :cond_b

    .line 199
    :goto_2
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    iput-object v9, v8, Lio/socket/parser/Packet;->nsp:Ljava/lang/String;

    .line 204
    .end local v1    # "c":C
    .end local v7    # "nsp":Ljava/lang/StringBuilder;
    :goto_3
    add-int/lit8 v9, v3, 0x1

    if-le v5, v9, :cond_9

    .line 205
    add-int/lit8 v9, v3, 0x1

    invoke-virtual {p0, v9}, Ljava/lang/String;->charAt(I)C

    move-result v9

    invoke-static {v9}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v6

    .line 206
    .local v6, "next":Ljava/lang/Character;
    invoke-virtual {v6}, Ljava/lang/Character;->charValue()C

    move-result v9

    invoke-static {v9}, Ljava/lang/Character;->getNumericValue(C)I

    move-result v9

    const/4 v10, -0x1

    if-le v9, v10, :cond_9

    .line 207
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .line 209
    .local v4, "id":Ljava/lang/StringBuilder;
    :cond_8
    add-int/lit8 v3, v3, 0x1

    .line 210
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 211
    .restart local v1    # "c":C
    invoke-static {v1}, Ljava/lang/Character;->getNumericValue(C)I

    move-result v9

    if-gez v9, :cond_d

    .line 212
    add-int/lit8 v3, v3, -0x1

    .line 219
    :goto_4
    :try_start_0
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v9

    iput v9, v8, Lio/socket/parser/Packet;->id:I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 226
    .end local v1    # "c":C
    .end local v4    # "id":Ljava/lang/StringBuilder;
    .end local v6    # "next":Ljava/lang/Character;
    :cond_9
    add-int/lit8 v9, v3, 0x1

    if-le v5, v9, :cond_a

    .line 228
    add-int/lit8 v3, v3, 0x1

    :try_start_1
    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    .line 229
    new-instance v9, Lorg/json/JSONTokener;

    invoke-virtual {p0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v10

    invoke-direct {v9, v10}, Lorg/json/JSONTokener;-><init>(Ljava/lang/String;)V

    invoke-virtual {v9}, Lorg/json/JSONTokener;->nextValue()Ljava/lang/Object;

    move-result-object v9

    iput-object v9, v8, Lio/socket/parser/Packet;->data:Ljava/lang/Object;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    .line 236
    :cond_a
    # getter for: Lio/socket/parser/Parser;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/parser/Parser;->access$000()Ljava/util/logging/Logger;

    move-result-object v9

    const-string v10, "decoded %s as %s"

    const/4 v11, 0x2

    new-array v11, v11, [Ljava/lang/Object;

    aput-object p0, v11, v12

    aput-object v8, v11, v13

    invoke-static {v10, v11}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/util/logging/Logger;->fine(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 196
    .restart local v1    # "c":C
    .restart local v7    # "nsp":Ljava/lang/StringBuilder;
    :cond_b
    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 197
    add-int/lit8 v9, v3, 0x1

    if-ne v9, v5, :cond_7

    goto :goto_2

    .line 201
    .end local v1    # "c":C
    .end local v7    # "nsp":Ljava/lang/StringBuilder;
    :cond_c
    const-string v9, "/"

    iput-object v9, v8, Lio/socket/parser/Packet;->nsp:Ljava/lang/String;

    goto :goto_3

    .line 215
    .restart local v1    # "c":C
    .restart local v4    # "id":Ljava/lang/StringBuilder;
    .restart local v6    # "next":Ljava/lang/Character;
    :cond_d
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 216
    add-int/lit8 v9, v3, 0x1

    if-ne v9, v5, :cond_8

    goto :goto_4

    .line 220
    :catch_0
    move-exception v2

    .line 221
    .local v2, "e":Ljava/lang/NumberFormatException;
    # invokes: Lio/socket/parser/Parser;->error()Lio/socket/parser/Packet;
    invoke-static {}, Lio/socket/parser/Parser;->access$100()Lio/socket/parser/Packet;

    move-result-object v8

    goto/16 :goto_0

    .line 230
    .end local v1    # "c":C
    .end local v2    # "e":Ljava/lang/NumberFormatException;
    .end local v4    # "id":Ljava/lang/StringBuilder;
    .end local v6    # "next":Ljava/lang/Character;
    :catch_1
    move-exception v2

    .line 231
    .local v2, "e":Lorg/json/JSONException;
    # getter for: Lio/socket/parser/Parser;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/parser/Parser;->access$000()Ljava/util/logging/Logger;

    move-result-object v9

    sget-object v10, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v11, "An error occured while retrieving data from JSONTokener"

    invoke-virtual {v9, v10, v11, v2}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 232
    # invokes: Lio/socket/parser/Parser;->error()Lio/socket/parser/Packet;
    invoke-static {}, Lio/socket/parser/Parser;->access$100()Lio/socket/parser/Packet;

    move-result-object v8

    goto/16 :goto_0
.end method


# virtual methods
.method public add(Ljava/lang/String;)V
    .locals 5
    .param p1, "obj"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 149
    invoke-static {p1}, Lio/socket/parser/Parser$Decoder;->decodeString(Ljava/lang/String;)Lio/socket/parser/Packet;

    move-result-object v0

    .line 150
    .local v0, "packet":Lio/socket/parser/Packet;
    const/4 v1, 0x5

    iget v2, v0, Lio/socket/parser/Packet;->type:I

    if-eq v1, v2, :cond_0

    const/4 v1, 0x6

    iget v2, v0, Lio/socket/parser/Packet;->type:I

    if-ne v1, v2, :cond_2

    .line 151
    :cond_0
    new-instance v1, Lio/socket/parser/Parser$BinaryReconstructor;

    invoke-direct {v1, v0}, Lio/socket/parser/Parser$BinaryReconstructor;-><init>(Lio/socket/parser/Packet;)V

    iput-object v1, p0, Lio/socket/parser/Parser$Decoder;->reconstructor:Lio/socket/parser/Parser$BinaryReconstructor;

    .line 153
    iget-object v1, p0, Lio/socket/parser/Parser$Decoder;->reconstructor:Lio/socket/parser/Parser$BinaryReconstructor;

    iget-object v1, v1, Lio/socket/parser/Parser$BinaryReconstructor;->reconPack:Lio/socket/parser/Packet;

    iget v1, v1, Lio/socket/parser/Packet;->attachments:I

    if-nez v1, :cond_1

    .line 154
    sget-object v1, Lio/socket/parser/Parser$Decoder;->EVENT_DECODED:Ljava/lang/String;

    new-array v2, v4, [Ljava/lang/Object;

    aput-object v0, v2, v3

    invoke-virtual {p0, v1, v2}, Lio/socket/parser/Parser$Decoder;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 159
    :cond_1
    :goto_0
    return-void

    .line 157
    :cond_2
    sget-object v1, Lio/socket/parser/Parser$Decoder;->EVENT_DECODED:Ljava/lang/String;

    new-array v2, v4, [Ljava/lang/Object;

    aput-object v0, v2, v3

    invoke-virtual {p0, v1, v2}, Lio/socket/parser/Parser$Decoder;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    goto :goto_0
.end method

.method public add([B)V
    .locals 4
    .param p1, "obj"    # [B

    .prologue
    .line 162
    iget-object v1, p0, Lio/socket/parser/Parser$Decoder;->reconstructor:Lio/socket/parser/Parser$BinaryReconstructor;

    if-nez v1, :cond_0

    .line 163
    new-instance v1, Ljava/lang/RuntimeException;

    const-string v2, "got binary data when not reconstructing a packet"

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 165
    :cond_0
    iget-object v1, p0, Lio/socket/parser/Parser$Decoder;->reconstructor:Lio/socket/parser/Parser$BinaryReconstructor;

    invoke-virtual {v1, p1}, Lio/socket/parser/Parser$BinaryReconstructor;->takeBinaryData([B)Lio/socket/parser/Packet;

    move-result-object v0

    .line 166
    .local v0, "packet":Lio/socket/parser/Packet;
    if-eqz v0, :cond_1

    .line 167
    const/4 v1, 0x0

    iput-object v1, p0, Lio/socket/parser/Parser$Decoder;->reconstructor:Lio/socket/parser/Parser$BinaryReconstructor;

    .line 168
    sget-object v1, Lio/socket/parser/Parser$Decoder;->EVENT_DECODED:Ljava/lang/String;

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-virtual {p0, v1, v2}, Lio/socket/parser/Parser$Decoder;->emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;

    .line 171
    :cond_1
    return-void
.end method

.method public destroy()V
    .locals 1

    .prologue
    .line 241
    iget-object v0, p0, Lio/socket/parser/Parser$Decoder;->reconstructor:Lio/socket/parser/Parser$BinaryReconstructor;

    if-eqz v0, :cond_0

    .line 242
    iget-object v0, p0, Lio/socket/parser/Parser$Decoder;->reconstructor:Lio/socket/parser/Parser$BinaryReconstructor;

    invoke-virtual {v0}, Lio/socket/parser/Parser$BinaryReconstructor;->finishReconstruction()V

    .line 244
    :cond_0
    return-void
.end method
