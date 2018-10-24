Return-Path: <soohoon@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=zooHOq4sSm0oQX7N9v39BSdY5IteTM+MvCGgM+9vJqw=;
	b=ZitYPXU0ZQQMMSiCWIhXzTWS+AL0TrcJqgo0+yU5Tz04qwNw/jJ78FBUjSUMS9YDor
	MvFCadU9c7b4kb8QouMaZeuFNtalihlNAM746ZENqCcqs3yZtq1OUk19W5foibYdFMx+
	CJ/L5MKSCFDxf6+u9YlVZ7KJQg5VtH+7NtTxlk149pWzNOCRTy4L5saKgtQCCgU+zCdA
	3IKy5vhw2RaHjus9nEZ+qhiPOO5g5JAbGrJhUY1+Vc6zs4UkN+GbktLsapp/UJROhwNC
	U2ZwK6hPgOCbdIgOs6nWoC4S6MAEXujT2Z9nMn6roRfei7fJkejhANRCxpdw2XQXLNxZ
	wUng==
MIME-Version: 1.0
References: <CABkmPjTsn31GSE7MPFzsKcQLGTYJk2KmDr_0uvK_q4+wvwtdxQ@mail.gmail.com>
	<CABkmPjRidqu1YT783GS7nvd=sCuYxg54YYOzEjmk43ZF7Bag=g@mail.gmail.com>
	<94713271-056d-7bdf-eab1-ce4b22a7d1d3@lab.ntt.co.jp>
In-Reply-To: <94713271-056d-7bdf-eab1-ce4b22a7d1d3@lab.ntt.co.jp>
From: Soohoon Lee <soohoon@gmail.com>
Date: Wed, 24 Oct 2018 00:45:33 -0400
Message-ID: <CABkmPjQNcjvekx1j7cnkhG0NAoko0uK-RerytyKFgLafArh_Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] !vlan_enabled but programs pvid
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: makita.toshiaki@lab.ntt.co.jp
Cc: bridge@lists.linux-foundation.org

I think NETIF_F_HW_VLAN_CTAG_FILTER is hardcoded in ixgbevf.

ixgbevf_probe()
        netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |

Like I said in the second email, vlan support was disabled in host/ixgbe driver.

I wonder if there's any mechanism to find whether vlan is enabled in
the host/ixgbe from ixgbevf.
Otherwise it has to try vlan setting and see if it fails or not to
set/clear NETIF_F_HW_VLAN_CTAG_FILTER   flag.
On Wed, Oct 24, 2018 at 12:07 AM Toshiaki Makita
<makita.toshiaki@lab.ntt.co.jp> wrote:
>
> On 2018/10/24 7:15, Soohoon Lee wrote:
> > It's reproduced in XEN environment.
> > And found that vlan support is disabled in ixgbe driver.
> >
> > So then my question again is what does vlan_enabled flag do?
> > If vlan_enabled == 0 then the bridge driver shouldn't do any vlan thing?
>
> As I told you yesterday off-list, the problem looks like that ixgbevf is
> advertising NETIF_F_HW_VLAN_CTAG_FILTER when it cannot do it.
>
>
> > On Tue, Oct 23, 2018 at 11:22 AM Soohoon Lee <soohoon@gmail.com> wrote:
> >>
> >> Hi, I'm a bridge newbie.
> >>
> >> I found that vlan_enabled is 0 by default but the bridge still
> >> programs PVID and it rejects adding interface if programming PVID
> >> fails.
> >>
> >> I got this symptom since CentOS/RHEL 7.4 and this change is making the
> >> difference.
> >>
> >> br_vlan.c:
> >>> -           if (p && p->br->vlan_enabled)) {
> >>> +          if (p) {
> >>                       err = vlan_vid_add(dev, br->vlan_proto, vid);
> >>
> >> more details about the environment is
> >>
> >> AWS m4.xlarge with ixgbevf.
> >> ixgbevf failed in this function when it tries to program PVID.
> >>
> >> drivers/net/ethernet/intel/ixgbevf/vf.c:
> >>  static s32 ixgbevf_set_vfta_vf(struct ixgbe_hw *hw, u32 vlan, u32 vind,
> >> ...
> >>         err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
> >>                                          sizeof(msgbuf) / sizeof(u32));
> >> ...
> >>         if (msgbuf[0] != (IXGBE_VF_SET_VLAN | IXGBE_VT_MSGTYPE_ACK))
> >>
> >> the msbuf has NACK in it.
> >>
> >> What would be a good fix for this?
> >>
> >> Thanks
> >> Soohoon
> >
> >
>
> --
> Toshiaki Makita
>
