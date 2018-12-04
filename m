Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=hgMJTfA3ueoaaUtP7rsX0bwqN67h0jxXFRr4Ml/aQVQ=;
	b=UCjStgkHaBI2zkWn8RnpjyE6+bq0QVHNMAnbmwIXfH+9zcvYAGQghQe6fSLqkSszNw
	7+k2Ll2SL84jWPCrxG98KVghf1wJnvNPhct31TUeZTiT4iWiOkW2pFJQ3G8A3R5ffOzA
	iZ8PvQ/tHcYcJBmId5xwb1V+TXqbFyASd02go=
References: <20181204150119.26395-1-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <4e004521-2a99-f3f1-6603-98adedcb0441@cumulusnetworks.com>
Date: Tue, 4 Dec 2018 17:27:34 +0200
MIME-Version: 1.0
In-Reply-To: <20181204150119.26395-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/3] net: bridge: convert multicast
 to generic rhashtable
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

On 04/12/2018 17:01, Nikolay Aleksandrov wrote:
> Hi,
> The current bridge multicast code uses a custom rhashtable
> implementation which predates the generic rhashtable API. Patch 01
> converts it to use the generic kernel rhashtable which simplifies the
> code a lot and removes duplicated functionality. The convert also makes
> hash_elasticity obsolete as the generic rhashtable already has such
> checks and has a fixed elasticity of RHT_ELASTICITY (16 currently) so we
> emit a warning whenever elasticity is set and return RHT_ELASTICITY when
> read (patch 02). Since now we have the generic rhashtable which
> autoshrinks we can be more liberal with the default hash maximum so patch
> 03 increases it to 4096 and moves it to a define in br_private.h.
> 
> v2: send the latest version of the set which handles when IGMP snooping
>     is not defined, changes are in patch 01
> 
> Thanks,
>  Nik
> 
> 
> Nikolay Aleksandrov (3):
>   net: bridge: convert multicast to generic rhashtable
>   net: bridge: mark hash_elasticity as obsolete
>   net: bridge: increase multicast's default maximum number of entries
> 
>  net/bridge/br_device.c    |  10 +
>  net/bridge/br_mdb.c       | 120 +++++------
>  net/bridge/br_multicast.c | 406 +++++++-------------------------------
>  net/bridge/br_netlink.c   |  11 +-
>  net/bridge/br_private.h   |  41 ++--
>  net/bridge/br_sysfs_br.c  |   6 +-
>  6 files changed, 156 insertions(+), 438 deletions(-)
> 

+CC bridge list.

Cheers,
 Nik

