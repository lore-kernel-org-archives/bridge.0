Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=4wY0puZ76rUC3DSckf3mPRYmF7SPUJuOAo8CaB7ZdL0=;
	b=ek6qJHh8grpDMf9DPB7XyzKQm9N39M5jVmFc2DDmCOdXTzqoHVHoDqoDk1YCR2lIOn
	oAbO+mrAMtobesvvsCq+HgShDk7X2zlvDeGqfsqa/NjjwWGs33Qrni2SlvGQSGrbholN
	0HekEIdqh5fmessXGirxHkOVY6vFbk6n+jk3o=
References: <20190814144024.9710-1-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <81258876-5f03-002c-5aa8-2d6d00e6d99e@cumulusnetworks.com>
Date: Wed, 14 Aug 2019 19:01:41 +0300
MIME-Version: 1.0
In-Reply-To: <20190814144024.9710-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/4] net: bridge: mdb: allow
 dump/add/del of host-joined entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 8/14/19 5:40 PM, Nikolay Aleksandrov wrote:
> Hi,
> This set makes the bridge dump host-joined mdb entries, they should be
> treated as normal entries since they take a slot and are aging out.
> We already have notifications for them but we couldn't dump them until
> now so they remained hidden. We dump them similar to how they're
> notified, in order to keep user-space compatibility with the dumped
> objects (e.g. iproute2 dumps mdbs in a format which can be fed into
> add/del commands) we allow host-joined groups also to be added/deleted via
> mdb commands. That can later be used for L2 mcast MAC manipulation as
> was recently discussed. Note that iproute2 changes are not necessary,
> this set will work with the current user-space mdb code.
> 
> Patch 01 - a trivial comment move
> Patch 02 - factors out the mdb filling code so it can be
>            re-used for the host-joined entries
> Patch 03 - dumps host-joined entries
> Patch 04 - allows manipulation of host-joined entries via standard mdb
>            calls
> 
> Thanks,
>  Nik
> 
> Nikolay Aleksandrov (4):
>   net: bridge: mdb: move vlan comments
>   net: bridge: mdb: factor out mdb filling
>   net: bridge: mdb: dump host-joined entries as well
>   net: bridge: mdb: allow add/delete for host-joined groups
> 
>  net/bridge/br_mdb.c       | 171 +++++++++++++++++++++++++-------------
>  net/bridge/br_multicast.c |  24 ++++--
>  net/bridge/br_private.h   |   2 +
>  3 files changed, 133 insertions(+), 64 deletions(-)
> 

Self-NAK
There's a double notification sent for manual add/del of host groups.
It's a trivial fix, I'll spin v2 later after running more tests.

