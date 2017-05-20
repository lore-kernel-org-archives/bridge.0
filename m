Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=HYDa4u0C8LzzGhtlqYm5jEoYH/h3tuB2FGruj+mgVaM=;
	b=Yv/hZFyBKfHsnuAmCHRSDrV944KdmWO31WxgfBze1lcrkYYom7UX1ADDkEdqtyVM8W
	N8pl5CnzkE6Yum/kS2ZwXs1KvDgTqHZTv35BFeh5dt3fu6Hk5Z/QHFbj0aVmD/R0OT7O
	DibF2ZqBJOrC6kiNF4rMVbjMkCJbp2DZlh9Az+Jxe4m5J7owXoUSNtSE0Y+R22Z21yv4
	jU5YnO9x2nUIF/8vmbg2cSxQb4SdAlLNLviG6UIq2kNBVKit6U6E1mFvbNtjVxvGumdP
	IjY9mIPpH3meTCiIICSMhjC0wT1poUwaVLrQT3BqhTPRz6rJbB03LEWmSMPb7KAWAfsH
	ZHfg==
Date: Sat, 20 May 2017 15:47:48 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <20170520074748.GB12974@leo.usersys.redhat.com>
References: <20170519173043.10201-1-cera@cera.cz>
	<20170520055720.GA12974@leo.usersys.redhat.com>
	<CA+Nub0aY6hjWeg8h2Qgx_c+yazh5WnA1u0D8bDtxChjWXsEHSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Nub0aY6hjWeg8h2Qgx_c+yazh5WnA1u0D8bDtxChjWXsEHSw@mail.gmail.com>
Subject: Re: [Bridge] [PATCH net-next v2] bridge: fix hello and hold timers
 starting/stopping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: ivan.vecera@cera.cz
Cc: Xin Long <lucien.xin@gmail.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, network dev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

On Sat, May 20, 2017 at 09:06:16AM +0200, Ivan Vecera wrote:
> 2017-05-20 7:57 GMT+02:00 Hangbin Liu <liuhangbin@gmail.com>:
> > On Fri, May 19, 2017 at 07:30:43PM +0200, Ivan Vecera wrote:
> >> Current bridge code incorrectly handles starting/stopping of hello and
> >> hold timers during STP enable/disable.
> >>
> >> 1. Timers are stopped in br_stp_start() during NO_STP->USER_STP
> >>    transition. The timers are already stopped in NO_STP state so
> >>    this is confusing no-op.
> >
> > Hi Ivan,
> >
> > Shouldn't we start hello timer in br_stp_start when NO_STP -> BR_KERNEL_STP ?
> 
> As Nikolay mentioned, this is fixed by
> https://patchwork.ozlabs.org/patch/764685/

Ah, sorry. My mistake. I only saw xin's patch and your v2 patch. So I mixed
them up and thought this is xin's V2 patch. That's why I wonder we didn't
start hello timer in br_stp_start...

Now I see your v1 patch with:

The patch is a follow-up for "bridge: start hello_timer when enabling
KERNEL_STP in br_stp_start" patch from Xin Long."

Sorry for mixed them up.
> 
> >>
> >> 2. During USER_STP->NO_STP transition the timers are started. This
> >>    does not make sense and is confusion because the timer should not be
> >>    active in NO_STP state.
> >
> > Yes, but what about BR_KERNEL_STP -> NO_STP in function br_stp_stop() ?
> 
> The timer is lazily stopped by itself in its handler... or not rearmed
> respectively.

Yes, with xin's patch this timer will stoped by itself.

Thanks
Hangbin
