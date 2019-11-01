Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=o8ofZ8eXn+g9/RF1tzn7A+DDx4j3eT/FW3TtKGM6VyE=;
	b=Ng8wgICpvpl1MfKvPqHa0mPOudn1mBAB5RoXVdSLBNf5UJWAyf9zafHKqhK4WnDrdV
	hNDUzcK7yBFt5L6iZCL9dJ4pVs2OuLBc0f0qeTMguHKgE4HCDmJXuhTbgvwtn3ejnOIL
	HHcnPMCxiafLfuGC4xBvZyDX1HauQpq/kH1Qw=
References: <20191101123844.17518-1-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <3a71de17-99ab-813f-62f2-691cde514e31@cumulusnetworks.com>
Date: Fri, 1 Nov 2019 14:40:05 +0200
MIME-Version: 1.0
In-Reply-To: <20191101123844.17518-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/3] net: bridge: minor followup
	optimizations
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

On 01/11/2019 14:38, Nikolay Aleksandrov wrote:
> Hi,
> After the converted flags to bitops we can take advantage of the flags
> assignment and remove one test and three atomic bitops from the learning
> paths (patch 01 and patch 02), patch 03 restores the unlikely() when taking
> over HW learned entries.
> 
> Thanks,
>  Nik
> 
> 
> Nikolay Aleksandrov (3):
>   net: bridge: fdb: br_fdb_update can take flags directly
>   net: bridge: fdb: avoid two atomic bitops in
>     br_fdb_external_learn_add()
>   net: bridge: fdb: restore unlikely() when taking over externally added
>     entries
> 
>  include/trace/events/bridge.h | 12 ++++++------
>  net/bridge/br_fdb.c           | 30 +++++++++++++++---------------
>  net/bridge/br_input.c         |  4 ++--
>  net/bridge/br_private.h       |  2 +-
>  4 files changed, 24 insertions(+), 24 deletions(-)
> 


Aaargh.. apologies for the noise, the script caught an older set export.
Will re-post a proper v2 in a minute.


