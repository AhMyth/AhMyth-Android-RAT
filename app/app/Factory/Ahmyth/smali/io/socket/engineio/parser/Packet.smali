.class public Lio/socket/engineio/parser/Packet;
.super Ljava/lang/Object;
.source "Packet.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# static fields
.field public static final CLOSE:Ljava/lang/String; = "close"

.field public static final ERROR:Ljava/lang/String; = "error"

.field public static final MESSAGE:Ljava/lang/String; = "message"

.field public static final NOOP:Ljava/lang/String; = "noop"

.field public static final OPEN:Ljava/lang/String; = "open"

.field public static final PING:Ljava/lang/String; = "ping"

.field public static final PONG:Ljava/lang/String; = "pong"

.field public static final UPGRADE:Ljava/lang/String; = "upgrade"


# instance fields
.field public data:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field

.field public type:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "type"    # Ljava/lang/String;

    .prologue
    .line 20
    .local p0, "this":Lio/socket/engineio/parser/Packet;, "Lio/socket/engineio/parser/Packet<TT;>;"
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lio/socket/engineio/parser/Packet;-><init>(Ljava/lang/String;Ljava/lang/Object;)V

    .line 21
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0
    .param p1, "type"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "TT;)V"
        }
    .end annotation

    .prologue
    .line 23
    .local p0, "this":Lio/socket/engineio/parser/Packet;, "Lio/socket/engineio/parser/Packet<TT;>;"
    .local p2, "data":Ljava/lang/Object;, "TT;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    iput-object p1, p0, Lio/socket/engineio/parser/Packet;->type:Ljava/lang/String;

    .line 25
    iput-object p2, p0, Lio/socket/engineio/parser/Packet;->data:Ljava/lang/Object;

    .line 26
    return-void
.end method
