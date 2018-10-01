Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; bh=uCfLc/WV2h+9eU4PSTpFaLeolHru7
	0urNNEjhMvTHpY=; b=SvjW5RfaTFdRek2MEHXjNT5eEyp/iLu7I+TWU00aPCdLU
	UNMsICni7JLSgDuOqCzAL03Re6mTl/FhICvyWe+9UBzYng96U48gvS7ahkiSu+E9
	LZw6GjsUmZ9oPqcAU4gooznkfhaMGW3YXqNr9Jk/X3ulW8VO5FbUMpzxnmmNS/Vv
	kxUkmlm9AqpyshYoOnIVSNxwf9J5CgH5t+cZycjRgyWSddPX0GzoDhzsrqDk4NJ0
	drMSno5wqTUR5jDFS4htYueDl+7I8J6/bgyyLUkcFlNm1KDLnfkfRpkRNJA7QqUn
	ZFZCLs0/Cv24EUdDGi06HwCxz1K5uisolg8l0RHFA==
Date: Mon, 1 Oct 2018 22:04:33 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20181001190433.GA29874@splinter>
References: <1420505776-26827-1-git-send-email-bernhard.thaler@wvnet.at>
	<2327925.x0GQ7AZp12@blindfold> <20181001184821.GA29148@splinter>
	<2473404.DTJdS9eVm5@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2473404.DTJdS9eVm5@blindfold>
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
To: Richard Weinberger <richard@nod.at>
Cc: David Gstir <david@sigma-star.at>, Florian Fainelli <f.fainelli@gmail.com>, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, bernhard.thaler@wvnet.at, "David S. Miller" <davem@davemloft.net>

On Mon, Oct 01, 2018 at 08:54:08PM +0200, Richard Weinberger wrote:
> So the only option is having a bridge and transport STP via tc-mirred
> or patching the bridge code (what we do right now).

And I vote for the first option. I understand it involves more typing,
but I see no reason to push more complexity into the kernel - and break
standards - when you can relatively easily accomplish the same thing in
other ways.

Adding Nik and Roopa who now maintain the bridge code and should
eventually decide about this.
