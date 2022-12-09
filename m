Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9101C4014B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF19D40127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YQ4b+q/xAzhxcWk+HTn7pTbcjlOt6DHs6L/eJIRo8Q8=;
 b=pu+MvrrIHTIpdKlGXc7Y8wpmxWZCc2c/of308f6qDqoYe8LDc2TlOQskHdzymywFJ5
 oJ2FHsYAHH6CiiH0NtT7AaGqQSAnYZW5SMC2vEY0arM4Bosn+I8hSRu4Awzd2fRrpx0h
 Z37H8EvBF7l431wVPIujQngZ1Sgf2goTC4BzlA+t9vcL/Bog8IaMQAIsCxGirUAjEhvk
 ohMFWYEvpRdxVsYq+BDF1kZtvxwkGbcISJoTl92UA2QMnr6ePOOBi7pPZsugPy8eTasP
 BW/qjjsOLv3IFB45D3Z49PaH07lijie0fElo2BqSEQ92T20pgxJ5nK2hQpVkNOKMP0qI
 s5+g==
Message-ID: <ed2bb9b0-d3bd-604d-ef7d-ddd145ffd13b@blackwall.org>
Date: Fri, 9 Dec 2022 09:52:24 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221208152839.1016350-1-idosch@nvidia.com>
 <20221208152839.1016350-11-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221208152839.1016350-11-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 10/14] bridge: mcast: Allow user space
 to add (*, G) with a source list and filter mode
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
> Add new netlink attributes to the RTM_NEWMDB request that allow user
> space to add (*, G) with a source list and filter mode.
> 
> The RTM_NEWMDB message can already dump such entries (created by the
> kernel) so there is no need to add dump support. However, the message
> contains a different set of attributes depending if it is a request or a
> response. The naming and structure of the new attributes try to follow
> the existing ones used in the response.
> 
> Request:
> 
> [ struct nlmsghdr ]
> [ struct br_port_msg ]
> [ MDBA_SET_ENTRY ]
> 	struct br_mdb_entry
> [ MDBA_SET_ENTRY_ATTRS ]
> 	[ MDBE_ATTR_SOURCE ]
> 		struct in_addr / struct in6_addr
> 	[ MDBE_ATTR_SRC_LIST ]		// new
> 		[ MDBE_SRC_LIST_ENTRY ]
> 			[ MDBE_SRCATTR_ADDRESS ]
> 				struct in_addr / struct in6_addr
> 		[ ...]
> 	[ MDBE_ATTR_GROUP_MODE ]	// new
> 		u8
> 
> Response:
> 
> [ struct nlmsghdr ]
> [ struct br_port_msg ]
> [ MDBA_MDB ]
> 	[ MDBA_MDB_ENTRY ]
> 		[ MDBA_MDB_ENTRY_INFO ]
> 			struct br_mdb_entry
> 		[ MDBA_MDB_EATTR_TIMER ]
> 			u32
> 		[ MDBA_MDB_EATTR_SOURCE ]
> 			struct in_addr / struct in6_addr
> 		[ MDBA_MDB_EATTR_RTPROT ]
> 			u8
> 		[ MDBA_MDB_EATTR_SRC_LIST ]
> 			[ MDBA_MDB_SRCLIST_ENTRY ]
> 				[ MDBA_MDB_SRCATTR_ADDRESS ]
> 					struct in_addr / struct in6_addr
> 				[ MDBA_MDB_SRCATTR_TIMER ]
> 					u8
> 			[...]
> 		[ MDBA_MDB_EATTR_GROUP_MODE ]
> 			u8
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v1:
>     * Use an array instead of list to store source entries.
>     * Drop br_mdb_config_attrs_fini().
> 
>  include/uapi/linux/if_bridge.h |  20 +++++
>  net/bridge/br_mdb.c            | 130 +++++++++++++++++++++++++++++++++
>  2 files changed, 150 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

