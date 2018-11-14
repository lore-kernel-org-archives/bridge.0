Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=vbiJI7CyvgdtxZzSiCa0MpQOpOPBTo+eunXzR98Bo1Y=;
	b=W604SmVt63+PqxBtHkUYLUwhSgmP4S7YB8YxHWv1MmnS5hRV+XUdH33o4U45zQk2cC
	FoJl0mNCz5W9nAdjI0n1WlBL+dJfRsU1y/9IQUahNH4YQiGa0Go+zy5xJ6QPnmmnrg0J
	Setumi1YpD5EVphq2WVntklBsNtcmWW9Evx/Y=
References: <00000000000047feb5057a714975@google.com>
	<20181113010154.13935-1-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <ae147dd3-1ad8-8b8b-93f1-09297171883a@cumulusnetworks.com>
Date: Wed, 14 Nov 2018 19:08:38 +0200
MIME-Version: 1.0
In-Reply-To: <20181113010154.13935-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fix per-port vlan stats
 use-after-free on destruction
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, davem@davemloft.net

On 11/13/18 3:01 AM, Nikolay Aleksandrov wrote:
> Syzbot reported a use-after-free of the global vlan context on port vlan
> destruction. When I added per-port vlan stats I missed the fact that the
> global vlan context can be freed before the per-port vlan rcu callback.
> There're a few different ways to deal with this, I've chosen to add a
> new private flag that is set only when per-port stats are allocated so
> we can directly check it on destruction without dereferencing the global
> context at all. The flag is internally controlled by the kernel and
> user-space isn't allowed to set it.
> 
> Fixes: 9163a0fc1f0c ("net: bridge: add support for per-port vlan stats")
> Reported-by: syzbot+04681da557a0e49a52e5@syzkaller.appspotmail.com
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---

I'll post v2 with a cosmetic change - move the check up one level where
it's more logical to be and the rest of the checks are done.



