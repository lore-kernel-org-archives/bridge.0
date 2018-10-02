Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Date: Tue, 02 Oct 2018 17:56:41 +0200
Message-ID: <1694684.hdcNQnb4e4@blindfold>
In-Reply-To: <09307ccf-02d6-ce63-7030-fcc560e93f23@cumulusnetworks.com>
References: <1420505776-26827-1-git-send-email-bernhard.thaler@wvnet.at>
	<16029249.TkoLblyBmC@blindfold>
	<09307ccf-02d6-ce63-7030-fcc560e93f23@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: David Gstir <david@sigma-star.at>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, bernhard.thaler@wvnet.at, "David S. Miller" <davem@davemloft.net>

Nikolay,

Am Dienstag, 2. Oktober 2018, 16:59:31 CEST schrieb Nikolay Aleksandrov:
> Richard please check commit:
> commit 5af48b59f35c
> Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date:   Wed Sep 27 16:12:44 2017 +0300
> 
>     net: bridge: add per-port group_fwd_mask with less restrictions
>     
>     We need to be able to transparently forward most link-local frames via
>     tunnels (e.g. vxlan, qinq). Currently the bridge's group_fwd_mask has a
>     mask which restricts the forwarding of STP and LACP, but we need to be able
>     to forward these over tunnels and control that forwarding on a per-port
>     basis thus add a new per-port group_fwd_mask option which only disallows
>     mac pause frames to be forwarded (they're always dropped anyway).
>     The patch does not change the current default situation - all of the others
>     are still restricted unless configured for forwarding.
>     We have successfully tested this patch with LACP and STP forwarding over
>     VxLAN and qinq tunnels.
>     
>     Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> 
> Will this work for you ?
> It's in the bridge since v4.15.

Hmm, I *think* this is exactly what I need.
To understand it correctly, I have to set per port group_fwd_mask for both slaves
of the bridge then it will forward anything (except for PAUSE frames)?

Is there a reason why this knob is not documented in Documentation/ABI/testing/sysfs-class-net?

Thanks,
//richard



