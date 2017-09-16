.class public Lio/socket/client/Manager$Options;
.super Lio/socket/engineio/client/Socket$Options;
.source "Manager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/client/Manager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Options"
.end annotation


# instance fields
.field public randomizationFactor:D

.field public reconnection:Z

.field public reconnectionAttempts:I

.field public reconnectionDelay:J

.field public reconnectionDelayMax:J

.field public timeout:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 610
    invoke-direct {p0}, Lio/socket/engineio/client/Socket$Options;-><init>()V

    .line 612
    const/4 v0, 0x1

    iput-boolean v0, p0, Lio/socket/client/Manager$Options;->reconnection:Z

    .line 621
    const-wide/16 v0, 0x4e20

    iput-wide v0, p0, Lio/socket/client/Manager$Options;->timeout:J

    return-void
.end method
