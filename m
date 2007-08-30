DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	b=KW/VYlEDiRzuf8lfGHeGp9jFYhjMFxc8ZwyfexLgqy2TPiUqBiCYjEP9qIv5IMZMY3kJM5Zt+iV6SGif/uiSRUUCpBxhs/Bz4lXj6K1Q2KOxJwgABxboMaVebr3scslu7YlN1Anfoe1MfSoD0oIoyiTzr4K2y9urb0hRRce2FkE=
Message-ID: <fed120860708301209l345abb92m2d2bda264d174cf9@mail.gmail.com>
Date: Fri, 31 Aug 2007 00:39:23 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
Subject: Re: [Bridge] bridge problem when one interface is in blocking mode
In-Reply-To: <426497.88154.qm@web51910.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070829150515.54dd7ecf@freepuppy.rosehill.hemminger.net>
	<426497.88154.qm@web51910.mail.re2.yahoo.com>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wang dengyi <dy_wang@yahoo.com>
Cc: bridge@lists.linux-foundation.org

>
> The answer is yes and no. We do receive packets from
> the blocked device. But they are BPDU packets only.
> The fowarding database is updated because the BPDU
> package is received.
>
> Here is the chart of our network.
>
>           +-------------+
> ath0  +---+   bridge 1  +---+ eth0
>       |   +-------------+   |
>       |                     |
>       |                     |
>       |   +-------------+   |
> ath0  +---+   bridge 2  +---+ eth0
>           +-------------+
> Both bridge has the same Mac address as the ath0. And
> ath0 on the bridge 1 is blocked. So when the BPDU
> packet is received on the ath0 of bridge 1, it update
> the forwarding table and the following network packets
> will go through the ath0 which is in blocking mode.

I read this and first thought there should be no problem since each
port has its own MAC address. But the bridge MAC address is that of
one port, so this is a problem for getting to the bridge interface
itself.
The 802.1D docs also say that the forwarding database should be
updated only when the state of the port that received the packet
allows learning.
