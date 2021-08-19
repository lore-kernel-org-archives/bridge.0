Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=GClqOFxFEfC+krefx64HgWgWYCi/YRwdN7djuSeQf4U=;
 b=sDyifaj3eNNHcpO2QoAnYYjlFqNV9jsxHXWLw0hSH9gHYupXSH3AYMPL4D+7gce/M8
 36FyYRX9os3bv8RjgqqSA7vtD37MAAV0op6s+l8oviK9LVXDw6R6RplgFscWEvxwO+rJ
 Ge9r5BRcZwWqWWybi8Wnn6asbhxxdG19/P8jQA9WsHBAYdkNvyfAfOGFJcNQjqpFUV/8
 b+fKeKUQ7sQhtmwE9pZ/pbEhG31qmnYtCATiIjzCYoKqWW0gkG4ns80qrO6zmq0FLWKG
 E9T7HmeTcHkQhCRAEK/iHE8isQVJ8vbdLP5cfs+khY4yvOsRLDMhT1XhmKTptu90f8KD
 DoXg==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <20210719170637.435541-1-razor@blackwall.org>
References: <20210719170637.435541-1-razor@blackwall.org>
Date: Thu, 19 Aug 2021 18:01:05 +0200
Message-ID: <875yw1qv9a.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 00/15] net: bridge: multicast: add
	vlan support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

Hi Hik, everyone!

On Mon, Jul 19, 2021 at 20:06, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> This patchset adds initial per-vlan multicast support, most of the code
> deals with moving to multicast context pointers from bridge/port pointers.

Awesome work, this looks very interesting! :)  I've already built and
tested net-next for regressions on Marvell SOHO switches, looking good
so far.

Curious, are you planning querier per-vlan, including use-ifaddr support
as well?  In our in-house hack, which I posted a few years ago, we added
some "dumpster diving" to inet_select_addr(), but it got rather tricky.
So I've been leaning towards having that in userspace instead.

> Future patch-sets which build on this one (in order):
>  - iproute2 support for all the new uAPIs

I'm very eager to try out all the new IGMP per-VLAN stuff, do you have
any branch of the iproute2 support available yet for testing?  For now
I've hard-coded BROPT_MCAST_VLAN_SNOOPING_ENABLED in br_multicast_init()
as a workaround, and everything seems to work just as expected :-)

Best regards
 /Joachim
