Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding;
	bh=Mt+0LP2suu/UmdAF/Ar1i+pd1yOse8wj8Msi8gTtWDU=;
	b=aZIa/O5yvr8slCdMa0cyCuoFZV2BJiIe2hW2PqVWZ/Ap50SDzI2yetUwTRL1SUZ4qM
	BCzNsO/KaV9aE3UFdH904WqYFgt85qtXIOkwY7paU2mpPIUHhwLppxb6UhIoIFfRSQUc
	mn1tnWwR7DkG7dphPmRCpsfZixRYL8tr3+NUXxUhaigOXU/7Cuu8OGJBRs1UxaTSPSoA
	2eWx3vU6M7e1xr29KIF8MZoc1oPlB1UJD2isV65AyFPfkapGDTgDaEz2OlHTcfJmvKvB
	zvMY/Q2nC7neWbsNQl8rnpNG/fn4h2l4WU9DOrwclMA/Hyl6/Rxr1BltF14Ke0lWv1bS
	2lPA==
Message-ID: <1395245350.1741.6.camel@localhost.localdomain>
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
Date: Thu, 20 Mar 2014 01:09:10 +0900
In-Reply-To: <CAB=NE6VL8LCGa5aqm8qpgwHywwvVb8gjNQFKic_Dq9zdg-8hDQ@mail.gmail.com>
References: <1394680527-28970-1-git-send-email-mcgrof@do-not-panic.com>
	<1394680527-28970-2-git-send-email-mcgrof@do-not-panic.com>
	<5328E802.3030901@lab.ntt.co.jp>
	<CAB=NE6X2eZFLWBN1acf=d75T_K2YM_OK3oaXEPu-hwpUJEmwkg@mail.gmail.com>
	<5328ED25.1040900@lab.ntt.co.jp>
	<CAB=NE6VL8LCGa5aqm8qpgwHywwvVb8gjNQFKic_Dq9zdg-8hDQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/3] bridge: preserve random init MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, xen-devel@lists.xenproject.org

On Tue, 2014-03-18 at 18:10 -0700, Luis R. Rodriguez wrote:
> On Tue, Mar 18, 2014 at 6:04 PM, Toshiaki Makita
> <makita.toshiaki@lab.ntt.co.jp> wrote:
> > (2014/03/19 9:50), Luis R. Rodriguez wrote:
> >> On Tue, Mar 18, 2014 at 5:42 PM, Toshiaki Makita
> >> <makita.toshiaki@lab.ntt.co.jp> wrote:
> >>> nit,
> >>> If the last detached port happens to have the same addr as
> >>> random_init_addr, this seems to call br_stp_change_bridge_id() even
> >>> though bridge_id is not changed.
> >>
> >> Ah good point.
> >>
> >>> Shouldn't the assignment of random_init_addr be done before the check of
> >>> "no change"?
> >>
> >> Good question, should we even allow two ports to have the same MAC
> >> address or should we complain and refuse to add it? If so that should
> >> mean we should also have to monitor any manual address changes or
> >> events for address changes on the ports.
> >
> > This was recently discussed by Stephen and me.
> > I'm thinking it should be allowed.
> >
> > http://marc.info/?l=linux-netdev&m=139182743919257&w=2
> 
> Great now that that's sorted out though I still think calling
> br_stp_change_bridge_id() is right just as calling the update features
> as the device is different. It could however be confusing when this
> situation is run and folks might report odd bugs unless we could tell
> them apart clearly. Thoughts?

br_stp_change_bridge_id() is currently called only if bridge_id.addr
should be changed.
If the addr should not be changed but some updates are needed,
br_stp_recalculate_bridge_id() doesn't seem to fit into it.

Toshiaki Makita

