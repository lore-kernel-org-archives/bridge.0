Return-Path: <soohoon@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=zDNZue5EOL6mNvQjQ6Kpw51Lk2kNsKDKSE6+gMawiHI=;
	b=K5lgrCtiEyKcMo20A90mTsYs0NkIJezsI6+ykGPDpVMOFXROc+7KcU02z2mTtawkAC
	GlGjpJxdLTrpz6Qy1hDCj9ssE45uPUsFG9PCYO3xeRAFK5OESqI0JjLZS0xXraYckWUP
	QPWC4yp0q566fU/l07+K5MVisEbzwynLVJyUGAbBUe+tKTaU/O7rUvwP+pkpEjScEcjt
	EjJ50pZxD26fKju3ctylvA+M6/aMf8zcUxT+J+Mp+O7xfxGC5Azv/6HbZiTYnmb8tOoz
	ZBHaAOztcdyx73UN2/7hf1q18M2vx7s3vbijTvdMBANpg/h6d0n41Y4kw985AkvbPzxC
	vEPw==
MIME-Version: 1.0
References: <CABkmPjTsn31GSE7MPFzsKcQLGTYJk2KmDr_0uvK_q4+wvwtdxQ@mail.gmail.com>
In-Reply-To: <CABkmPjTsn31GSE7MPFzsKcQLGTYJk2KmDr_0uvK_q4+wvwtdxQ@mail.gmail.com>
From: Soohoon Lee <soohoon@gmail.com>
Date: Tue, 23 Oct 2018 18:15:48 -0400
Message-ID: <CABkmPjRidqu1YT783GS7nvd=sCuYxg54YYOzEjmk43ZF7Bag=g@mail.gmail.com>
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
To: bridge@lists.linux-foundation.org

It's reproduced in XEN environment.
And found that vlan support is disabled in ixgbe driver.

So then my question again is what does vlan_enabled flag do?
If vlan_enabled == 0 then the bridge driver shouldn't do any vlan thing?



On Tue, Oct 23, 2018 at 11:22 AM Soohoon Lee <soohoon@gmail.com> wrote:
>
> Hi, I'm a bridge newbie.
>
> I found that vlan_enabled is 0 by default but the bridge still
> programs PVID and it rejects adding interface if programming PVID
> fails.
>
> I got this symptom since CentOS/RHEL 7.4 and this change is making the
> difference.
>
> br_vlan.c:
> > -           if (p && p->br->vlan_enabled)) {
> > +          if (p) {
>                       err = vlan_vid_add(dev, br->vlan_proto, vid);
>
> more details about the environment is
>
> AWS m4.xlarge with ixgbevf.
> ixgbevf failed in this function when it tries to program PVID.
>
> drivers/net/ethernet/intel/ixgbevf/vf.c:
>  static s32 ixgbevf_set_vfta_vf(struct ixgbe_hw *hw, u32 vlan, u32 vind,
> ...
>         err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
>                                          sizeof(msgbuf) / sizeof(u32));
> ...
>         if (msgbuf[0] != (IXGBE_VF_SET_VLAN | IXGBE_VT_MSGTYPE_ACK))
>
> the msbuf has NACK in it.
>
> What would be a good fix for this?
>
> Thanks
> Soohoon
