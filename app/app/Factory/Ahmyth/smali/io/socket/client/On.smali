.class public Lio/socket/client/On;
.super Ljava/lang/Object;
.source "On.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/socket/client/On$Handle;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static on(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/On$Handle;
    .locals 1
    .param p0, "obj"    # Lio/socket/emitter/Emitter;
    .param p1, "ev"    # Ljava/lang/String;
    .param p2, "fn"    # Lio/socket/emitter/Emitter$Listener;

    .prologue
    .line 10
    invoke-virtual {p0, p1, p2}, Lio/socket/emitter/Emitter;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 11
    new-instance v0, Lio/socket/client/On$1;

    invoke-direct {v0, p0, p1, p2}, Lio/socket/client/On$1;-><init>(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)V

    return-object v0
.end method
