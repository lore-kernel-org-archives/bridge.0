Return-Path: <soohoon@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=WjKsdQD8xTd+3+WJpqGwV1jnC6A/32W8nLjyKOfIDSY=;
	b=fmx87J2iFahEZVfM88wXcEnHeRLhbspbj5b3zMgkq9Vdb+VnJcdbAIT4Au/b0m9xd7
	PJSlqrI02ntO20Wc2j3yooAZDuh8YE1FA5L9O/yTUuvqsSPWt0jxKBq+2+TuXoszcQig
	Qkb94f7X/b2xxHeuWYU1+Rvb6L+DZyM1KlZ6lp+XUB8+ExA4YsNdmZnITLl2LULg0VdC
	XkVJoRc8ItVYorRP6j6feVxetN8AfxSIuFpaJSX0EZ9AoVrMYr9VqK01hm4pcvhb0iiD
	WzmfNEGzakRGE14Ej0XfS99stP+itvvDaUHQp0ibm1dL2fI3TepQNIbg1M20LGHFyrHJ
	qfNQ==
MIME-Version: 1.0
From: Soohoon Lee <soohoon@gmail.com>
Date: Tue, 23 Oct 2018 10:22:24 -0500
Message-ID: <CABkmPjTsn31GSE7MPFzsKcQLGTYJk2KmDr_0uvK_q4+wvwtdxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Bridge] !vlan_enabled but programs pvid
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi, I'm a bridge newbie.

I found that vlan_enabled is 0 by default but the bridge still
programs PVID and it rejects adding interface if programming PVID
fails.

I got this symptom since CentOS/RHEL 7.4 and this change is making the
difference.

br_vlan.c:
> -           if (p && p->br->vlan_enabled)) {
> +          if (p) {
                      err = vlan_vid_add(dev, br->vlan_proto, vid);

more details about the environment is

AWS m4.xlarge with ixgbevf.
ixgbevf failed in this function when it tries to program PVID.

drivers/net/ethernet/intel/ixgbevf/vf.c:
 static s32 ixgbevf_set_vfta_vf(struct ixgbe_hw *hw, u32 vlan, u32 vind,
...
        err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
                                         sizeof(msgbuf) / sizeof(u32));
...
        if (msgbuf[0] != (IXGBE_VF_SET_VLAN | IXGBE_VT_MSGTYPE_ACK))

the msbuf has NACK in it.

What would be a good fix for this?

Thanks
Soohoon
