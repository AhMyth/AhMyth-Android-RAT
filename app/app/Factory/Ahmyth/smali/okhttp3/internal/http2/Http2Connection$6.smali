.class Lokhttp3/internal/http2/Http2Connection$6;
.super Lokhttp3/internal/NamedRunnable;
.source "Http2Connection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lokhttp3/internal/http2/Http2Connection;->pushDataLater(ILokio/BufferedSource;IZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lokhttp3/internal/http2/Http2Connection;

.field final synthetic val$buffer:Lokio/Buffer;

.field final synthetic val$byteCount:I

.field final synthetic val$inFinished:Z

.field final synthetic val$streamId:I


# direct methods
.method varargs constructor <init>(Lokhttp3/internal/http2/Http2Connection;Ljava/lang/String;[Ljava/lang/Object;ILokio/Buffer;IZ)V
    .locals 0
    .param p1, "this$0"    # Lokhttp3/internal/http2/Http2Connection;
    .param p2, "format"    # Ljava/lang/String;
    .param p3, "args"    # [Ljava/lang/Object;

    .prologue
    .line 833
    iput-object p1, p0, Lokhttp3/internal/http2/Http2Connection$6;->this$0:Lokhttp3/internal/http2/Http2Connection;

    iput p4, p0, Lokhttp3/internal/http2/Http2Connection$6;->val$streamId:I

    iput-object p5, p0, Lokhttp3/internal/http2/Http2Connection$6;->val$buffer:Lokio/Buffer;

    iput p6, p0, Lokhttp3/internal/http2/Http2Connection$6;->val$byteCount:I

    iput-boolean p7, p0, Lokhttp3/internal/http2/Http2Connection$6;->val$inFinished:Z

    invoke-direct {p0, p2, p3}, Lokhttp3/internal/NamedRunnable;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public execute()V
    .locals 6

    .prologue
    .line 836
    :try_start_0
    iget-object v1, p0, Lokhttp3/internal/http2/Http2Connection$6;->this$0:Lokhttp3/internal/http2/Http2Connection;

    iget-object v1, v1, Lokhttp3/internal/http2/Http2Connection;->pushObserver:Lokhttp3/internal/http2/PushObserver;

    iget v2, p0, Lokhttp3/internal/http2/Http2Connection$6;->val$streamId:I

    iget-object v3, p0, Lokhttp3/internal/http2/Http2Connection$6;->val$buffer:Lokio/Buffer;

    iget v4, p0, Lokhttp3/internal/http2/Http2Connection$6;->val$byteCount:I

    iget-boolean v5, p0, Lokhttp3/internal/http2/Http2Connection$6;->val$inFinished:Z

    invoke-interface {v1, v2, v3, v4, v5}, Lokhttp3/internal/http2/PushObserver;->onData(ILokio/BufferedSource;IZ)Z

    move-result v0

    .line 837
    .local v0, "cancel":Z
    if-eqz v0, :cond_0

    iget-object v1, p0, Lokhttp3/internal/http2/Http2Connection$6;->this$0:Lokhttp3/internal/http2/Http2Connection;

    iget-object v1, v1, Lokhttp3/internal/http2/Http2Connection;->writer:Lokhttp3/internal/http2/Http2Writer;

    iget v2, p0, Lokhttp3/internal/http2/Http2Connection$6;->val$streamId:I

    sget-object v3, Lokhttp3/internal/http2/ErrorCode;->CANCEL:Lokhttp3/internal/http2/ErrorCode;

    invoke-virtual {v1, v2, v3}, Lokhttp3/internal/http2/Http2Writer;->rstStream(ILokhttp3/internal/http2/ErrorCode;)V

    .line 838
    :cond_0
    if-nez v0, :cond_1

    iget-boolean v1, p0, Lokhttp3/internal/http2/Http2Connection$6;->val$inFinished:Z

    if-eqz v1, :cond_2

    .line 839
    :cond_1
    iget-object v2, p0, Lokhttp3/internal/http2/Http2Connection$6;->this$0:Lokhttp3/internal/http2/Http2Connection;

    monitor-enter v2
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 840
    :try_start_1
    iget-object v1, p0, Lokhttp3/internal/http2/Http2Connection$6;->this$0:Lokhttp3/internal/http2/Http2Connection;

    iget-object v1, v1, Lokhttp3/internal/http2/Http2Connection;->currentPushRequests:Ljava/util/Set;

    iget v3, p0, Lokhttp3/internal/http2/Http2Connection$6;->val$streamId:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 841
    monitor-exit v2

    .line 845
    .end local v0    # "cancel":Z
    :cond_2
    :goto_0
    return-void

    .line 841
    .restart local v0    # "cancel":Z
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v1
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 843
    .end local v0    # "cancel":Z
    :catch_0
    move-exception v1

    goto :goto_0
.end method
