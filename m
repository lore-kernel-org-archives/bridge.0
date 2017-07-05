Return-Path: <prvs=3528a6f25=eduval@lab126.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
	t=1499270724; x=1530806724;
	h=date:from:to:cc:subject:message-id:references:
	mime-version:in-reply-to;
	bh=yEwGL7natqJa7Umvy088891IHh7Zat33hZL6j9ZWgHo=;
	b=vGSzbjwoZ7x5NItMeSb7Et9U8yPYEwOnDSPirUECL6z0ZprCKPeCzvdu
	FsI02mPJvALvt77TvQyFSbT1gRd0xfpOu55k7qgZGM5EeizDV6J3/Etaq
	IUuIwE9mrIc5NpF/FsqZh2gjqhjrKr459hKclMnk+cJw+LXkd/UC+kozS 0=;
Date: Wed, 5 Jul 2017 09:05:14 -0700
From: Eduardo Valentin <eduval@amazon.com>
Message-ID: <20170705160514.GA11351@u40b0340c692b58f6553c.ant.amazon.com>
References: <1499101594-22421-1-git-send-email-eduval@amazon.com>
	<20170704.014842.1942928249505987408.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170704.014842.1942928249505987408.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH 1/1] bridge: mdb: report complete_info ptr as
 not a kmemleak
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Tue, Jul 04, 2017 at 01:48:42AM -0700, David Miller wrote:
> From: Eduardo Valentin <eduval@amazon.com>
> Date: Mon, 3 Jul 2017 10:06:34 -0700
> 
> > We currently get the following kmemleak report:
>  ...
> > This patch flags the complete_info ptr object as not a leak as it will
> > get freed when .complete_priv() is called,
> 
> We don't call .complete_priv().  We call .complete().

True, I can fix this wording in the commit next version.

> 
>  for the br mdb case, it
> > will be freed at br_mdb_complete().
> > 
> > Cc: stable <stable@vger.kernel.org> # v4.9+
> > Reviewed-by: Vallish Vaidyeshwara <vallish@amazon.com>
> > Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> 
> I don't understand why kmemleak cannot see this.
> 
> We store the pointer globally when we do the switchdev_port_obv_add()
> call and it should be able to see that.

I see and agree. But even then I get these reports consistently on RTM_NEWMDB type.
This is why I am proposing marking as a non-kmemleak.

To me, this is only a leak if .complete() never gets called.


-- 
All the best,
Eduardo Valentin
