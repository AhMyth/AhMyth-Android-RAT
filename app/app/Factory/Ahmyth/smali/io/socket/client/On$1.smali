.class final Lio/socket/client/On$1;
.super Ljava/lang/Object;
.source "On.java"

# interfaces
.implements Lio/socket/client/On$Handle;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/client/On;->on(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/client/On$Handle;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$ev:Ljava/lang/String;

.field final synthetic val$fn:Lio/socket/emitter/Emitter$Listener;

.field final synthetic val$obj:Lio/socket/emitter/Emitter;


# direct methods
.method constructor <init>(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)V
    .locals 0

    .prologue
    .line 11
    iput-object p1, p0, Lio/socket/client/On$1;->val$obj:Lio/socket/emitter/Emitter;

    iput-object p2, p0, Lio/socket/client/On$1;->val$ev:Ljava/lang/String;

    iput-object p3, p0, Lio/socket/client/On$1;->val$fn:Lio/socket/emitter/Emitter$Listener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public destroy()V
    .locals 3

    .prologue
    .line 14
    iget-object v0, p0, Lio/socket/client/On$1;->val$obj:Lio/socket/emitter/Emitter;

    iget-object v1, p0, Lio/socket/client/On$1;->val$ev:Ljava/lang/String;

    iget-object v2, p0, Lio/socket/client/On$1;->val$fn:Lio/socket/emitter/Emitter$Listener;

    invoke-virtual {v0, v1, v2}, Lio/socket/emitter/Emitter;->off(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 15
    return-void
.end method
