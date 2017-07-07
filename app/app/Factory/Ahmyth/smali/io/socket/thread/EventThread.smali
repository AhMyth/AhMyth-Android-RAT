.class public Lio/socket/thread/EventThread;
.super Ljava/lang/Thread;
.source "EventThread.java"


# static fields
.field private static final THREAD_FACTORY:Ljava/util/concurrent/ThreadFactory;

.field private static counter:I

.field private static final logger:Ljava/util/logging/Logger;

.field private static service:Ljava/util/concurrent/ExecutorService;

.field private static thread:Lio/socket/thread/EventThread;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 16
    const-class v0, Lio/socket/thread/EventThread;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lio/socket/thread/EventThread;->logger:Ljava/util/logging/Logger;

    .line 18
    new-instance v0, Lio/socket/thread/EventThread$1;

    invoke-direct {v0}, Lio/socket/thread/EventThread$1;-><init>()V

    sput-object v0, Lio/socket/thread/EventThread;->THREAD_FACTORY:Ljava/util/concurrent/ThreadFactory;

    .line 32
    const/4 v0, 0x0

    sput v0, Lio/socket/thread/EventThread;->counter:I

    return-void
.end method

.method private constructor <init>(Ljava/lang/Runnable;)V
    .locals 0
    .param p1, "runnable"    # Ljava/lang/Runnable;

    .prologue
    .line 36
    invoke-direct {p0, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 37
    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/Runnable;Lio/socket/thread/EventThread$1;)V
    .locals 0
    .param p1, "x0"    # Ljava/lang/Runnable;
    .param p2, "x1"    # Lio/socket/thread/EventThread$1;

    .prologue
    .line 14
    invoke-direct {p0, p1}, Lio/socket/thread/EventThread;-><init>(Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic access$000()Lio/socket/thread/EventThread;
    .locals 1

    .prologue
    .line 14
    sget-object v0, Lio/socket/thread/EventThread;->thread:Lio/socket/thread/EventThread;

    return-object v0
.end method

.method static synthetic access$002(Lio/socket/thread/EventThread;)Lio/socket/thread/EventThread;
    .locals 0
    .param p0, "x0"    # Lio/socket/thread/EventThread;

    .prologue
    .line 14
    sput-object p0, Lio/socket/thread/EventThread;->thread:Lio/socket/thread/EventThread;

    return-object p0
.end method

.method static synthetic access$200()Ljava/util/logging/Logger;
    .locals 1

    .prologue
    .line 14
    sget-object v0, Lio/socket/thread/EventThread;->logger:Ljava/util/logging/Logger;

    return-object v0
.end method

.method static synthetic access$300()I
    .locals 1

    .prologue
    .line 14
    sget v0, Lio/socket/thread/EventThread;->counter:I

    return v0
.end method

.method static synthetic access$310()I
    .locals 2

    .prologue
    .line 14
    sget v0, Lio/socket/thread/EventThread;->counter:I

    add-int/lit8 v1, v0, -0x1

    sput v1, Lio/socket/thread/EventThread;->counter:I

    return v0
.end method

.method static synthetic access$400()Ljava/util/concurrent/ExecutorService;
    .locals 1

    .prologue
    .line 14
    sget-object v0, Lio/socket/thread/EventThread;->service:Ljava/util/concurrent/ExecutorService;

    return-object v0
.end method

.method static synthetic access$402(Ljava/util/concurrent/ExecutorService;)Ljava/util/concurrent/ExecutorService;
    .locals 0
    .param p0, "x0"    # Ljava/util/concurrent/ExecutorService;

    .prologue
    .line 14
    sput-object p0, Lio/socket/thread/EventThread;->service:Ljava/util/concurrent/ExecutorService;

    return-object p0
.end method

.method public static exec(Ljava/lang/Runnable;)V
    .locals 1
    .param p0, "task"    # Ljava/lang/Runnable;

    .prologue
    .line 54
    invoke-static {}, Lio/socket/thread/EventThread;->isCurrent()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 55
    invoke-interface {p0}, Ljava/lang/Runnable;->run()V

    .line 59
    :goto_0
    return-void

    .line 57
    :cond_0
    invoke-static {p0}, Lio/socket/thread/EventThread;->nextTick(Ljava/lang/Runnable;)V

    goto :goto_0
.end method

.method public static isCurrent()Z
    .locals 2

    .prologue
    .line 45
    invoke-static {}, Lio/socket/thread/EventThread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    sget-object v1, Lio/socket/thread/EventThread;->thread:Lio/socket/thread/EventThread;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static nextTick(Ljava/lang/Runnable;)V
    .locals 3
    .param p0, "task"    # Ljava/lang/Runnable;

    .prologue
    .line 68
    const-class v2, Lio/socket/thread/EventThread;

    monitor-enter v2

    .line 69
    :try_start_0
    sget v1, Lio/socket/thread/EventThread;->counter:I

    add-int/lit8 v1, v1, 0x1

    sput v1, Lio/socket/thread/EventThread;->counter:I

    .line 70
    sget-object v1, Lio/socket/thread/EventThread;->service:Ljava/util/concurrent/ExecutorService;

    if-nez v1, :cond_0

    .line 71
    sget-object v1, Lio/socket/thread/EventThread;->THREAD_FACTORY:Ljava/util/concurrent/ThreadFactory;

    invoke-static {v1}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor(Ljava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ExecutorService;

    move-result-object v1

    sput-object v1, Lio/socket/thread/EventThread;->service:Ljava/util/concurrent/ExecutorService;

    .line 73
    :cond_0
    sget-object v0, Lio/socket/thread/EventThread;->service:Ljava/util/concurrent/ExecutorService;

    .line 74
    .local v0, "executor":Ljava/util/concurrent/ExecutorService;
    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 76
    new-instance v1, Lio/socket/thread/EventThread$2;

    invoke-direct {v1, p0}, Lio/socket/thread/EventThread$2;-><init>(Ljava/lang/Runnable;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    .line 96
    return-void

    .line 74
    .end local v0    # "executor":Ljava/util/concurrent/ExecutorService;
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method
