Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiFr4UXVWRFb/6C8p7jnlDkwt3rG7oVdtJXfRKbpS0M=;
 b=p0tvaTV/X0+RNgHLJ9m/n9RT+blHeMGQ+HP0Zoqro62XuDIEja/9hJ5bZQyj+6CuxtM+bqOPAJ8x+KqnxUhAGZdtJCGTaJce/SzpKYSKC4YiA2Bz+hMLwdHG9JHQbGz7c7Pd0bRBLCSnGsxjsEkbQ67OhssT8Z2Nh6k4BG3r6kw=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Fri, 16 Oct 2020 16:50:22 +0000
Message-ID: <20201016165021.fjrxiwofwfqespei@skbuf>
References: <20201015173355.564934-1-vladimir.oltean@nxp.com>
 <ed19387091755aee165c074983776f37f2b87892.camel@nvidia.com>
In-Reply-To: <ed19387091755aee165c074983776f37f2b87892.camel@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01BB5C912E1F944C867A03D3C92DBCC5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH] net: bridge: call br_multicast_del_port
 before the port leaves
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

On Fri, Oct 16, 2020 at 01:43:06PM +0000, Nikolay Aleksandrov wrote:
> It can potentially use after free, multicast resources (per-cpu stats) ar=
e freed
> in br_multicast_del_port() and can be used due to a race with port state
> sync on other CPUs since the handler can still process packets. That has =
a
> chance of happening if vlans are not used.

Interesting, thanks for pointing this out, I haven't observed
use-after-free in my limited testing of this patch.

> Interesting that br_stp_disable_port() calls br_multicast_disable_port() =
which
> flushes all non-permanent mdb entries, so I'm guessing you have problem o=
nly
> with permanent ones?

Indeed, I'm testing out your L2 multicast patch.

> Perhaps we can flush them all before. Either by passing an argument to
> br_stp_disable_port() that we're deleting the port which will be
> passed down to br_multicast_disable_port() or by calling an additional
> helper to flush all which can be re-used by both disable_port() and
> stop_multicast() calls. Adding an argument to br_stp_disable_port() to
> be passed down sounds cleaner to me. What do you think?

That sounds a bit complicated, to be honest.
In fact, the reason why I submitted this as RFC only is because it isn't
solving all my problems. You know that saying "- it hurts when I do that
- then don't do that"? I think I can just change the ocelot driver to
stop remapping the untagged MDB entries to its pvid, and then I can drop
all my charges to the bridge driver.=
