Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=WysEgF0zI3rwxnRhhwusYCnWa06sB9K0KvlZOCJHuEk=;
	b=1bs7SC+r5eY4fUE52c8c8ei86CPC8N2wU9cnpUJ9dCttl9gG+fm2Nv3mMXKcU7SdqM
	TMaila3yWerPphlA7nQCmV8wPGN0TOWd/oGCuXzF9po/Qc1tyBCV2otq0FsiRINmKNyo
	Eul7KzcKxYs4yUXEEszDarB9A/ZcP1GaaXuPHz1XdoNYmiiBqNMNrOsGoIrKc9WDBd9c
	p7sv94aowXo+Ndk//6XPL4QRT3XOkIwLeR9Dxtw+pucCvdJ7KAG0MTiyCSr/aQjw2AXK
	OeoffHbrZ5QZz5ADbxTproRwWn+R/hQgWe5mWJN4WXvvfonSILhp/Y14R031it+rRJya
	LtBw==
Date: Sun, 8 Apr 2018 09:26:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180408092621.0c9f9f8c@xeon-e3>
In-Reply-To: <"H000007100115254.1523087977.sx.f1-outsourcing.eu*"@MHS>
References: <"H000007100115254.1523087977.sx.f1-outsourcing.eu*"@MHS>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge with 1x eth and 2x tun, adding 2nd eth,
 hosts become unavailable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Marc Roos <M.Roos@f1-outsourcing.eu>
Cc: bridge <bridge@lists.linux-foundation.org>

On Sat, 7 Apr 2018 09:59:37 +0200
"Marc Roos" <M.Roos@f1-outsourcing.eu> wrote:

> In this situation I can ping a vm from br0 connected to 172.16.1.y
> 
> 
> 
>                +-----------+           
>                |    BR0    |           
>    172.16.1.y  |           |      172.16.1.x
>        --------|ETH2   TUN1|-------           
>                |           |           
>                |           |      172.16.1.x
>                |       TUN2|-------           
>                |           |
>                +-----------+ 
> 
> When only adding a 2nd eth adapter with 'brctl addif br0 eth1' connected 
> to 10.11.12.y. The same ping is not working anymore.
> 
> 
>                +-----------+           
>                |    BR0    |           
>    172.16.1.y  |           |      172.16.1.x
>        --------|ETH2   TUN1|-------           
>                |           |           
>                |           |      172.16.1.x
>     10.11.12.y |       TUN2|-------           
>        --------|ETH1       |
>                +-----------+           
> 			             
> When I remove the eth1 again, the ping starts working again.
> 
> Can someone explain me why the bridge is behaving like this? And how 
> this can be fixed?
> 
> 	
> 
> 	   

Are you creating a spanning tree loop?  Also. Bridge is a Layer 2 device
not a Layer 3 device; therefore generally all interfaces in a bridge have same
subnet.
