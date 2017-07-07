.class public Lio/socket/parser/Parser;
.super Ljava/lang/Object;
.source "Parser.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/socket/parser/Parser$BinaryReconstructor;,
        Lio/socket/parser/Parser$Decoder;,
        Lio/socket/parser/Parser$Encoder;
    }
.end annotation


# static fields
.field public static final ACK:I = 0x3

.field public static final BINARY_ACK:I = 0x6

.field public static final BINARY_EVENT:I = 0x5

.field public static final CONNECT:I = 0x0

.field public static final DISCONNECT:I = 0x1

.field public static final ERROR:I = 0x4

.field public static final EVENT:I = 0x2

.field private static final logger:Ljava/util/logging/Logger;

.field public static protocol:I

.field public static types:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x4

    .line 15
    const-class v0, Lio/socket/parser/Parser;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lio/socket/parser/Parser;->logger:Ljava/util/logging/Logger;

    .line 52
    sput v3, Lio/socket/parser/Parser;->protocol:I

    .line 57
    const/4 v0, 0x7

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "CONNECT"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "DISCONNECT"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "EVENT"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "ACK"

    aput-object v2, v0, v1

    const-string v1, "ERROR"

    aput-object v1, v0, v3

    const/4 v1, 0x5

    const-string v2, "BINARY_EVENT"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "BINARY_ACK"

    aput-object v2, v0, v1

    sput-object v0, Lio/socket/parser/Parser;->types:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Ljava/util/logging/Logger;
    .locals 1

    .prologue
    .line 13
    sget-object v0, Lio/socket/parser/Parser;->logger:Ljava/util/logging/Logger;

    return-object v0
.end method

.method static synthetic access$100()Lio/socket/parser/Packet;
    .locals 1

    .prologue
    .line 13
    invoke-static {}, Lio/socket/parser/Parser;->error()Lio/socket/parser/Packet;

    move-result-object v0

    return-object v0
.end method

.method private static error()Lio/socket/parser/Packet;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lio/socket/parser/Packet",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 71
    new-instance v0, Lio/socket/parser/Packet;

    const/4 v1, 0x4

    const-string v2, "parser error"

    invoke-direct {v0, v1, v2}, Lio/socket/parser/Packet;-><init>(ILjava/lang/Object;)V

    return-object v0
.end method
