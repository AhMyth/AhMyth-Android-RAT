.class final Lokhttp3/internal/ws/RealWebSocket$PingRunnable;
.super Ljava/lang/Object;
.source "RealWebSocket.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lokhttp3/internal/ws/RealWebSocket;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "PingRunnable"
.end annotation


# instance fields
.field final synthetic this$0:Lokhttp3/internal/ws/RealWebSocket;


# direct methods
.method private constructor <init>(Lokhttp3/internal/ws/RealWebSocket;)V
    .locals 0

    .prologue
    .line 489
    iput-object p1, p0, Lokhttp3/internal/ws/RealWebSocket$PingRunnable;->this$0:Lokhttp3/internal/ws/RealWebSocket;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lokhttp3/internal/ws/RealWebSocket;Lokhttp3/internal/ws/RealWebSocket$1;)V
    .locals 0
    .param p1, "x0"    # Lokhttp3/internal/ws/RealWebSocket;
    .param p2, "x1"    # Lokhttp3/internal/ws/RealWebSocket$1;

    .prologue
    .line 489
    invoke-direct {p0, p1}, Lokhttp3/internal/ws/RealWebSocket$PingRunnable;-><init>(Lokhttp3/internal/ws/RealWebSocket;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .prologue
    .line 491
    iget-object v0, p0, Lokhttp3/internal/ws/RealWebSocket$PingRunnable;->this$0:Lokhttp3/internal/ws/RealWebSocket;

    # invokes: Lokhttp3/internal/ws/RealWebSocket;->writePingFrame()V
    invoke-static {v0}, Lokhttp3/internal/ws/RealWebSocket;->access$100(Lokhttp3/internal/ws/RealWebSocket;)V

    .line 492
    return-void
.end method
