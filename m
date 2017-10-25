Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=9zd6uWGu58A0hPLttwizKMxhXsG2WsPRz2CwgQrhgvg=;
	b=aDKcgMVk6zl/HibQmBsNx/z/Gyja53MEv5dzNBdz+RnzwtnejNJUMKmyKyTswD++U5
	mjXtw5lwektksUwHqk5Na1x2wXhU7N5JYrDLS6mGfpD4kxoP7ovOy/l/MxtrXdm3XNbR
	HoX7cN+OGLHd1A5pPsDjt0xIx3FFOTURpppAY=
References: <1508848362-13750-1-git-send-email-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <43f36fb0-8543-7e60-a80e-6da35d74b69a@cumulusnetworks.com>
Date: Thu, 26 Oct 2017 00:49:11 +0300
MIME-Version: 1.0
In-Reply-To: <1508848362-13750-1-git-send-email-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/2] bridge: make setlink/dellink
 notifications more accurate
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: dsa@cumulusnetworks.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, mrv@mojatatu.com

On 24/10/17 15:32, Nikolay Aleksandrov wrote:
> Hi,
> Before this set the bridge would generate a notification on vlan add or del
> even if they didn't actually do any changes, which confuses listeners and
> is generally not preferred. We could also lose notifications on actual
> changes if one adds a range of vlans and there's an error in the middle.
> The problem with just breaking and returning an error is that we could
> break existing user-space scripts which rely on the vlan delete to clear
> all existing entries in the specified range and ignore the non-existing
> errors (typically used to clear the current vlan config).
> So in order to make the notifications more accurate while keeping backwards
> compatibility we add a boolean that tracks if anything actually changed
> during the config calls.
> 
> The vlan add is more difficult to fix because it always returns 0 even if
> nothing changed, but we cannot use a specific error because the drivers
> can return anything and we may mask it, also we'd need to update all places
> that directly return the add result, thus to signal that a vlan was created
> or updated and in order not to break overlapping vlan range add we pass
> down the new boolean that tracks changes to the add functions to check
> if anything was actually updated.
> 
> Can't say that I am happy with this change, but currently I don't see any
> simpler way which doesn't affect user-space.
> 
> v2: pass changed down to vlan add instead of masking errors
> 
> Thanks,
>  Nik
> 
> Nikolay Aleksandrov (2):
>   bridge: netlink: make setlink/dellink notifications more accurate
>   bridge: vlan: signal if anything changed on vlan add
> 
>  net/bridge/br_netlink.c        | 51 ++++++++++++++++-----------
>  net/bridge/br_netlink_tunnel.c | 14 +++++---
>  net/bridge/br_private.h        |  6 ++--
>  net/bridge/br_private_tunnel.h |  3 +-
>  net/bridge/br_vlan.c           | 78 ++++++++++++++++++++++++++++++------------
>  5 files changed, 102 insertions(+), 50 deletions(-)
> 

Ah, forgot to update the non-vlan bridge config case with the empty stubs,
will send a fixed and tested v3 asap.


