Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CA4A60B3A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E55960B16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XjECm/4N2trZe4kiGn1Tlhopv0nTjHCSPh6BnIZekRc=;
 b=GJC3UEEPsBIMK6B7wuyDLiQdilx7IUpryQMKON/j09pU5ACdzMID0Vk7DbFTJHbYJO
 EBv1R3iqekj8rXA5waLmo4XRps+p2jAve1AP5WO7YxekxVmO3HURwiidvHjuzlghYvZ/
 CmwiEUYRADvnBOff5qAbHk+vs30ycr5dNFs2P0KniG/XND06VmEjSG7Puxcrcc78SDX/
 orisiLsTYK+idq6NCPvHmf655nX6b7j8RZHfpdB/fQ/RcGEyT9idbEy8dB6LB2WxvuB+
 2da0NW66tdJlEjGcRk+4hNq6fDm3FFcfdvJIALuua1AtKZBYKmkeJfCxdD6Kn/eJNFxd
 ZLZg==
Message-ID: <22583106-8f39-0c7e-1c61-47ec5c614418@blackwall.org>
Date: Fri, 9 Dec 2022 09:41:05 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-10-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-10-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 09/14] bridge: mcast: Add support for
 (*, G) with a source list and filter mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 08/12/2022 17:28, Ido Schimmel wrote:
> In preparation for allowing user space to add (*, G) entries with a
> source list and associated filter mode, add the necessary plumbing to
> handle such requests.
> 
> Extend the MDB configuration structure with a currently empty source
> array and filter mode that is currently hard coded to EXCLUDE.
> 
> Add the source entries and the corresponding (S, G) entries before
> making the new (*, G) port group entry visible to the data path.
> 
> Handle the creation of each source entry in a similar fashion to how it
> is created from the data path in response to received Membership
> Reports: Create the source entry, arm the source timer (if needed), add
> a corresponding (S, G) forwarding entry and finally mark the source
> entry as installed (by user space).
> 
> Add the (S, G) entry by populating an MDB configuration structure and
> calling br_mdb_add_group_sg() as if a new entry is created by user
> space, with the sole difference that the 'src_entry' field is set to
> make sure that the group timer of such entries is never armed.
> 
> Note that it is not currently possible to add more than 32 source
> entries to a port group entry. If this proves to be a problem we can
> either increase 'PG_SRC_ENT_LIMIT' or avoid forcing a limit on entries
> created by user space.
> 

That can be tricky wrt EHT. If the limit is increased we have to consider the
complexity and runtime, we might have to optimize it. In practice I think it's
rare to have so many sources, but evpn might change that. :)

> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v1:
>     * Use an array instead of a list to store source entries.
> 
>  net/bridge/br_mdb.c     | 128 +++++++++++++++++++++++++++++++++++++++-
>  net/bridge/br_private.h |   7 +++
>  2 files changed, 132 insertions(+), 3 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

