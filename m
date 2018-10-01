Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 01 Oct 2018 21:10:49 +0200
Message-ID: <16029249.TkoLblyBmC@blindfold>
In-Reply-To: <20181001190433.GA29874@splinter>
References: <1420505776-26827-1-git-send-email-bernhard.thaler@wvnet.at>
	<2473404.DTJdS9eVm5@blindfold> <20181001190433.GA29874@splinter>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Bridge] [PATCH 1/1] bridge: remove BR_GROUPFWD_RESTRICTED for
	arbitrary forwarding of reserved addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: David Gstir <david@sigma-star.at>, Florian Fainelli <f.fainelli@gmail.com>, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, bernhard.thaler@wvnet.at, "David S. Miller" <davem@davemloft.net>

Am Montag, 1. Oktober 2018, 21:04:33 CEST schrieb Ido Schimmel:
> On Mon, Oct 01, 2018 at 08:54:08PM +0200, Richard Weinberger wrote:
> > So the only option is having a bridge and transport STP via tc-mirred
> > or patching the bridge code (what we do right now).
> 
> And I vote for the first option. I understand it involves more typing,

hehe, it is not about typing. The setup is done by a script.
And we both know that getting a patch upstream is much more work than
typing a few lines of hacky bash scripts.
Since I want a decent solution and feedback I'm bringing this up here.

I could also just go with my in-house patch and don't tell anyone...

> but I see no reason to push more complexity into the kernel - and break
> standards - when you can relatively easily accomplish the same thing in
> other ways.

If having a bridge plus u32+mirred for STP bypass is the preferred solution,
I'm fine with it.
So far we use the kernel patch and didn't test the mirred-bypass a lot.
My fear was that mirred rules from eth0 to eth1 and back might cause a
loop or confuse the bridge...

> Adding Nik and Roopa who now maintain the bridge code and should
> eventually decide about this.

Thanks,
//richard 




