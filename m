Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=szAIJSEnmpJBncT1tVfk7J83CA7nFcdRWDMfH+IQZbQ=;
	b=yKgVNMQlHgTrR5RSFurlSXEDlkXH3wXSTiLoZiLEAd34ABO/I3PceOOnCg4MvNcGIn
	PQ9uT9PCy22QRumONwx80XBrnTQr1yYHYdhqBPtCcJh3hH2xWKwHeRXGOm2buJ9aMgUd
	ihaRudgiovPy3/xlbNdZ82awNbEqEmkIHsWieQ8i0Zf5GHVorGKk+FQTJxj3Rxy2h34h
	1MTs7ZzqQsg7+T5o3he5RgBeyYt8yo7NEgFqddY7L1SzrECZT90c2zzfsF0+fn8n1r+4
	0NDW3nJ0IhizikB2bOMJDewySomncV8pPOdkyW36LbTaRoVGS0nkkBUNulGePgJZx8b0
	icxA==
Date: Fri, 7 Apr 2017 14:44:16 -0400
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170407144416.625462ec@plumbers-lap.home.lan>
In-Reply-To: <20170407181649.GA21938@splinter>
References: <20170407124915.15508-1-idosch@mellanox.com>
	<20170407101055.745d95d0@plumbers-lap.home.lan>
	<3d567660-7fa5-979e-3097-89427270e554@cumulusnetworks.com>
	<20170407112206.77b515cd@plumbers-lap.home.lan>
	<23249e09-a712-920f-9a9f-850055aaf3af@cumulusnetworks.com>
	<20170407113615.15891fde@plumbers-lap.home.lan>
	<c3769204-4803-6c5f-1286-c8f1f5e045be@cumulusnetworks.com>
	<20170407133753.1602f3cd@plumbers-lap.home.lan>
	<20170407181649.GA21938@splinter>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: netlink: register netdevice before
 executing changelink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: cera@cera.cz, mlxsw@mellanox.com, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, peter@svinota.eu, bridge@lists.linux-foundation.org, idosch@mellanox.com, davem@davemloft.net

On Fri, 7 Apr 2017 21:16:49 +0300
Ido Schimmel <idosch@idosch.org> wrote:

> On Fri, Apr 07, 2017 at 01:37:53PM -0400, Stephen Hemminger wrote:
> > Fix it right now. The patch you propose is too half baked.  
> 
> Given this patch needs to be back ported to three different stable
> kernels I tried to keep the amount of changes to a minimum while fixing
> the bug.
> 
> I'll work on the ndo_uninit() patch and submit it. Then people can
> decide which course of action they're more comfortable with.

I don't want enterprise distros to ship without error reporting.
At a minimum just return correct errno and leave bridge in stuck/broken state.
