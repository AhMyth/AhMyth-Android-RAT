.class Lio/socket/engineio/client/transports/PollingXHR$Request$1;
.super Ljava/lang/Object;
.source "PollingXHR.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/socket/engineio/client/transports/PollingXHR$Request;->create()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lio/socket/engineio/client/transports/PollingXHR$Request;

.field final synthetic val$self:Lio/socket/engineio/client/transports/PollingXHR$Request;


# direct methods
.method constructor <init>(Lio/socket/engineio/client/transports/PollingXHR$Request;Lio/socket/engineio/client/transports/PollingXHR$Request;)V
    .locals 0
    .param p1, "this$0"    # Lio/socket/engineio/client/transports/PollingXHR$Request;

    .prologue
    .line 199
    iput-object p1, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->this$0:Lio/socket/engineio/client/transports/PollingXHR$Request;

    iput-object p2, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->val$self:Lio/socket/engineio/client/transports/PollingXHR$Request;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    .prologue
    .line 202
    const/4 v2, 0x0

    .line 204
    .local v2, "output":Ljava/io/OutputStream;
    :try_start_0
    iget-object v5, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->val$self:Lio/socket/engineio/client/transports/PollingXHR$Request;

    # getter for: Lio/socket/engineio/client/transports/PollingXHR$Request;->data:[B
    invoke-static {v5}, Lio/socket/engineio/client/transports/PollingXHR$Request;->access$300(Lio/socket/engineio/client/transports/PollingXHR$Request;)[B

    move-result-object v5

    if-eqz v5, :cond_0

    .line 205
    iget-object v5, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->this$0:Lio/socket/engineio/client/transports/PollingXHR$Request;

    # getter for: Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;
    invoke-static {v5}, Lio/socket/engineio/client/transports/PollingXHR$Request;->access$400(Lio/socket/engineio/client/transports/PollingXHR$Request;)Ljava/net/HttpURLConnection;

    move-result-object v5

    iget-object v6, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->val$self:Lio/socket/engineio/client/transports/PollingXHR$Request;

    # getter for: Lio/socket/engineio/client/transports/PollingXHR$Request;->data:[B
    invoke-static {v6}, Lio/socket/engineio/client/transports/PollingXHR$Request;->access$300(Lio/socket/engineio/client/transports/PollingXHR$Request;)[B

    move-result-object v6

    array-length v6, v6

    invoke-virtual {v5, v6}, Ljava/net/HttpURLConnection;->setFixedLengthStreamingMode(I)V

    .line 206
    new-instance v3, Ljava/io/BufferedOutputStream;

    iget-object v5, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->this$0:Lio/socket/engineio/client/transports/PollingXHR$Request;

    # getter for: Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;
    invoke-static {v5}, Lio/socket/engineio/client/transports/PollingXHR$Request;->access$400(Lio/socket/engineio/client/transports/PollingXHR$Request;)Ljava/net/HttpURLConnection;

    move-result-object v5

    invoke-virtual {v5}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v5

    invoke-direct {v3, v5}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 207
    .end local v2    # "output":Ljava/io/OutputStream;
    .local v3, "output":Ljava/io/OutputStream;
    :try_start_1
    iget-object v5, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->val$self:Lio/socket/engineio/client/transports/PollingXHR$Request;

    # getter for: Lio/socket/engineio/client/transports/PollingXHR$Request;->data:[B
    invoke-static {v5}, Lio/socket/engineio/client/transports/PollingXHR$Request;->access$300(Lio/socket/engineio/client/transports/PollingXHR$Request;)[B

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/io/OutputStream;->write([B)V

    .line 208
    invoke-virtual {v3}, Ljava/io/OutputStream;->flush()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-object v2, v3

    .line 211
    .end local v3    # "output":Ljava/io/OutputStream;
    .restart local v2    # "output":Ljava/io/OutputStream;
    :cond_0
    :try_start_2
    iget-object v5, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->this$0:Lio/socket/engineio/client/transports/PollingXHR$Request;

    # getter for: Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;
    invoke-static {v5}, Lio/socket/engineio/client/transports/PollingXHR$Request;->access$400(Lio/socket/engineio/client/transports/PollingXHR$Request;)Ljava/net/HttpURLConnection;

    move-result-object v5

    invoke-virtual {v5}, Ljava/net/HttpURLConnection;->getHeaderFields()Ljava/util/Map;

    move-result-object v1

    .line 212
    .local v1, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    iget-object v5, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->val$self:Lio/socket/engineio/client/transports/PollingXHR$Request;

    # invokes: Lio/socket/engineio/client/transports/PollingXHR$Request;->onResponseHeaders(Ljava/util/Map;)V
    invoke-static {v5, v1}, Lio/socket/engineio/client/transports/PollingXHR$Request;->access$500(Lio/socket/engineio/client/transports/PollingXHR$Request;Ljava/util/Map;)V

    .line 214
    iget-object v5, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->this$0:Lio/socket/engineio/client/transports/PollingXHR$Request;

    # getter for: Lio/socket/engineio/client/transports/PollingXHR$Request;->xhr:Ljava/net/HttpURLConnection;
    invoke-static {v5}, Lio/socket/engineio/client/transports/PollingXHR$Request;->access$400(Lio/socket/engineio/client/transports/PollingXHR$Request;)Ljava/net/HttpURLConnection;

    move-result-object v5

    invoke-virtual {v5}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v4

    .line 215
    .local v4, "statusCode":I
    const/16 v5, 0xc8

    if-ne v5, v4, :cond_2

    .line 216
    iget-object v5, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->val$self:Lio/socket/engineio/client/transports/PollingXHR$Request;

    # invokes: Lio/socket/engineio/client/transports/PollingXHR$Request;->onLoad()V
    invoke-static {v5}, Lio/socket/engineio/client/transports/PollingXHR$Request;->access$600(Lio/socket/engineio/client/transports/PollingXHR$Request;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 228
    :goto_0
    if-eqz v2, :cond_1

    :try_start_3
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_4

    .line 231
    .end local v1    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .end local v4    # "statusCode":I
    :cond_1
    :goto_1
    return-void

    .line 218
    .restart local v1    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .restart local v4    # "statusCode":I
    :cond_2
    :try_start_4
    iget-object v5, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->val$self:Lio/socket/engineio/client/transports/PollingXHR$Request;

    new-instance v6, Ljava/io/IOException;

    invoke-static {v4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    # invokes: Lio/socket/engineio/client/transports/PollingXHR$Request;->onError(Ljava/lang/Exception;)V
    invoke-static {v5, v6}, Lio/socket/engineio/client/transports/PollingXHR$Request;->access$700(Lio/socket/engineio/client/transports/PollingXHR$Request;Ljava/lang/Exception;)V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_0

    .line 220
    .end local v1    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .end local v4    # "statusCode":I
    :catch_0
    move-exception v0

    .line 221
    .local v0, "e":Ljava/io/IOException;
    :goto_2
    :try_start_5
    iget-object v5, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->val$self:Lio/socket/engineio/client/transports/PollingXHR$Request;

    # invokes: Lio/socket/engineio/client/transports/PollingXHR$Request;->onError(Ljava/lang/Exception;)V
    invoke-static {v5, v0}, Lio/socket/engineio/client/transports/PollingXHR$Request;->access$700(Lio/socket/engineio/client/transports/PollingXHR$Request;Ljava/lang/Exception;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 228
    if-eqz v2, :cond_1

    :try_start_6
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_1

    .line 229
    :catch_1
    move-exception v5

    goto :goto_1

    .line 222
    .end local v0    # "e":Ljava/io/IOException;
    :catch_2
    move-exception v0

    .line 225
    .local v0, "e":Ljava/lang/NullPointerException;
    :goto_3
    :try_start_7
    iget-object v5, p0, Lio/socket/engineio/client/transports/PollingXHR$Request$1;->val$self:Lio/socket/engineio/client/transports/PollingXHR$Request;

    # invokes: Lio/socket/engineio/client/transports/PollingXHR$Request;->onError(Ljava/lang/Exception;)V
    invoke-static {v5, v0}, Lio/socket/engineio/client/transports/PollingXHR$Request;->access$700(Lio/socket/engineio/client/transports/PollingXHR$Request;Ljava/lang/Exception;)V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 228
    if-eqz v2, :cond_1

    :try_start_8
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_3

    goto :goto_1

    .line 229
    :catch_3
    move-exception v5

    goto :goto_1

    .line 227
    .end local v0    # "e":Ljava/lang/NullPointerException;
    :catchall_0
    move-exception v5

    .line 228
    :goto_4
    if-eqz v2, :cond_3

    :try_start_9
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_5

    .line 229
    :cond_3
    :goto_5
    throw v5

    .restart local v1    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .restart local v4    # "statusCode":I
    :catch_4
    move-exception v5

    goto :goto_1

    .end local v1    # "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/util/List<Ljava/lang/String;>;>;"
    .end local v4    # "statusCode":I
    :catch_5
    move-exception v6

    goto :goto_5

    .line 227
    .end local v2    # "output":Ljava/io/OutputStream;
    .restart local v3    # "output":Ljava/io/OutputStream;
    :catchall_1
    move-exception v5

    move-object v2, v3

    .end local v3    # "output":Ljava/io/OutputStream;
    .restart local v2    # "output":Ljava/io/OutputStream;
    goto :goto_4

    .line 222
    .end local v2    # "output":Ljava/io/OutputStream;
    .restart local v3    # "output":Ljava/io/OutputStream;
    :catch_6
    move-exception v0

    move-object v2, v3

    .end local v3    # "output":Ljava/io/OutputStream;
    .restart local v2    # "output":Ljava/io/OutputStream;
    goto :goto_3

    .line 220
    .end local v2    # "output":Ljava/io/OutputStream;
    .restart local v3    # "output":Ljava/io/OutputStream;
    :catch_7
    move-exception v0

    move-object v2, v3

    .end local v3    # "output":Ljava/io/OutputStream;
    .restart local v2    # "output":Ljava/io/OutputStream;
    goto :goto_2
.end method
