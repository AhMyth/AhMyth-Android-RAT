.class public Lio/socket/emitter/Emitter;
.super Ljava/lang/Object;
.source "Emitter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/socket/emitter/Emitter$OnceListener;,
        Lio/socket/emitter/Emitter$Listener;
    }
.end annotation


# instance fields
.field private callbacks:Ljava/util/concurrent/ConcurrentMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/util/concurrent/ConcurrentLinkedQueue",
            "<",
            "Lio/socket/emitter/Emitter$Listener;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lio/socket/emitter/Emitter;->callbacks:Ljava/util/concurrent/ConcurrentMap;

    return-void
.end method

.method private static sameAs(Lio/socket/emitter/Emitter$Listener;Lio/socket/emitter/Emitter$Listener;)Z
    .locals 1
    .param p0, "fn"    # Lio/socket/emitter/Emitter$Listener;
    .param p1, "internal"    # Lio/socket/emitter/Emitter$Listener;

    .prologue
    .line 97
    invoke-virtual {p0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 98
    const/4 v0, 0x1

    .line 102
    .end local p1    # "internal":Lio/socket/emitter/Emitter$Listener;
    :goto_0
    return v0

    .line 99
    .restart local p1    # "internal":Lio/socket/emitter/Emitter$Listener;
    :cond_0
    instance-of v0, p1, Lio/socket/emitter/Emitter$OnceListener;

    if-eqz v0, :cond_1

    .line 100
    check-cast p1, Lio/socket/emitter/Emitter$OnceListener;

    .end local p1    # "internal":Lio/socket/emitter/Emitter$Listener;
    iget-object v0, p1, Lio/socket/emitter/Emitter$OnceListener;->fn:Lio/socket/emitter/Emitter$Listener;

    invoke-virtual {p0, v0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0

    .line 102
    .restart local p1    # "internal":Lio/socket/emitter/Emitter$Listener;
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method public varargs emit(Ljava/lang/String;[Ljava/lang/Object;)Lio/socket/emitter/Emitter;
    .locals 4
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .prologue
    .line 114
    iget-object v2, p0, Lio/socket/emitter/Emitter;->callbacks:Ljava/util/concurrent/ConcurrentMap;

    invoke-interface {v2, p1}, Ljava/util/concurrent/ConcurrentMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/ConcurrentLinkedQueue;

    .line 115
    .local v0, "callbacks":Ljava/util/concurrent/ConcurrentLinkedQueue;, "Ljava/util/concurrent/ConcurrentLinkedQueue<Lio/socket/emitter/Emitter$Listener;>;"
    if-eqz v0, :cond_0

    .line 116
    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/socket/emitter/Emitter$Listener;

    .line 117
    .local v1, "fn":Lio/socket/emitter/Emitter$Listener;
    invoke-interface {v1, p2}, Lio/socket/emitter/Emitter$Listener;->call([Ljava/lang/Object;)V

    goto :goto_0

    .line 120
    .end local v1    # "fn":Lio/socket/emitter/Emitter$Listener;
    :cond_0
    return-object p0
.end method

.method public hasListeners(Ljava/lang/String;)Z
    .locals 2
    .param p1, "event"    # Ljava/lang/String;

    .prologue
    .line 142
    iget-object v1, p0, Lio/socket/emitter/Emitter;->callbacks:Ljava/util/concurrent/ConcurrentMap;

    invoke-interface {v1, p1}, Ljava/util/concurrent/ConcurrentMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/ConcurrentLinkedQueue;

    .line 143
    .local v0, "callbacks":Ljava/util/concurrent/ConcurrentLinkedQueue;, "Ljava/util/concurrent/ConcurrentLinkedQueue<Lio/socket/emitter/Emitter$Listener;>;"
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public listeners(Ljava/lang/String;)Ljava/util/List;
    .locals 3
    .param p1, "event"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List",
            "<",
            "Lio/socket/emitter/Emitter$Listener;",
            ">;"
        }
    .end annotation

    .prologue
    .line 130
    iget-object v1, p0, Lio/socket/emitter/Emitter;->callbacks:Ljava/util/concurrent/ConcurrentMap;

    invoke-interface {v1, p1}, Ljava/util/concurrent/ConcurrentMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/ConcurrentLinkedQueue;

    .line 131
    .local v0, "callbacks":Ljava/util/concurrent/ConcurrentLinkedQueue;, "Ljava/util/concurrent/ConcurrentLinkedQueue<Lio/socket/emitter/Emitter$Listener;>;"
    if-eqz v0, :cond_0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    :goto_0
    return-object v1

    :cond_0
    new-instance v1, Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    goto :goto_0
.end method

.method public off()Lio/socket/emitter/Emitter;
    .locals 1

    .prologue
    .line 59
    iget-object v0, p0, Lio/socket/emitter/Emitter;->callbacks:Ljava/util/concurrent/ConcurrentMap;

    invoke-interface {v0}, Ljava/util/concurrent/ConcurrentMap;->clear()V

    .line 60
    return-object p0
.end method

.method public off(Ljava/lang/String;)Lio/socket/emitter/Emitter;
    .locals 1
    .param p1, "event"    # Ljava/lang/String;

    .prologue
    .line 70
    iget-object v0, p0, Lio/socket/emitter/Emitter;->callbacks:Ljava/util/concurrent/ConcurrentMap;

    invoke-interface {v0, p1}, Ljava/util/concurrent/ConcurrentMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 71
    return-object p0
.end method

.method public off(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;
    .locals 4
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "fn"    # Lio/socket/emitter/Emitter$Listener;

    .prologue
    .line 82
    iget-object v3, p0, Lio/socket/emitter/Emitter;->callbacks:Ljava/util/concurrent/ConcurrentMap;

    invoke-interface {v3, p1}, Ljava/util/concurrent/ConcurrentMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/ConcurrentLinkedQueue;

    .line 83
    .local v0, "callbacks":Ljava/util/concurrent/ConcurrentLinkedQueue;, "Ljava/util/concurrent/ConcurrentLinkedQueue<Lio/socket/emitter/Emitter$Listener;>;"
    if-eqz v0, :cond_1

    .line 84
    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .line 85
    .local v2, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Lio/socket/emitter/Emitter$Listener;>;"
    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 86
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lio/socket/emitter/Emitter$Listener;

    .line 87
    .local v1, "internal":Lio/socket/emitter/Emitter$Listener;
    invoke-static {p2, v1}, Lio/socket/emitter/Emitter;->sameAs(Lio/socket/emitter/Emitter$Listener;Lio/socket/emitter/Emitter$Listener;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 88
    invoke-interface {v2}, Ljava/util/Iterator;->remove()V

    .line 93
    .end local v1    # "internal":Lio/socket/emitter/Emitter$Listener;
    .end local v2    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Lio/socket/emitter/Emitter$Listener;>;"
    :cond_1
    return-object p0
.end method

.method public on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;
    .locals 3
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "fn"    # Lio/socket/emitter/Emitter$Listener;

    .prologue
    .line 29
    iget-object v2, p0, Lio/socket/emitter/Emitter;->callbacks:Ljava/util/concurrent/ConcurrentMap;

    invoke-interface {v2, p1}, Ljava/util/concurrent/ConcurrentMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/ConcurrentLinkedQueue;

    .line 30
    .local v0, "callbacks":Ljava/util/concurrent/ConcurrentLinkedQueue;, "Ljava/util/concurrent/ConcurrentLinkedQueue<Lio/socket/emitter/Emitter$Listener;>;"
    if-nez v0, :cond_0

    .line 31
    new-instance v0, Ljava/util/concurrent/ConcurrentLinkedQueue;

    .end local v0    # "callbacks":Ljava/util/concurrent/ConcurrentLinkedQueue;, "Ljava/util/concurrent/ConcurrentLinkedQueue<Lio/socket/emitter/Emitter$Listener;>;"
    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentLinkedQueue;-><init>()V

    .line 32
    .restart local v0    # "callbacks":Ljava/util/concurrent/ConcurrentLinkedQueue;, "Ljava/util/concurrent/ConcurrentLinkedQueue<Lio/socket/emitter/Emitter$Listener;>;"
    iget-object v2, p0, Lio/socket/emitter/Emitter;->callbacks:Ljava/util/concurrent/ConcurrentMap;

    invoke-interface {v2, p1, v0}, Ljava/util/concurrent/ConcurrentMap;->putIfAbsent(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/concurrent/ConcurrentLinkedQueue;

    .line 33
    .local v1, "tempCallbacks":Ljava/util/concurrent/ConcurrentLinkedQueue;, "Ljava/util/concurrent/ConcurrentLinkedQueue<Lio/socket/emitter/Emitter$Listener;>;"
    if-eqz v1, :cond_0

    .line 34
    move-object v0, v1

    .line 37
    .end local v1    # "tempCallbacks":Ljava/util/concurrent/ConcurrentLinkedQueue;, "Ljava/util/concurrent/ConcurrentLinkedQueue<Lio/socket/emitter/Emitter$Listener;>;"
    :cond_0
    invoke-virtual {v0, p2}, Ljava/util/concurrent/ConcurrentLinkedQueue;->add(Ljava/lang/Object;)Z

    .line 38
    return-object p0
.end method

.method public once(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;
    .locals 1
    .param p1, "event"    # Ljava/lang/String;
    .param p2, "fn"    # Lio/socket/emitter/Emitter$Listener;

    .prologue
    .line 49
    new-instance v0, Lio/socket/emitter/Emitter$OnceListener;

    invoke-direct {v0, p0, p1, p2}, Lio/socket/emitter/Emitter$OnceListener;-><init>(Lio/socket/emitter/Emitter;Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)V

    invoke-virtual {p0, p1, v0}, Lio/socket/emitter/Emitter;->on(Ljava/lang/String;Lio/socket/emitter/Emitter$Listener;)Lio/socket/emitter/Emitter;

    .line 50
    return-object p0
.end method
