Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=IoP3SJV5UIW1zBxeeSxYoht6lJAZ8bcRqIBEM3npqSY=;
	b=tXm9x7tPss0yq9cmVRz6xVTK/w8DvbmN3zorAlUIzlpUKGJ4HN7zJ6c/4JNhBm/c0a
	z/zxHq6QSObFnCZF5FIQm4zuvKvMKkAeViMgoSFJZyupDZCfp//XEWlCbvzYUntxmKMX
	h6o/dtPGo5SjRjpfyzcanheBezRvhbiQNHVN5+Mzfgf/8bdGgvYLmtRR+ST6s50JLN+z
	eMSlqPZu0TTxIvYgB+KvoWSubfTDS3xVOxOoT+DMXYVpiT+hYjRpxAFGyeIPevth3l4Y
	OaD+HtxjHQvQeBCUzqr09Znf3DMwusVglTBm0p2xrJS7rEqa3rBMy/fmZ3wSmVKwehA1
	CP5Q==
Date: Wed, 27 Apr 2016 12:37:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160427123726.65ce2ecb@samsung9>
In-Reply-To: <5720BBCD.2070009@man.szczecin.pl>
References: <571F6F45.7070000@man.szczecin.pl>
	<CAOaVG17inj4fb8R42q5PTMPUtgS0SQHErZmoNEUGFsJeXFdB=A@mail.gmail.com>
	<5720BBCD.2070009@man.szczecin.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PROBLEM] mac address learned on wrong port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Seweryn Niemiec <ser@man.szczecin.pl>
Cc: bridge <bridge@lists.linux-foundation.org>

On Wed, 27 Apr 2016 15:17:01 +0200
Seweryn Niemiec <ser@man.szczecin.pl> wrote:

> On 26.04.2016 18:49, Stephen Hemminger wrote:
> > This usualy happens when you either have a loop or packet leaks in from other port.
> 
> Yeah, it looks like a loop, but p2p1 is connected to a production network with 
> running MSTP, so I was sure there is no loop, but I have double checked it today 
> and I'm still sure there is no loop in the net outside of the server. To make it 
> super sure I have connected p2p1 to a dead end port (vlan with this one port 
> only) on a switch and the effect was the same - container's mac is learned on p2p1.
> 

But you are not running Spanning Tree on your bridge.


