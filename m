DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	bh=wMIklsIpM6a3sRbWE6JgWuChFb/bkDEHiKhitZYE1Y0=;
	b=M8Xy76Cwptl256jFgwRjjzXLCh5FCa0fYzYFyzNVf6B8zu06bVYF+Snua4vBV+4r2GMALuDpL3vjtCrA73gbzlSXlaMFDfiMf7M9M37RerMf/S3leM+IcYlB1LMr6hcNYJFJ++b6mkT+dKj6vvmZn9ToaK8F52bGtpbiNBBJkoE=
Message-ID: <fed120860801071022k639af034s7e4abb1c19a323e0@mail.gmail.com>
Date: Mon, 7 Jan 2008 23:52:50 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
Subject: Re: [Bridge] Bridge with DHCP IP address
In-Reply-To: <478010E3.3020409@kotiportti.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <478010E3.3020409@kotiportti.fi>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Casper Gripenberg <casper.gripenberg@kotiportti.fi>
Cc: bridge@lists.linux-foundation.org

Setting up eth0 as a bridge port and also having an IP address on it
is confusing. Better perhaps to run dhclient on the bridge interface
itself.

For filtering packets as you indicate, it should be possible to do
that using ebtables. I don't know details about it though.
With this filtering, you can probably filter the outgoing DHCP
requests from br0 to go out only on eth0 and not through eth1. (They
will be broadcast, so they will get sent out of both ports normally.)

On Jan 6, 2008 4:51 AM, Casper Gripenberg
<casper.gripenberg@kotiportti.fi> wrote:
>
> Hi. I'm trying to run a bridge between my "internal"
> network (eth1) and the external internet (eth0). I.e.
> a very basic setup.
>
> But I also want the bridge to have an IP address. I
> read the docs here:
> http://www.linux-foundation.org/en/Net:Bridge
>
> Which say to set the forwarding delay to 0 and then run
> dhclient on eth0:
>
> # ifconfig eth0 0.0.0.0
> # ifconfig eth1 0.0.0.0
> # brctl setfd br0 0
> # brctl addif br0 eth0
> # dhclient eth0
> # brctl addif br0 eth1
> # ifconfig br0 up
>
> The bridge works fine as a bridge, and eth0 gets
> an IP address (although it takes a very long time
> for the dhclient to aquire it).
>
> But I can't reach the eth0 address from anywhere
> except localhost. And I can't get out of the bridge
> either to any other address..even though the routing
> table it set up correctly I get destination unreachable
> when I try to ping an external IP address from the
> bridge box (logged in through the console).
>
> What I want is for the bridge to have an IP address
> and then I want to allow access to specific ports on
> the bridge depending on if the packets are coming in
> through eth0 or eth1. Is this possible to do?
>
> Thanks.
>
> Casper
