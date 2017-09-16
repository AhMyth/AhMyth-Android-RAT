.class Lio/socket/emitter/Emitter$OnceListener;
.super Ljava/lang/Object;
.source "Emitter.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/emitter/Emitter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "OnceListener"
.end annotation


# instance fields
.field public final event:Ljava/lang/String;

.field public final fn:Lio/socket/emitter/Emitter$Listener;

.field final synthetic this$0:Lio/socket/emitter/Emitter;


# direct methods
.method public constructor <init>(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)V
    .locals 0
    .param p2, "event"    # Ljava/lang/String;
    .param p3, "fn"    # Lio/socket/emitter/Emitter$Listener;

    .prologue
    .line 156
    iput-object p1, p0, Lio/socket/emitter/Emitter$OnceListener;->this$0:Lio/socket/emitter/Emitter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 157
    iput-object p2, p0, Lio/socket/emitter/Emitter$OnceListener;->event:Ljava/lang/String;

    .line 158
    iput-object p3, p0, Lio/socket/emitter/Emitter$OnceListener;->fn:Lio/socket/emitter/Emitter$Listener;

    .line 159
    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 2
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    .line 163
    iget-object v0, p0, Lio/socket/emitter/Emitter$OnceListener;->this$0:Lio/socket/emitter/Emitter;

    iget-object v1, p0, Lio/socket/emitter/Emitter$OnceListener;->event:Ljava/lang/String;

    invoke-virtual {v0, v1, p0}, Lio/socket/emitter/Emitter;->off(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 164
    iget-object v0, p0, Lio/socket/emitter/Emitter$OnceListener;->fn:Lio/socket/emitter/Emitter$Listener;

    invoke-interface {v0, p1}, Lio/socket/emitter/Emitter$Listener;->call([Ljava/lang/Object;)V

    .line 165
    return-void
.end method
