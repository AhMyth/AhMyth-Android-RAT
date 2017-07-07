.class final enum Lio/socket/engineio/client/Socket$ReadyState;
.super Ljava/lang/Enum;
.source "Socket.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/engineio/client/Socket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "ReadyState"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lio/socket/engineio/client/Socket$ReadyState;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lio/socket/engineio/client/Socket$ReadyState;

.field public static final enum CLOSED:Lio/socket/engineio/client/Socket$ReadyState;

.field public static final enum CLOSING:Lio/socket/engineio/client/Socket$ReadyState;

.field public static final enum OPEN:Lio/socket/engineio/client/Socket$ReadyState;

.field public static final enum OPENING:Lio/socket/engineio/client/Socket$ReadyState;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 39
    new-instance v0, Lio/socket/engineio/client/Socket$ReadyState;

    const-string v1, "OPENING"

    invoke-direct {v0, v1, v2}, Lio/socket/engineio/client/Socket$ReadyState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/socket/engineio/client/Socket$ReadyState;->OPENING:Lio/socket/engineio/client/Socket$ReadyState;

    new-instance v0, Lio/socket/engineio/client/Socket$ReadyState;

    const-string v1, "OPEN"

    invoke-direct {v0, v1, v3}, Lio/socket/engineio/client/Socket$ReadyState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/socket/engineio/client/Socket$ReadyState;->OPEN:Lio/socket/engineio/client/Socket$ReadyState;

    new-instance v0, Lio/socket/engineio/client/Socket$ReadyState;

    const-string v1, "CLOSING"

    invoke-direct {v0, v1, v4}, Lio/socket/engineio/client/Socket$ReadyState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/socket/engineio/client/Socket$ReadyState;->CLOSING:Lio/socket/engineio/client/Socket$ReadyState;

    new-instance v0, Lio/socket/engineio/client/Socket$ReadyState;

    const-string v1, "CLOSED"

    invoke-direct {v0, v1, v5}, Lio/socket/engineio/client/Socket$ReadyState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lio/socket/engineio/client/Socket$ReadyState;->CLOSED:Lio/socket/engineio/client/Socket$ReadyState;

    .line 38
    const/4 v0, 0x4

    new-array v0, v0, [Lio/socket/engineio/client/Socket$ReadyState;

    sget-object v1, Lio/socket/engineio/client/Socket$ReadyState;->OPENING:Lio/socket/engineio/client/Socket$ReadyState;

    aput-object v1, v0, v2

    sget-object v1, Lio/socket/engineio/client/Socket$ReadyState;->OPEN:Lio/socket/engineio/client/Socket$ReadyState;

    aput-object v1, v0, v3

    sget-object v1, Lio/socket/engineio/client/Socket$ReadyState;->CLOSING:Lio/socket/engineio/client/Socket$ReadyState;

    aput-object v1, v0, v4

    sget-object v1, Lio/socket/engineio/client/Socket$ReadyState;->CLOSED:Lio/socket/engineio/client/Socket$ReadyState;

    aput-object v1, v0, v5

    sput-object v0, Lio/socket/engineio/client/Socket$ReadyState;->$VALUES:[Lio/socket/engineio/client/Socket$ReadyState;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 38
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lio/socket/engineio/client/Socket$ReadyState;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 38
    const-class v0, Lio/socket/engineio/client/Socket$ReadyState;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lio/socket/engineio/client/Socket$ReadyState;

    return-object v0
.end method

.method public static values()[Lio/socket/engineio/client/Socket$ReadyState;
    .locals 1

    .prologue
    .line 38
    sget-object v0, Lio/socket/engineio/client/Socket$ReadyState;->$VALUES:[Lio/socket/engineio/client/Socket$ReadyState;

    invoke-virtual {v0}, [Lio/socket/engineio/client/Socket$ReadyState;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lio/socket/engineio/client/Socket$ReadyState;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 43
    invoke-super {p0}, Ljava/lang/Enum;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
