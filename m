Return-Path: <peterz@infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f9CtTdIxbf6dc734PE72amg3VhgN98RO2WcwWeTC5zc=;
	b=aG4SdRJS0ugQ1pm/9jGaY+L65
	fd/jVVizRvPlW4txd1rV3Ps3t92bjrb8/zlOmyjV6a43SYF1aUV/urFteZkNirkD1yGLAZ5u+MyLc
	0Vxt9gw7qxyhVCre8lRhQXXLUAm6fSVu9/irrbm/1bjiFV9FaIzRAh7z3dkgNd29xcMC7LiJeeTqq
	1znF4uJ6dkLKXNGufogAltFxC1cY6yYyKtO3BhNxBeixoDDAKAnNC4knAfCjssVMgEd8I2hgzXh06
	kKMdR1MWUtNfHcHa87/cCPuJloA722AmRaR3Lp95xwKH34RsQAK9pZ4YNIyb8zu5nKaUcB/I3UMDC
	bAix13QeA==;
Date: Mon, 20 Mar 2017 14:23:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
Message-ID: <20170320132357.acygo3umw6fiwb4p@hirez.programming.kicks-ass.net>
References: <1489767196.28631.305.camel@edumazet-glaptop3.roam.corp.google.com>
	<20170318164759.GA23837@gondor.apana.org.au>
	<20170318.182121.439615057765380575.davem@davemloft.net>
	<20170320103937.lq7nfnutupr3gkn7@hirez.programming.kicks-ass.net>
	<20170320131629.GA26405@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320131629.GA26405@gondor.apana.org.au>
Subject: Re: [Bridge] [PATCH 07/17] net: convert sock.sk_refcnt from
 atomic_t to refcount_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: keescook@chromium.org, eric.dumazet@gmail.com, kaber@trash.net, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmorris@namei.org, ishkamiel@gmail.com, kuznet@ms2.inr.ac.ru, akpm@linux-foundation.org, David Miller <davem@davemloft.net>, elena.reshetova@intel.com, dwindsor@gmail.com

On Mon, Mar 20, 2017 at 09:16:29PM +0800, Herbert Xu wrote:
> On Mon, Mar 20, 2017 at 11:39:37AM +0100, Peter Zijlstra wrote:
> >
> > Can we at least give a benchmark and have someone run numbers? We should
> > be able to quantify these things.
> 
> Do you realise how many times this thing gets hit at 10Gb/s or
> higher? Anyway, since you're proposing this change you should
> demonstrate that it does not cause a performance regression.

So what bench/setup do you want ran?
