Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding;
	bh=YHoYrDW8rvLgy3OruW3qEY2+pl/rCdU+tH6mKSxI7To=;
	b=qBzdsmlRbxuF42qNPkFg+G8OGlAt+vpAioye+Rh/23iX3QPeSvS3K3D7P/Hg3o4svb
	RH8M5BLuq7achOjv4yHcE10mfxaAs9B9HCOqXsTgjAlRpjM5QPWJtcv9Zb43u3TgIeCm
	SgFLX2tZ+X6DGErMpXPAMQc9x4pUgh4UFN6zJ7CGbLQMDmhcnxbW0nrHkmWC6npsrX+6
	cIcIiPKhKdqQc3VinPwpVF/CHNrjMINiopiimj/T7JlfIX5pmBvNi5sDq9Nx4OMSCevb
	eK86RFWWGB+8frIrc7UrT6iggrsaSPJKNl09yq/Z2Za61b7e7vKWvNZ0FrjgT525cmJp
	vlBw==
Message-ID: <1396147295.2182.12.camel@localhost.localdomain>
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
Date: Sun, 30 Mar 2014 11:41:35 +0900
In-Reply-To: <1396078847.1756.1.camel@localhost.localdomain>
References: <1395987680-8151-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20140328093457.5d25b9a3@samsung-9>
	<1396078847.1756.1.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Fix memory leak in br_dev_xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Vlad Yasevich <vyasevic@redhat.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>

On Sat, 2014-03-29 at 16:40 +0900, Toshiaki Makita wrote:
> On Fri, 2014-03-28 at 09:34 -0700, Stephen Hemminger wrote:
> > On Fri, 28 Mar 2014 15:21:19 +0900
> > Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> wrote:
> > 
> > > When a frame is rejected by br_allowed_ingress(), the skb is not freed.
> > > 
> ...
> > Increment dev->tx_dropped?
> 
> OK, I'll rework it.

After investigating bridge codes, I found br_cpu_netstats doesn't have
tx_dropped field.
I'm thinking about adding that field, but it seems to be appropriate for
net-next. I'm resending this patch as is for now.

Thanks,
Toshiaki Makita

