.class final Lio/socket/thread/EventThread$2;
.super Ljava/lang/Object;
.source "EventThread.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/thread/EventThread;->nextTick(Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$task:Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Ljava/lang/Runnable;)V
    .locals 0

    .prologue
    .line 76
    iput-object p1, p0, Lio/socket/thread/EventThread$2;->val$task:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 80
    :try_start_0
    iget-object v1, p0, Lio/socket/thread/EventThread$2;->val$task:Ljava/lang/Runnable;

    invoke-interface {v1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 85
    const-class v2, Lio/socket/thread/EventThread;

    monitor-enter v2

    .line 86
    :try_start_1
    # operator-- for: Lio/socket/thread/EventThread;->counter:I
    invoke-static {}, Lio/socket/thread/EventThread;->access$310()I

    .line 87
    # getter for: Lio/socket/thread/EventThread;->counter:I
    invoke-static {}, Lio/socket/thread/EventThread;->access$300()I

    move-result v1

    if-nez v1, :cond_0

    .line 88
    # getter for: Lio/socket/thread/EventThread;->service:Ljava/util/concurrent/ExecutorService;
    invoke-static {}, Lio/socket/thread/EventThread;->access$400()Ljava/util/concurrent/ExecutorService;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    .line 89
    const/4 v1, 0x0

    # setter for: Lio/socket/thread/EventThread;->service:Ljava/util/concurrent/ExecutorService;
    invoke-static {v1}, Lio/socket/thread/EventThread;->access$402(Ljava/util/concurrent/ExecutorService;)Ljava/util/concurrent/ExecutorService;

    .line 90
    const/4 v1, 0x0

    # setter for: Lio/socket/thread/EventThread;->thread:Lio/socket/thread/EventThread;
    invoke-static {v1}, Lio/socket/thread/EventThread;->access$002(Lio/socket/thread/EventThread;)Lio/socket/thread/EventThread;

    .line 92
    :cond_0
    monitor-exit v2

    .line 94
    return-void

    .line 92
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1

    .line 81
    :catch_0
    move-exception v0

    .line 82
    .local v0, "t":Ljava/lang/Throwable;
    :try_start_2
    # getter for: Lio/socket/thread/EventThread;->logger:Ljava/util/logging/Logger;
    invoke-static {}, Lio/socket/thread/EventThread;->access$200()Ljava/util/logging/Logger;

    move-result-object v1

    sget-object v2, Ljava/util/logging/Level;->SEVERE:Ljava/util/logging/Level;

    const-string v3, "Task threw exception"

    invoke-virtual {v1, v2, v3, v0}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 83
    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 85
    .end local v0    # "t":Ljava/lang/Throwable;
    :catchall_1
    move-exception v1

    const-class v2, Lio/socket/thread/EventThread;

    monitor-enter v2

    .line 86
    :try_start_3
    # operator-- for: Lio/socket/thread/EventThread;->counter:I
    invoke-static {}, Lio/socket/thread/EventThread;->access$310()I

    .line 87
    # getter for: Lio/socket/thread/EventThread;->counter:I
    invoke-static {}, Lio/socket/thread/EventThread;->access$300()I

    move-result v3

    if-nez v3, :cond_1

    .line 88
    # getter for: Lio/socket/thread/EventThread;->service:Ljava/util/concurrent/ExecutorService;
    invoke-static {}, Lio/socket/thread/EventThread;->access$400()Ljava/util/concurrent/ExecutorService;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    .line 89
    const/4 v3, 0x0

    # setter for: Lio/socket/thread/EventThread;->service:Ljava/util/concurrent/ExecutorService;
    invoke-static {v3}, Lio/socket/thread/EventThread;->access$402(Ljava/util/concurrent/ExecutorService;)Ljava/util/concurrent/ExecutorService;

    .line 90
    const/4 v3, 0x0

    # setter for: Lio/socket/thread/EventThread;->thread:Lio/socket/thread/EventThread;
    invoke-static {v3}, Lio/socket/thread/EventThread;->access$002(Lio/socket/thread/EventThread;)Lio/socket/thread/EventThread;

    .line 92
    :cond_1
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    throw v1

    :catchall_2
    move-exception v1

    :try_start_4
    monitor-exit v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    throw v1
.end method
