.class public interface abstract Lio/socket/engineio/parser/Parser$DecodePayloadCallback;
.super Ljava/lang/Object;
.source "Parser.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/socket/engineio/parser/Parser;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "DecodePayloadCallback"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# virtual methods
.method public abstract call(Lio/socket/engineio/parser/Packet;II)Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lio/socket/engineio/parser/Packet",
            "<TT;>;II)Z"
        }
    .end annotation
.end method
