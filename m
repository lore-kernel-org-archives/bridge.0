Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=+pGezTDM/7AOxTuR4X7Zw6n/QtvkmEMnZuULbHLAHEg=;
	b=Hq5Bkihd3tKvgKnVv4UUHfSVpN3j62eKkUCBSzml6YDu6G8EYzXqZ2qj/NgPTmrSFG
	7asKJaLW6+GSEplu0hgndTIupqnSJoayuGEKMd9gQUyNnRe4YRMt1MAplcDEvMfc4393
	lkMIoNKB1oyq49a3SsPkGZMco4u8QLvnsSFkP0iD6YM0Ne1l2H/4KHweF+Rb9GkUAnCn
	LrFAx4s4e0rkC019XRyUKaigZHeL1qfQEx4sgKF5wzxkuVDyeIlj7K79EC3zBEuWLcHL
	WhKAOUhxi0cYqhE8xLd9FGS/tXwipUw/h2MutnbjDf+VqCA2zR7y5zuemE9DYGvICOgw
	BFAA==
Date: Fri, 29 Sep 2017 08:14:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170929081420.3b069170@xeon-e3>
In-Reply-To: <1506517964-17479-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1506517964-17479-1-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add per-port
 group_fwd_mask with less restrictions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

On Wed, 27 Sep 2017 16:12:44 +0300
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> We need to be able to transparently forward most link-local frames via
> tunnels (e.g. vxlan, qinq). Currently the bridge's group_fwd_mask has a
> mask which restricts the forwarding of STP and LACP, but we need to be able
> to forward these over tunnels and control that forwarding on a per-port
> basis thus add a new per-port group_fwd_mask option which only disallows
> mac pause frames to be forwarded (they're always dropped anyway).
> The patch does not change the current default situation - all of the others
> are still restricted unless configured for forwarding.
> We have successfully tested this patch with LACP and STP forwarding over
> VxLAN and qinq tunnels.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

LACP is fine, but STP must not be forwarded if STP in user or kernel
mode is enabled.

Please update this patch or revert it.
