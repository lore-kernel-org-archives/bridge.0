Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=3fQhBX6V5vYsjhh8PtZm7PQQKeMuS3j7T5FSK4JWt8Q=;
	b=eMVW3JKA+Co/hvf30G6tBS44mF0bjdNoVkKQ7KEYxGZbZn15fuwnLsk9QlrxJjKMtp
	XcY3XqfhsgjaY/r5M/nu9+Ne52+ZVTXJHN9tJPDgWSd4jmTDq91VzMyjCc1xbe+0JPlb
	RfPY68goIjOf4y4gK+LeI0cmcosQyTx0aEDFc=
References: <1508428499-32355-1-git-send-email-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <01c5bff2-cb5d-2b52-b11b-d6c2e1ab52a8@cumulusnetworks.com>
Date: Thu, 19 Oct 2017 19:10:11 +0300
MIME-Version: 1.0
In-Reply-To: <1508428499-32355-1-git-send-email-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/2] bridge: make setlink/dellink
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

On 19/10/17 18:54, Nikolay Aleksandrov wrote:
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
> nothing changed, so we use EEXIST to signal that and in order not to break
> overlapping vlan range add or script return expectations we clear it on
> return, the functions used by vlan add are not expected to return EEXIST.
> 
> Thanks,
>  Nik
> 
> Nikolay Aleksandrov (2):
>   bridge: netlink: make setlink/dellink notifications more accurate
>   bridge: vlan: return EEXIST on add if nothing changed
> 
>  net/bridge/br_netlink.c        | 49 ++++++++++++++++++++++++++----------------
>  net/bridge/br_netlink_tunnel.c | 14 +++++++-----
>  net/bridge/br_private_tunnel.h |  3 ++-
>  net/bridge/br_vlan.c           | 38 +++++++++++++++++++++-----------
>  4 files changed, 68 insertions(+), 36 deletions(-)
> 

Self-NAK
Dave, please ignore this set and apologies for the noise.

I'd actually prefer to send "changed" down to vlan_add and vlan_del
to be set there instead of overloading EEXIST like that. It will be safer.

I'll wait for some comments about the rest of the change and will send
a v2.

Thanks,
 Nik

