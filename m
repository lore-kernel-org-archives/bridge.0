Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=WG7wAjUqAepF5ItMqejD0JSQeopv4zw5TgTzR3nTVpg=;
 b=08bbh2q2doQ/hf09T5YToBREVzd93tB1dJg+jlIcEZvH3cwaNw0qpNdLWn+A/zuNX8
 Z8fTqKdoh51qK+8sigaTMCHFoQKXa23V9rzd5g25dCU/pIkjrm+AJ5CTBDWo1QNrUglM
 caEA76zCeUAC2BVn4jGOkicaSI+koUtPKQ3dvSte2rHMZxRHo1xXFcwQc0NAfD+TZogS
 AHxG8BJaICXP5JunIZ+6AwE5ayH27QiI4vyOS8RtRDmFq0KgXbIxE7DjMmilTflPy5nX
 8SwX4X02D6zypf6GMr8hknSnnxAZlrQWcZzrLPGlW4BTLaD8+jxfjh3PbvPWLknwNW9v
 bnEA==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20220315165455.3nakoccbm7c7d2w5@skbuf>
References: <20220315002543.190587-1-tobias@waldekranz.com>
 <20220315002543.190587-4-tobias@waldekranz.com>
 <20220315165455.3nakoccbm7c7d2w5@skbuf>
Date: Tue, 15 Mar 2022 23:35:03 +0100
Message-ID: <878rtalu94.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v4 net-next 03/15] net: bridge: mst: Support
 setting and reporting MST port states
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 18:54, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Tue, Mar 15, 2022 at 01:25:31AM +0100, Tobias Waldekranz wrote:
>> Make it possible to change the port state in a given MSTI by extending
>> the bridge port netlink interface (RTM_SETLINK on PF_BRIDGE).The
>> proposed iproute2 interface would be:
>> 
>>     bridge mst set dev <PORT> msti <MSTI> state <STATE>
>> 
>> Current states in all applicable MSTIs can also be dumped via a
>> corresponding RTM_GETLINK. The proposed iproute interface looks like
>> this:
>> 
>> $ bridge mst
>> port              msti
>> vb1               0
>> 		    state forwarding
>> 		  100
>> 		    state disabled
>> vb2               0
>> 		    state forwarding
>> 		  100
>> 		    state forwarding
>> 
>> The preexisting per-VLAN states are still valid in the MST
>> mode (although they are read-only), and can be queried as usual if one
>> is interested in knowing a particular VLAN's state without having to
>> care about the VID to MSTI mapping (in this example VLAN 20 and 30 are
>> bound to MSTI 100):
>> 
>> $ bridge -d vlan
>> port              vlan-id
>> vb1               10
>> 		    state forwarding mcast_router 1
>> 		  20
>> 		    state disabled mcast_router 1
>> 		  30
>> 		    state disabled mcast_router 1
>> 		  40
>> 		    state forwarding mcast_router 1
>> vb2               10
>> 		    state forwarding mcast_router 1
>> 		  20
>> 		    state forwarding mcast_router 1
>> 		  30
>> 		    state forwarding mcast_router 1
>> 		  40
>> 		    state forwarding mcast_router 1
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>> +static int br_mst_process_one(struct net_bridge_port *p,
>> +			      const struct nlattr *attr,
>> +			      struct netlink_ext_ack *extack)
>> +{
>> +	struct nlattr *tb[IFLA_BRIDGE_MST_ENTRY_MAX + 1];
>> +	u16 msti;
>> +	u8 state;
>> +	int err;
>> +
>> +	err = nla_parse_nested(tb, IFLA_BRIDGE_MST_ENTRY_MAX, attr,
>> +			       br_mst_nl_policy, extack);
>> +	if (err)
>> +		return err;
>> +
>> +	if (!tb[IFLA_BRIDGE_MST_ENTRY_MSTI]) {
>> +		NL_SET_ERR_MSG_MOD(extack, "MSTI not specified");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!tb[IFLA_BRIDGE_MST_ENTRY_STATE]) {
>> +		NL_SET_ERR_MSG_MOD(extack, "State not specified");
>> +		return -EINVAL;
>> +	}
>> +
>> +	msti = nla_get_u16(tb[IFLA_BRIDGE_MST_ENTRY_MSTI]);
>> +	state = nla_get_u8(tb[IFLA_BRIDGE_MST_ENTRY_STATE]);
>> +
>> +	br_mst_set_state(p, msti, state);
>
> Is there any reason why this isn't propagating the error?

No, we definitely should. Thanks.

>> +	return 0;
>> +}
