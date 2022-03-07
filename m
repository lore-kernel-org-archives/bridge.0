Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=/BTt8YfLqIyHV2xz5yac4//kRwc8vucWlkgPD1H5W5U=;
 b=geSKUfzqH0ywLbmlSI4UD7XWu1DZAlvfys+W7vVP+VziMkRy9OPLCGWNyAdIXt1Bk5
 h809Vnkn1UErlMBAksU9IxSwTd3AvnT4UYUsCk8Fbj3N7QPq2u4sVhQA/K7918afijZ/
 +nXawLyl8sKtpITj3idcFoayKBWNTF8YEL15U34F09L97BWaO82jpZjN3qn9i5EP/WcK
 YqYWxTW8LazUdo+MmCRa9MQupXERDJ2rNoYVtiqDZr8AJPrvVKVP838BI0qFTNRs0JMg
 L2C3s4WjE0o6b0WRiadxWMjVi1woqYDlUuZc2YWb8XtkniDw4Hj87xdrKekXMDgAW0uC
 W9aA==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <5d3acf32-9875-de6d-7495-5e4860fb88f1@nvidia.com>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-4-tobias@waldekranz.com>
 <53EED92D-FEAC-4CC6-AF2A-52E73F839AB5@blackwall.org>
 <5d3acf32-9875-de6d-7495-5e4860fb88f1@nvidia.com>
Date: Mon, 07 Mar 2022 16:03:07 +0100
Message-ID: <871qzdolec.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2 net-next 03/10] net: bridge: mst: Support
 setting and reporting MST port states
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Ido Schimmel <idosch@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On Tue, Mar 01, 2022 at 17:53, Roopa Prabhu <roopa@nvidia.com> wrote:
> On 3/1/22 15:19, Nikolay Aleksandrov wrote:
>> On 1 March 2022 11:03:14 CET, Tobias Waldekranz <tobias@waldekranz.com> wrote:
>>> Make it possible to change the port state in a given MSTI. This is
>>> done through a new netlink interface, since the MSTIs are objects in
>>> their own right. The proposed iproute2 interface would be:
>>>
>>>     bridge mst set dev <PORT> msti <MSTI> state <STATE>
>>>
>>> Current states in all applicable MSTIs can also be dumped. The
>>> proposed iproute interface looks like this:
>>>
>>> $ bridge mst
>>> port              msti
>>> vb1               0
>>> 		    state forwarding
>>> 		  100
>>> 		    state disabled
>>> vb2               0
>>> 		    state forwarding
>>> 		  100
>>> 		    state forwarding
>>>
>>> The preexisting per-VLAN states are still valid in the MST
>>> mode (although they are read-only), and can be queried as usual if one
>>> is interested in knowing a particular VLAN's state without having to
>>> care about the VID to MSTI mapping (in this example VLAN 20 and 30 are
>>> bound to MSTI 100):
>>>
>>> $ bridge -d vlan
>>> port              vlan-id
>>> vb1               10
>>> 		    state forwarding mcast_router 1
>>> 		  20
>>> 		    state disabled mcast_router 1
>>> 		  30
>>> 		    state disabled mcast_router 1
>>> 		  40
>>> 		    state forwarding mcast_router 1
>>> vb2               10
>>> 		    state forwarding mcast_router 1
>>> 		  20
>>> 		    state forwarding mcast_router 1
>>> 		  30
>>> 		    state forwarding mcast_router 1
>>> 		  40
>>> 		    state forwarding mcast_router 1
>>>
>>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>>> ---
>>> include/uapi/linux/if_bridge.h |  16 +++
>>> include/uapi/linux/rtnetlink.h |   5 +
>>> net/bridge/br_mst.c            | 244 +++++++++++++++++++++++++++++++++
>>> net/bridge/br_netlink.c        |   3 +
>>> net/bridge/br_private.h        |   4 +
>>> 5 files changed, 272 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
>>> index b68016f625b7..784482527861 100644
>>> --- a/include/uapi/linux/if_bridge.h
>>> +++ b/include/uapi/linux/if_bridge.h
>>> @@ -785,4 +785,20 @@ enum {
>>> 	__BRIDGE_QUERIER_MAX
>>> };
>>> #define BRIDGE_QUERIER_MAX (__BRIDGE_QUERIER_MAX - 1)
>>> +
>>> +enum {
>>> +	BRIDGE_MST_UNSPEC,
>>> +	BRIDGE_MST_ENTRY,
>>> +	__BRIDGE_MST_MAX,
>>> +};
>>> +#define BRIDGE_MST_MAX (__BRIDGE_MST_MAX - 1)
>>> +
>>> +enum {
>>> +	BRIDGE_MST_ENTRY_UNSPEC,
>>> +	BRIDGE_MST_ENTRY_MSTI,
>>> +	BRIDGE_MST_ENTRY_STATE,
>>> +	__BRIDGE_MST_ENTRY_MAX,
>>> +};
>>> +#define BRIDGE_MST_ENTRY_MAX (__BRIDGE_MST_ENTRY_MAX - 1)
>>> +
>>> #endif /* _UAPI_LINUX_IF_BRIDGE_H */
>>> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
>>> index 0970cb4b1b88..4a48f3ce862c 100644
>>> --- a/include/uapi/linux/rtnetlink.h
>>> +++ b/include/uapi/linux/rtnetlink.h
>>> @@ -192,6 +192,11 @@ enum {
>>> 	RTM_GETTUNNEL,
>>> #define RTM_GETTUNNEL	RTM_GETTUNNEL
>>>
>>> +	RTM_GETMST = 124 + 2,
>>> +#define RTM_GETMST	RTM_GETMST
>>> +	RTM_SETMST,
>>> +#define RTM_SETMST	RTM_SETMST
>>> +
>> I think you should also update selinux  (see nlmsgtab.c)
>> I'll think about this one, if there is some nice way to avoid the new rtm types.
>
> yes, since these are all port attributes, seems like 'bridge link set' 
> should work
>
> Tobias, can you pls check if extending RTM_SETLINK (with AF_BRIDGE) is 
> an option here ?
>
> ie via br_setlink

Yeah that makes sense. Not sure how I convinced myself that I needed a
separate rtm type for it. I will give it a try. Thanks!
