Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 385D961008
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 509FB60B1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCv5mcp3OevYDuEm0DKpLYtXIRHAu25i6v4vZIFYA7Y=;
 b=JqvGXHxHYSpeHyu4hSymUs6BQs2wg3kX160P1ZNky+iKq6Q/wniyj1vUi4t2AAxsr1OfKhrXEW+mQ4UDaKd1tKeYWnIgxqZeDTME2gF7f5NVI6ya2ZlZhN1Unsx6IhDfVcu/8ntQHvUU2nxGbTWGRYrZRQwnL40Pf5wScJCHY0ALAO89iDIqqbKa20dDYAcEnYDwTW577aJ1C+dVLUaJDQrs+Ctw/gDN5GP9Q/0Cy0PEoJT7z8BlCg4WF2SNeicsGn9AxGLuaoeD0jjDuTO6TIWdXJr/RVcEJdOES6/qJqyNdy7RPf+/+NKx5uiU+Zx8NXuGbpn921dvPentkWQdRw==
References: <cover.1675271084.git.petrm@nvidia.com>
 <7b9f6524716a9e2ce33b9383e3216fed2f432201.1675271084.git.petrm@nvidia.com>
 <4ce2042b-26f7-00df-a035-567475add7f6@blackwall.org>
 <14fac71d-dc43-bc5c-4d77-3187e066cfc0@blackwall.org>
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 2 Feb 2023 16:02:20 +0100
In-Reply-To: <14fac71d-dc43-bc5c-4d77-3187e066cfc0@blackwall.org>
Message-ID: <87r0v8ds8m.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next mlxsw v2 08/16] net: bridge: Add
 netlink knobs for number / maximum MDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>


Nikolay Aleksandrov <razor@blackwall.org> writes:

> On 02/02/2023 10:52, Nikolay Aleksandrov wrote:
>> On 01/02/2023 19:28, Petr Machata wrote:
>>> +int br_multicast_vlan_ngroups_set_max(struct net_bridge *br,
>>> +				      struct net_bridge_vlan *v, u32 max,
>>> +				      struct netlink_ext_ack *extack)
>>> +{
>>> +	if (br_multicast_port_ctx_vlan_disabled(&v->port_mcast_ctx)) {
>>> +		NL_SET_ERR_MSG_MOD(extack, "Multicast snooping disabled on this VLAN");
>>> +		return -EINVAL;
>>> +	}
>> 
>> same comment about the check
>
> Ok, not exactly the same. I see that for the max case this check is used, please pull it
> in the vlan code and just drop this helper. Both read/write will be doing the same then.

OK. This actually simplifies the code quite a bit.
