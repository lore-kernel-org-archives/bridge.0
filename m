Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=yZXiD6hS6mJeLTwuxQbRhcKg3gd8jZak9MF/XHZfC80=;
 b=PInE7sNH3FAw4VBYjgCxQeCZGyzeISgqmm8oc6aAxEeLc57fWstxSXYsgSHoUoPc1H
 aBUk2pP6pp1/zBjKwlLgLVhICf0t97exUkqTqsYQ2AP0gQ74x9Rf8hNxwNNdSiduM+gG
 KfiFkcKz5VQY2HEuMc38UuAQWb40syXvkBYBVLg/5t02c/Un500zw1s6i4B9AHc4YHEb
 w4bItCDYpunWpwvsj8/4gQouWrfhtWGtQTE2rOZOCJRL5VhOfRGkBmFFqcNm3YlH4IIw
 ZRK8JFB4qmi8vJcAKp/u6YB14RU4Z5lBM9HIsLlMNnqlFaHrUCcdgVLmylgRZXp8thDt
 tbgg==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20220303222742.si2gksy3tzagsc7r@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-3-tobias@waldekranz.com>
 <20220303222742.si2gksy3tzagsc7r@skbuf>
Date: Mon, 07 Mar 2022 15:54:17 +0100
Message-ID: <877d95olt2.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2 net-next 02/10] net: bridge: mst: Allow
 changing a VLAN's MSTI
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

On Fri, Mar 04, 2022 at 00:27, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Tue, Mar 01, 2022 at 11:03:13AM +0100, Tobias Waldekranz wrote:
>> Allow a VLAN to move out of the CST (MSTI 0), to an independent tree.
>> 
>> The user manages the VID to MSTI mappings via a global VLAN
>> setting. The proposed iproute2 interface would be:
>> 
>>     bridge vlan global set dev br0 vid <VID> msti <MSTI>
>> 
>> Changing the state in non-zero MSTIs is still not supported, but will
>> be addressed in upcoming changes.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>
>> +static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
>> +{
>> +	struct net_bridge_vlan_group *vg = nbp_vlan_group(pv->port);
>> +	struct net_bridge_vlan *v;
>> +
>> +	list_for_each_entry(v, &vg->vlan_list, vlist) {
>> +		/* If this port already has a defined state in this
>> +		 * MSTI (through some other VLAN membership), inherit
>> +		 * it.
>> +		 */
>> +		if (v != pv && v->brvlan->msti == msti) {
>> +			br_mst_vlan_set_state(pv->port, pv, v->state);
>> +			return;
>> +		}
>> +	}
>> +
>> +	/* Otherwise, start out in a new MSTI with all ports disabled. */
>> +	return br_mst_vlan_set_state(pv->port, pv, BR_STATE_DISABLED);
>> +}
>> +
>> +int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
>> +{
>> +	struct net_bridge_vlan_group *vg;
>> +	struct net_bridge_vlan *pv;
>> +	struct net_bridge_port *p;
>
> No attempt to detect non-changes to the MSTI, and exit early? In a later
> patch you will also notify switchdev uselessly because of this.

Yeah you're right. Will fix in v3. Thanks
